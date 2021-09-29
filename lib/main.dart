import 'package:flutter/material.dart';
import 'package:foodtest/Pages/cart_page.dart';
import 'package:foodtest/pages/user_home.dart';

import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Test',
      home: LoginPage(),
      routes: {
        LoginPage.pageName : (_)=>LoginPage(),
        UserHome.pageName : (_)=>UserHome(),
      },
    );
  }
}
