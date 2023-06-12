import 'package:flutter/material.dart';

class InvestorWithdrawPage extends StatefulWidget {
  const InvestorWithdrawPage({super.key});

  @override
  State<InvestorWithdrawPage> createState() => _InvestorWithdrawPageState();
}

class _InvestorWithdrawPageState extends State<InvestorWithdrawPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          "Tarik Saldo",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Text(
            "Tarik Dana",
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "Rp",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsetsDirectional.all(10),
                          border: InputBorder.none,
                          hintText: "0",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dana tersedia",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "Rp 0",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Tarik Saldo",
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Informasi Rekening Saya",
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
                    "Bank",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "-",
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
                    "Pemilik Akun",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "-",
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
                    "No. Rekening",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    "-",
                    style: TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
