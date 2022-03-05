import 'dart:async';

import 'package:chitter_chatter/modules/login_module/login_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  late Timer timer;
  @override
  void onReady() {
    timer = Timer(Duration(seconds: 3), (){
      Get.offNamed(LoginScreen.route);
    });
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}