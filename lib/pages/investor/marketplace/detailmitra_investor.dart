import 'package:flutter/material.dart';

import 'package:tubes/pages/investor/marketplace/market_investor.dart';

enum modal { nominal1, nominal2, nominal3, nominal4, nominal5 }

class DetailMitraPage extends StatefulWidget {
  const DetailMitraPage({super.key});
  @override
  State<DetailMitraPage> createState() => _DetailMitraPageState();
}

class _DetailMitraPageState extends State<DetailMitraPage> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) {
                  return InvestorMarketplacePage();
                },
              ),
            );
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Detail Mitra",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              color: Colors.black),
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
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black))),
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
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Resiko Pendanaan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Setiap industri yang digeluti oleh Mitra Usaha kamu memiliki risikonya masing-masing. Beriku adalah beberapa risiko yang dihadapi oleh Mitra Usaha ini yang perlu anda ketahui:",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  "1. Dipengaruhi oleh kompetisi antar penjual yang mengakibatkan berkurangnya permintaan penjualan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2. Keadaan ekonomi makro di Negara tersebut melambat",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  "3. Perbedaan karakteristik permintaan dan kurangnya pengetahuan di market yang menyebabkan menurunnya penjualan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    height: 12,
                    width: 230,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  Container(
                    height: 12,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 97, 175),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    height: 12,
                    child: Text(
                      "Rp. 4.000.000",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 8,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              Text(
                "3 Hari lagi",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  hintText: "Masukkan Nominal",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(width: 1.0),
                  ),
                ),
                onChanged: (value) {
                  setState(
                    () {
                      textFieldValue = value;
                      valueNominal = int.parse(value);
                      result = biayaModal;
                    },
                  );
                },
                controller: _textEditingController,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        macamModal = modal.nominal1;
                        _textEditingController.text = '500.000';
                      });
                    },
                    child: Text(
                      "Rp500 rb",
                      style: TextStyle(
                        color: macamModal == modal.nominal1
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: macamModal == modal.nominal1
                          ? Color.fromARGB(255, 0, 97, 175)
                          : Colors.white,
                      onPrimary:
                          Colors.blue, // Change the onPrimary color to blue
                      side: BorderSide(
                        color: macamModal == modal.nominal1
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 162, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        macamModal = modal.nominal2;
                        _textEditingController.text = '1.000.000';
                      });
                    },
                    child: Text(
                      "Rp1 jt",
                      style: TextStyle(
                        color: macamModal == modal.nominal2
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: macamModal == modal.nominal2
                          ? Color.fromARGB(255, 0, 97, 175)
                          : Colors.white,
                      onPrimary:
                          Colors.blue, // Change the onPrimary color to blue
                      side: BorderSide(
                        color: macamModal == modal.nominal2
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 162, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        macamModal = modal.nominal3;
                        _textEditingController.text = '2.000.000';
                      });
                    },
                    child: Text(
                      "Rp2 jt",
                      style: TextStyle(
                        color: macamModal == modal.nominal3
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: macamModal == modal.nominal3
                          ? Color.fromARGB(255, 0, 97, 175)
                          : Colors.white,
                      onPrimary:
                          Colors.blue, // Change the onPrimary color to blue
                      side: BorderSide(
                        color: macamModal == modal.nominal3
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 162, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        macamModal = modal.nominal4;
                        _textEditingController.text = 'MAX';
                      });
                    },
                    child: Text(
                      "Max",
                      style: TextStyle(
                        color: macamModal == modal.nominal4
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: macamModal == modal.nominal4
                          ? Color.fromARGB(255, 0, 97, 175)
                          : Colors.white,
                      onPrimary:
                          Colors.blue, // Change the onPrimary color to blue
                      side: BorderSide(
                        color: macamModal == modal.nominal4
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 162, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        macamModal = modal.nominal5;
                        _textEditingController.clear();
                      });
                    },
                    child: Text(
                      "Nominal Lain",
                      style: TextStyle(
                        color: macamModal == modal.nominal5
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: macamModal == modal.nominal5
                          ? Color.fromARGB(255, 0, 97, 175)
                          : Colors.white,
                      onPrimary:
                          Colors.blue, // Change the onPrimary color to blue
                      side: BorderSide(
                        color: macamModal == modal.nominal5
                            ? Color.fromARGB(255, 255, 255, 255)
                            : Color.fromARGB(255, 0, 162, 255),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dana Tersedia Rp. 0",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "Sisa Plafond Rp. 1.500.000",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 10,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return InvestorMarketplacePage();
                      },
                    ),
                  );
                },
                child: Text("Modalin Mitra"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 0, 97, 175),
                  ),
                  fixedSize: MaterialStateProperty.all(
                    Size(256.0, 32.0),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
