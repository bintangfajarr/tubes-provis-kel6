import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/borrower/borrower.dart';
import 'package:tubes/pages/borrower/funding/funding_borrower.dart';
import 'package:tubes/pages/borrower/home/home_borrower.dart';
import 'package:tubes/pages/borrower/portofolio/portofolio_borrower.dart';
import 'package:tubes/pages/investor/Investor.dart';
import 'package:tubes/pages/investor/home/home_investor.dart';
import 'package:tubes/pages/investor/marketplace/detailmitra_investor.dart';
import 'package:tubes/pages/landing.dart';
import 'package:tubes/pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: BorrowerPage(),
      ),
    );
  }
}
