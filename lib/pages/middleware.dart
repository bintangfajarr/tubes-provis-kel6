import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/auth.dart';
import 'package:tubes/pages/landing.dart';
import 'package:tubes/pages/investor/Investor.dart';
import 'package:tubes/pages/borrower/borrower.dart';

class Middleware extends StatelessWidget {
  const Middleware({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserModel>(
      builder: (context, user) {
        if (user.user_role == "borrower") {
          return BorrowerPage();
        } else if (user.user_role == "investor") {
          return InvestorPage();
        } else {
          return LandingPage();
        }
      },
    );
  }
}
