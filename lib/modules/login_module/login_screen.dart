import 'package:chitter_chatter/constants/styles/text_styles.dart';
import 'package:chitter_chatter/essential.dart';
import 'package:chitter_chatter/modules/login_module/controller/login_controller.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static var route = '/login';
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Text(
            'Chitter Chatter',
            style: AppTextStyles.primary18Italics,
          ),
          Lottie.asset('assets/lottie/login_lottie.json',height: 20.h),
          ElevatedButton.icon(
            onPressed: (){
              _loginController.loginWithGoogle();
            }, icon: Image.asset('assets/images/google_logo.png',height: 4.h,), label: Text('Login With Google'))
        ]),
      ),
    ));
  }
}
