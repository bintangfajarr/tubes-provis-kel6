import 'package:flutter/material.dart';

class BorrowerTagihanPage extends StatefulWidget {
  const BorrowerTagihanPage({Key? key}) : super(key: key);

  @override
  State<BorrowerTagihanPage> createState() => _BorrowerTagihanPageState();
}

class _BorrowerTagihanPageState extends State<BorrowerTagihanPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color.fromARGB(250, 250, 250, 250),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 97, 175, 1),
                  Color.fromRGBO(18, 62, 99, 1),
                ],
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Tagihan Saya",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            tabs: [
              Tab(
                text: 'Belum Lunas',
              ),
              Tab(
                text: 'Lunas',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Tagihan Berikutnya",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                    height: 68,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Maret',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                            Text(
                              'Jatuh tempo pada 25 Maret 2023',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 17),
                          child: Text(
                            "Rp. 500.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 97, 175),
                            ),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 1, 10),
                    // width: 335,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Februari',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                            Text(
                              'Jatuh tempo pada 25 Februari 2023',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 17),
                          child: Text(
                            "Rp. 1.000.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 97, 175),
                            ),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "2023",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                    // width: 335,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Januari',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                            Text(
                              'Jatuh tempo pada 25 Januari 2023',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 17),
                          child: Text(
                            "Rp. 500.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 97, 175),
                            ),
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.arrow_forward_ios_rounded),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "2022",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(1, 10, 1, 10),
                    // width: 335,
                    height: 68,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x3f000000),
                          offset: Offset(0, 0),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Desember',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                            Text(
                              'Jatuh tempo pada 25 Desember 2022',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 0, 97, 175),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 17),
                          child: Text(
                            "Rp. 500.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 0, 97, 175),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios_rounded),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Color.fromARGB(255, 0, 97, 175),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
