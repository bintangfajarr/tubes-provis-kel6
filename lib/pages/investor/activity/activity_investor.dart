import 'package:flutter/material.dart';
import 'package:tubes/pages/investor/activity/document_investor.dart';
import 'package:tubes/pages/investor/activity/ringkasan_investor.dart';
import 'package:tubes/pages/investor/activity/topup_investor.dart';
import 'package:tubes/pages/investor/activity/withdraw_investor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/auth.dart';
import 'package:tubes/classes/format.dart';
import 'dart:developer' as developer;

class InvestorActivityPage extends StatefulWidget {
  @override
  State<InvestorActivityPage> createState() => _InvestorActivityPageState();
}

class _InvestorActivityPageState extends State<InvestorActivityPage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserModel>(
        buildWhen: (previousState, state) {
          developer.log("${previousState.user_id} -> ${state.user_id}",
              name: 'reloadlog');
          return true;
        },
        builder: (context, user) {
          return ListView(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    height: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 10),
                    child: Text(
                      "Activity",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Column(
                        children: [
                          Text(
                            "Dana Tersedia",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Rp " + Format.moneyFormat(user.user_saldo),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          height: 100,
                          margin: EdgeInsets.only(right: 16.0, left: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return InvestorTopUpPage();
                                              },
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                            Icons.add_circle_outline_rounded),
                                        color: Color(0xff0061af),
                                        iconSize: 35,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Top Up",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xff0061af),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return InvestorWithdrawPage();
                                              },
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                            Icons.arrow_circle_down_outlined),
                                        color: Color(0xff0061af),
                                        iconSize: 35,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Withdraw",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xff0061af),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return InvestorDocumentPage();
                                              },
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.file_copy_outlined),
                                        color: Color(0xff0061af),
                                        iconSize: 35,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "Document",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xff0061af),
                                          ),
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(48, 10, 48, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return InvestorRingkasanTransaksiPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Ringkasan Transaksi",
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
              )
            ],
          );
        },
      ),
    );
  }
}
