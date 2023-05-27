import 'package:flutter/material.dart';
import 'package:tubes/pages/investor/home.dart';
import 'package:tubes/pages/login.dart';
import 'package:tubes/pages/register.dart';
import 'package:tubes/pages/contoh.dart';
import 'package:tubes/pages/temp.dart';
import 'package:tubes/pages/landing.dart';
import 'package:tubes/pages/kebijakanreg.dart';
import 'package:tubes/pages/syaratketentuan.dart';
import 'package:tubes/pages/contoh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: LandingPage(),
      ),
    );
  }
}
