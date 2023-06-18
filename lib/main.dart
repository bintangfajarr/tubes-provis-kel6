import 'package:flutter/material.dart';
import 'package:tubes/classes/pemilik.dart';
// import 'package:tubes/pages/borrower/funding/funding_borrower.dart';
// import 'package:tubes/pages/borrower/home/home_borrower.dart';
// import 'package:tubes/pages/borrower/portofolio/portofolio_borrower.dart';
// import 'package:tubes/pages/investor/Investor.dart';
// import 'package:tubes/pages/investor/home/home_investor.dart';
// import 'package:tubes/pages/investor/marketplace/detailmitra_investor.dart';
import 'package:tubes/pages/middleware.dart';
// import 'package:tubes/pages/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/auth.dart';
// import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider<PemilikCubit>(
          create: (BuildContext context) => PemilikCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Middleware(),
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//         child: BorrowerPage(),
//       ),
//     );
//   }
// }
