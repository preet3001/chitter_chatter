import 'package:chitter_chatter/constants/firebase_constants.dart';
import 'package:chitter_chatter/modules/login_module/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status {
  uninitialized,
  authenticated,
  authenticating,
  authenticateError,
  authenticateCanceled,
}

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final box = GetStorage();
  var _status = Status.uninitialized;
  loginWithGoogle() async {
    try {
      _status = Status.authenticating;
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        User? firebaseUser =
            (await _auth.signInWithCredential(credential)).user;
        if (firebaseUser != null) {
          final QuerySnapshot result = await firebaseFirestore
              .collection(FirestoreConstants.pathUserCollection)
              .where(FirestoreConstants.id, isEqualTo: firebaseUser.uid)
              .get();
          final List<DocumentSnapshot> documents = result.docs;
          if (documents.length == 0) {
            // Writing data to server because here is a new user
            firebaseFirestore
                .collection(FirestoreConstants.pathUserCollection)
                .doc(firebaseUser.uid)
                .set({
              FirestoreConstants.nickname: firebaseUser.displayName,
              FirestoreConstants.photoUrl: firebaseUser.photoURL,
              FirestoreConstants.id: firebaseUser.uid,
              'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
              //FirestoreConstants.chattingWith: null
            });

            // Write data to local storage
            User? currentUser = firebaseUser;
            await box.write(
                FirestoreConstants.nickname, currentUser.displayName ?? "");
            await box.write(
                FirestoreConstants.photoUrl, currentUser.photoURL ?? "");
          } else {
            // Already sign up, just get data from firestore
            DocumentSnapshot documentSnapshot = documents[0];
            UserModel userChat = UserModel.fromDocument(documentSnapshot);
            // Write data to local
            await box.write(FirestoreConstants.id, userChat.id);
            await box.write(FirestoreConstants.nickname, userChat.nickname);
            await box.write(FirestoreConstants.photoUrl, userChat.photoUrl);
            await box.write(FirestoreConstants.aboutMe, userChat.aboutMe);
          }
          _status = Status.authenticated;
          return true;
        } else {
          _status = Status.authenticateError;
          return false;
        }
      } else {
        _status = Status.authenticateCanceled;
        return false;
      }
    } catch (e) {
      throw (e);
    }
  }

  signOut()async {
    _status = Status.uninitialized;
    await _auth.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
  }
}
