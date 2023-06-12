import 'package:flutter/material.dart';
import 'package:tubes/pages/borrower/account/account_borrower.dart';
import 'package:tubes/pages/borrower/activity/activity_borrower.dart';

import 'package:tubes/pages/borrower/home/home_borrower.dart';
import 'package:tubes/pages/borrower/marketplace/market_borrower.dart';
import 'package:tubes/pages/borrower/portofolio/portofolio_borrower.dart';

class BorrowerPage extends StatefulWidget {
  const BorrowerPage({super.key});

  @override
  State<BorrowerPage> createState() => _BorrowerPageState();
}

class _BorrowerPageState extends State<BorrowerPage> {
  int index = 0;

  // String _getAppBarTitle(int index) {
  //   switch (index) {
  //     case 0:
  //       return "Home";
  //     case 1:
  //       return "Portofolio";
  //     case 2:
  //       return "Marketplace";
  //     case 3:
  //       return "Activity";
  //     case 4:
  //       return "Account";
  //     default:
  //       return "";
  //   }
  // }

  List showWidget = [
    BorrowerHomePage(),
    BorrowerPortofolioPage(),
    BorrowerMarketplacePage(),
    BorrowerActivityPage(),
    BorrowerAccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   elevation: 0,
      //   backgroundColor: const Color.fromARGB(255, 188, 217, 241),
      //   title: Text(
      //     _getAppBarTitle(index),
      //     style: const TextStyle(
      //       color: Color.fromARGB(255, 0, 0, 0),
      //       fontFamily: "Poppins",
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
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
