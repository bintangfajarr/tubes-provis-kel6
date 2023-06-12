import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/pages/investor/account/account_investor.dart';
import 'package:tubes/pages/investor/home/home_investor.dart';
import 'package:tubes/pages/investor/marketplace/market_investor.dart';
import 'package:tubes/pages/investor/portofolio/portofolio_investor.dart';
import 'package:tubes/pages/login.dart';

import 'activity/activity_investor.dart';

class InvestorPage extends StatefulWidget {
  const InvestorPage({super.key});

  @override
  State<InvestorPage> createState() => _InvestorPageState();
}

class _InvestorPageState extends State<InvestorPage> {
  int index = 0;

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return "Home";
      case 1:
        return "Portofolio";
      case 2:
        return "Marketplace";
      case 3:
        return "Activity";
      case 4:
        return "Account";
      default:
        return "";
    }
  }

  List showWidget = [
    BlocProvider(
      create: (_) => UserCubit(),
      child: InvestorHomePage(),
    ),
    InvestorPortofolioPage(),
    InvestorMarketplacePage(),
    InvestorActivityPage(),
    BlocProvider(
      create: (_) => UserCubit(),
      child: InvestorAccountPage(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 188, 217, 241),
        title: Text(
          _getAppBarTitle(index),
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: showWidget[index],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: const Color.fromARGB(255, 0, 97, 175),
        unselectedItemColor: Colors.grey[300],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pie_chart_rounded,
            ),
            label: "Portofolio",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: "Marketplace",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard_rounded,
            ),
            label: "Activity",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
            ),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
