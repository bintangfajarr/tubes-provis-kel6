import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class InvestorWithdrawPage extends StatefulWidget {
  const InvestorWithdrawPage({super.key});

  @override
  State<InvestorWithdrawPage> createState() => _InvestorWithdrawPageState();
}

class _InvestorWithdrawPageState extends State<InvestorWithdrawPage> {
  var danaController = TextEditingController();

  Future<void> withdrawSaldo(int user_id, int value) async {
    final url = 'http://localhost:8000/update_user/$user_id';

    final Map<String, dynamic> topUpData = {
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
          "Tarik Saldo",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<UserCubit, UserModel>(
        buildWhen: (previousState, state) {
          developer.log("${previousState.user_id} -> ${state.user_id}",
              name: 'reloadlog');
          return true;
        },
        builder: (context, user) {
          return ListView(
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
                            controller: danaController,
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
                    onPressed: () {
                      withdrawSaldo(
                        user.user_id,
                        user.user_saldo - int.parse(danaController.text),
                      );
                      context.read<UserCubit>().saveUser(
                            user.user_email,
                            user.user_password,
                          );
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
                            "Withdraw Saldo Berhasil!",
                            style: TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      );
                    },
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
          );
        },
      ),
    );
  }
}
