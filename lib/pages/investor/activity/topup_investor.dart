import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/classes/auth.dart';
import 'package:http/http.dart' as http;

enum harga { nominal1, nominal2, nominal3, nominal4 }

enum metode { metode1, metode2, metode3, metode4 }

class InvestorTopUpPage extends StatefulWidget {
  const InvestorTopUpPage({super.key});

  @override
  State<InvestorTopUpPage> createState() => _InvestorTopUpPageState();
}

class _InvestorTopUpPageState extends State<InvestorTopUpPage> {
  String textFieldValue = "";
  int biayaTransaksi = 1000;

  int valueNominal = 0;
  int result = 0;

  harga? macamHarga;
  metode? macamMetode;

  Future<void> topUpSaldo(int value) async {
    final prefs = await SharedPreferences.getInstance();
    final String? user_id = prefs.getString('user_id');
    final url = 'http://localhost:8000/update_user/$user_id';

    final Map<String, dynamic> topUpData = {
      "user_nama": "kosong",
      "user_email": "kosong",
      "user_no_telp": "kosong",
      "user_password": "kosong",
      "user_role": "kosong",
      'user_saldo': value,
    };

    final response = await http.patch(
      Uri.parse(url),
      body: jsonEncode(topUpData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Top up saldo berhasil!');
    } else {
      print('Error saat top up saldo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Top Up Saldo",
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
            "Nominal Top Up",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              hintText: "0",
              border: UnderlineInputBorder(
                borderSide: BorderSide(width: 1.0),
              ),
            ),
            onChanged: (value) {
              setState(
                () {
                  textFieldValue = value;
                  valueNominal = int.parse(value);
                  result = biayaTransaksi;
                },
              );
            },
            controller: TextEditingController(
              text: textFieldValue,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamHarga == harga.nominal1
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: harga.nominal1,
                            groupValue: macamHarga,
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            onChanged: (harga? value) {
                              setState(() {
                                macamHarga = value!;
                                textFieldValue = '50.000';
                                valueNominal = 50000;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Rp50.000'),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamHarga == harga.nominal2
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: harga.nominal2,
                            groupValue: macamHarga,
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            onChanged: (harga? value) {
                              setState(() {
                                macamHarga = value;
                                textFieldValue = '100.000';
                                valueNominal = 100000;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Rp100.000'),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamHarga == harga.nominal3
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: harga.nominal3,
                            groupValue: macamHarga,
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            onChanged: (harga? value) {
                              setState(() {
                                macamHarga = value;
                                textFieldValue = '500.000';
                                valueNominal = 500000;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Rp500.000'),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamHarga == harga.nominal4
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: harga.nominal4,
                            groupValue: macamHarga,
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            onChanged: (harga? value) {
                              setState(() {
                                macamHarga = value;
                                textFieldValue = '1.000.000';
                                valueNominal = 1000000;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Rp1.000.000'),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Metode Pembayaran",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 97, 175),
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamMetode == metode.metode1
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffbcd9f1),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            value: metode.metode1,
                            groupValue: macamMetode,
                            onChanged: (metode? value) {
                              setState(() {
                                macamMetode = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'GoPay',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamMetode == metode.metode2
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffbcd9f1),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            value: metode.metode2,
                            groupValue: macamMetode,
                            onChanged: (metode? value) {
                              setState(() {
                                macamMetode = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'BCA Virtual Account',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: macamMetode == metode.metode3
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.black54,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xffbcd9f1),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Color.fromARGB(255, 0, 97, 175),
                            value: metode.metode3,
                            groupValue: macamMetode,
                            onChanged: (metode? value) {
                              setState(() {
                                macamMetode = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              'Indomaret',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Rincian pembayaran",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Nominal Top Up",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    'Rp${textFieldValue}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Biaya Transaksi",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    'Rp${biayaTransaksi.toString()}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Tagihan",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    'Rp${result.toString()}',
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      topUpSaldo(valueNominal);
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          backgroundColor: Color.fromARGB(255, 0, 97, 175),
                          content: Text(
                            "Top Up Saldo Berhasil!",
                            style: TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      );
                    });
                  },
                  child: Text(
                    "Bayar",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
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
          ),
        ],
      ),
    );
  }
}
