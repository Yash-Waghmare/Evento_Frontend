import 'package:events/routes.dart';
import 'package:events/screens/home_screen.dart';
import 'package:events/screens/bottomNavgation_bar.dart';


import 'package:events/screens/profile_screen.dart';

import 'package:events/screens/signin_screen.dart';

import 'package:events/screens/profile_screen.dart';
import 'package:events/screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      // onGenerateRoute: Routes.onGenerateRoute,
      // initialRoute: SignInScreen.routeName,
      home: bottomnavigation_bar(),
    );
  }
}
