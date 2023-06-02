import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                    width: 412,
                    height: 240,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: 412,
                            height: 193,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xffbcd9f1),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(16, 13, 0, 0),
                            child: SizedBox(
                              width: 74,
                              height: 29,
                              child: Text(
                                'Activity',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              height: 70,
                              child: Text(
                                'DANA TERSEDIA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 2,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: SizedBox(
                              width: 48,
                              height: 30,
                              child: Text(
                                'Rp 0',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(40, 142, 0, 0),
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                            width: 335,
                            height: 98,
                            decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x3f000000),
                                  offset: Offset(0, 0),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        width: 39,
                                        height: 39,
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          size: 39,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                      Text(
                                        'Top up',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.arrow_circle_down_outlined,
                                          size: 40,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                      Text(
                                        'Withdraw',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.file_copy_outlined,
                                          size: 40,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                      Text(
                                        'Document',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          height: 1.5,
                                          color: Color(0xff0061af),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(52, 0, 44, 0),
                    width: 335,
                    height: 37,
                    decoration: BoxDecoration(
                      color: Color(0xff0061af),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Ringkasan transaksi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: index,
      //   selectedItemColor: const Color.fromARGB(255, 0, 97, 175),
      //   unselectedItemColor: Colors.grey[300],
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.pie_chart_rounded), label: "Portofolio"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label: "Marketplace"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.dashboard_rounded), label: "Activity"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle_rounded), label: "Account"),
      //   ],
      // ),
    );
  }
}
