import 'package:flutter/material.dart';

enum modal { nominal1, nominal2, nominal3, nominal4, nominal5 }

class BorrowerDetailMitraPage extends StatefulWidget {
  const BorrowerDetailMitraPage({super.key});
  @override
  State<BorrowerDetailMitraPage> createState() =>
      _BorrowerDetailMitraPageState();
}

class _BorrowerDetailMitraPageState extends State<BorrowerDetailMitraPage> {
  String textFieldValue = "";
  final TextEditingController _textEditingController = TextEditingController();
  int biayaModal = 1000;

  int valueNominal = 0;
  int result = 0;

  modal? macamModal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Detail Mitra",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 30, 16, 10),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            margin: EdgeInsets.only(right: 10),
            width: 335,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.black,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 0, 97, 175),
                                Color.fromARGB(255, 102, 178, 226)
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/dagang.jpg',
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Fauzan Ahmad",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Modal Tani Sawit",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Riau",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Plafond",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Rp.5.000.000",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "%Bagi Hasil",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "11.5%",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Tenor",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "50 Minggu",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  "Tentang Mitra",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black),
              ),
            ),
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Tenor Pendanaan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "50 Minggu",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bagi Hasil",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Rp. 750.000",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jenis Angsuran",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Mingguan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jumlah Angsuran",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Rp. 135.000",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Penghasilan perbulan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Rp. 975.000",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pekerjaan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Tani Sawit",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sektor",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Pertanian",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
