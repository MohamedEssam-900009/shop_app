import 'package:flutter/material.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';

import 'modules/on_boarding_screen/on_boarding_screen.dart';

void main() {
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop App',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnBoardingScreen(),
      
    );
  }
}
