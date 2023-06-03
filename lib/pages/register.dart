import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum roleType { investor, borrower }

class _RegisterPageState extends State<RegisterPage> {
  final namaEditController = TextEditingController();
  final emailEditController = TextEditingController();
  final telpEditController = TextEditingController();
  final passwordEditController = TextEditingController();
  String _nama = "";
  String _email = "";
  String _telp = "";
  String _password = "";

  @override
  void dispose() {
    // controller dibersihkan saat widget dibuang
    namaEditController.dispose();
    emailEditController.dispose();
    telpEditController.dispose();
    passwordEditController.dispose();
    super.dispose();
  }

  Future<void> postDataToAPI() async {
    final url = Uri.parse('http://localhost:8000/insert_user/');
    final headers = {'content-type': 'application/json', 'server': 'uvicorn'};
    final body = jsonEncode({
      'user_nama': _nama,
      'user_email': _email,
      'user_no_telp': _telp,
      'user_password': _password,
      'user_role': 'admin',
      'user_saldo': 0
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        // Request successful
        print('API request successful');
      } else {
        // Error occurred
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('An error occurred: $e');
    }
  }

  bool isHidden = true;
  bool isHiddenn = true;

  roleType? jenisRole;

  List<String> bank = [
    "Bank Central Asia",
    "Bank Mandiri",
    "Bank Jago",
    "United Overseas Bank",
    "BCA Syariah",
    "Bank Negara Indonesia",
    "Bank Permata",
    "Bank Syariah Indonesia",
    "Bank Rakyat Indonesia",
    "Bank BJB",
    "Bank Maybank",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Register",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 97, 175),
            fontSize: 25,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          //nama
          TextField(
            controller: namaEditController,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.person),
              hintText: "Masukkan Nama",
              labelText: "Nama",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          TextField(
            controller: emailEditController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.email),
              hintText: "Masukkan Email",
              labelText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          //password
          TextField(
            controller: passwordEditController,
            obscureText: isHidden,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (isHidden == true) {
                        isHidden = false;
                      } else {
                        isHidden = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye)),
                hintText: "Masukkan Password",
                labelText: "Password",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),

          SizedBox(
            height: 20,
          ),

          //retype password
          TextField(
            obscureText: isHiddenn,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: () {
                  if (isHiddenn == true) {
                    isHiddenn = false;
                  } else {
                    isHiddenn = true;
                  }
                  setState(() {});
                },
                icon: Icon(Icons.remove_red_eye),
              ),
              hintText: "Ulangi Password",
              labelText: "Retype Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          //telephone
          TextField(
            controller: telpEditController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.phone),
              hintText: "Masukkan No. Telephone",
              labelText: "Telephone",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          //bank
          Container(
            height: 47.0,
            child: DropdownSearch<String>(
              mode: Mode.DIALOG,
              showSelectedItem: true,
              items: bank,
              label: "Pilih Bank",
              hint: "Pilih Bank",
              showSearchBox: true,
              showClearButton: true,
              popupTitle: Container(
                padding: EdgeInsets.all(14.0),
                child: Text(
                  "Pilihan Bank",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              popupShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              popupItemBuilder: (context, item, isSelected) {
                return Container(
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromARGB(255, 230, 230, 230),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    item,
                    textAlign: TextAlign.left,
                  ),
                );
              },
            ),
          ),

          SizedBox(
            height: 20,
          ),

          //rekening
          TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.wallet),
              hintText: "Masukkan No. Rekening",
              labelText: "Rekening",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          //role
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: roleType.investor,
                            groupValue: jenisRole,
                            onChanged: (roleType? value) {
                              setState(() {
                                jenisRole = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Investor'),
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
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Radio(
                            value: roleType.borrower,
                            groupValue: jenisRole,
                            onChanged: (roleType? value) {
                              setState(() {
                                jenisRole = value;
                              });
                            },
                          ),
                          Expanded(
                            child: Text('Borrower'),
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
            height: 70,
          ),

          //button
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    _nama = namaEditController.text;
                    _email = emailEditController.text;
                    _telp = telpEditController.text;
                    _password = passwordEditController.text;

                    await postDataToAPI();

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
                          "Berhasil Membuat Akun",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    );
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Register",
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
          SizedBox(
            height: 20,
          ),
          Text(
            "Sudah memiliki akun?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                text: "Login disini",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 97, 175),
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
