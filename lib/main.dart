import 'package:chitter_chatter/constants/colors/app_colors.dart';
import 'package:chitter_chatter/essential.dart';
import 'package:chitter_chatter/modules/splash_module/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'modules/login_module/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner:false,
              theme: ThemeData(               
                primarySwatch: AppColors.primaryColor,
              ),
              getPages: [
                GetPage(name: '/', page: ()=>SplashScreen()),
                GetPage(name: LoginScreen.route, page: ()=>LoginScreen())
              ],          
            ));
  }
}
