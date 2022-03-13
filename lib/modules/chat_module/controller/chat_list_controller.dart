import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sn_2nd/constant.dart';
import 'package:sn_2nd/screen/chat_module/controller/chat_controller.dart';
import 'package:sn_2nd/screen/chat_module/model/conversation_model.dart';
import 'package:uuid/uuid.dart';

import '../constants/chat_constants.dart';
import 'package:async/async.dart' as StreamGroup;

class ChatListController extends GetxController {
  final ConversationDao conversationDao = ConversationDao();

  void addNewConversation(String senderId) async {
    if (true) {
      print('trying');
      Uuid uuid = Uuid();
      final conversation = ConversationModel(
          id: uuid.v1(), party1: Constants.id, party2: senderId);
      print(conversation.toJson());
      conversationDao.saveConversation(conversation);
    }
  }
}

class ConversationDao {
  late DatabaseReference _conversationRef;
  ConversationDao() {
    _conversationRef =
        FirebaseDatabase.instance.ref().child(ChatConstants.conversations);
  }

  void saveConversation(ConversationModel conversation) async {
    await _conversationRef.push().set(conversation.toJson());
  }

  Query getConversationQuery() {
    return _conversationRef;
  }

  Stream getChatListStream() {
    Stream s1 = _conversationRef
        .equalTo(Constants.id, key: ChatConstants.party1)
        .onValue;
    Stream s2 = _conversationRef
        .equalTo(Constants.id, key: ChatConstants.party2)
        .onValue;
    return StreamGroup.StreamGroup.merge([s1, s2]);
  }
}
