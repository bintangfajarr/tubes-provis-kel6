import 'package:flutter/material.dart';

class InvestorDocumentPage extends StatefulWidget {
  const InvestorDocumentPage({super.key});

  @override
  State<InvestorDocumentPage> createState() => _InvestorDocumentPageState();
}

class _InvestorDocumentPageState extends State<InvestorDocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Dokumen",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            "Download Dokumen",
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          Text(
            "Lihat laporan transaksi 12 bulan terakhir",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.description_rounded,
                      color: Color.fromARGB(255, 0, 97, 175),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "April 2023",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromARGB(255, 0, 97, 175),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.file_download),
                            color: Color(0xff0061af),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.description_rounded,
                      color: Color.fromARGB(255, 0, 97, 175),
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Maret 2023",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Color.fromARGB(255, 0, 97, 175),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.file_download),
                            color: Color(0xff0061af),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
