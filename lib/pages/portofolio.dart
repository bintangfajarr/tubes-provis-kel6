import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PortofolioPage extends StatefulWidget {
  const PortofolioPage({super.key});

  @override
  State<PortofolioPage> createState() => _PortofolioPage();
}

class _PortofolioPage extends State<PortofolioPage> {
  int index = 0;
  final TextEditingController _searchController = TextEditingController();

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
    const Center(
      child: Text("Home"),
    ),
    ListView(
      children: [
        Container(
          width: 412,
          height: 186,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 412,
                  height: 138,
                  decoration: BoxDecoration(
                    color: Color(0xffbcd9f1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 19),
                  child: Text(
                    'Portofolio',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 55),
                  child: Text(
                    'Total asetmu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 90),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 8,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                        color: Color(0xff000000),
                      ),
                      children: [
                        TextSpan(
                          text: 'Total profit ',
                        ),
                        TextSpan(
                          text: 'Rp 0',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Color(0xff05ff00),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 70),
                  child: Text(
                    'Rp 0',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 84, top: 57),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 12.52,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 107),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    const Center(
      child: Text("Marketplace"),
    ),
    const Center(
      child: Text("Activity"),
    ),
    const Center(
      child: Text("Account"),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 188, 217, 241),
        title: Text(
          _getAppBarTitle(index),
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: showWidget[index],
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
                icon: Icon(Icons.home_filled), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart_rounded), label: "Portofolio"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "Marketplace"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded), label: "Activity"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Account"),
          ]),
    );
  }
}
