import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/pages/investor/account/account_investor.dart';
import 'package:tubes/pages/investor/home/home_investor.dart';
import 'package:tubes/pages/investor/marketplace/market_investor.dart';
import 'package:tubes/pages/investor/portofolio/portofolio_investor.dart';
import 'package:tubes/pages/login.dart';
import 'package:tubes/classes/auth.dart';

import 'activity/activity_investor.dart';

class InvestorPage extends StatefulWidget {
  const InvestorPage({super.key});

  @override
  State<InvestorPage> createState() => _InvestorPageState();
}

class _InvestorPageState extends State<InvestorPage> {
  int index = 0;

  List showWidget = [
    InvestorHomePage(),
    InvestorPortofolioPage(),
    InvestorMarketplacePage(),
    InvestorActivityPage(),
    InvestorAccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
