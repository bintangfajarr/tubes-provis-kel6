import 'package:flutter/material.dart';

class InvestorPortofolioPage extends StatefulWidget {
  const InvestorPortofolioPage({super.key});

  @override
  State<InvestorPortofolioPage> createState() => _InvestorPortofolioPageState();
}

class _InvestorPortofolioPageState extends State<InvestorPortofolioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            height: 154,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(0, 97, 175, 1),
                  Color.fromRGBO(18, 62, 99, 1),
                ],
              ),
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Portofolio",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total Asetmu",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Rp 0",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Total Profit Rp 0",
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            // Add padding around the search bar
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // Use a Material design search bar
            child: Text(
              "Mitra Pendanaanmu",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Table(
              children: [
                TableRow(
                  children: [
                    Text('Mitra'),
                    Text('Sisa Pokok(Rp)'),
                    Text('Bagi Hasil(Rp)'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
