import 'package:flutter/material.dart';
import 'package:tubes/pages/investor/account.dart';
import 'package:tubes/pages/investor/home.dart';
import 'package:tubes/pages/investor/market.dart';

import 'investor/activity.dart';

class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {
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
    HomePage(),
    const Center(
      child: Text("Portofolio"),
    ),
    MarketPlacePage(),
    ActivityPage(),
    AccountPage(),
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
        selectedLabelStyle: TextStyle(
          decoration: TextDecoration.underline,
          decorationThickness: 2.0,
        ),
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
