import 'package:chitter_chatter/essential.dart';
import 'package:chitter_chatter/modules/splash_module/controller/splash_controller.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
              child: Lottie.asset("assets/lottie/splash_lottie.json",
            width: 80.w, fit: BoxFit.fitWidth),
            ),
        ));
  }
}
