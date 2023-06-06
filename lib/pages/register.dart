import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum roleType { investor, borrower }

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final telpController = TextEditingController();
  final passwordController = TextEditingController();

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
  void dispose() {
    // controller dibersihkan saat widget dibuang
    namaController.dispose();
    emailController.dispose();
    telpController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  late Future<int> respPost; //201 artinya berhasil
  String url = "http://127.0.0.1:8000/insert_user/";

  @override
  void initState() {
    super.initState();
    respPost = Future.value(0); //init
  }

  Future<void> insertUser(String nama, String email, String noTelp,
      String password, String role, int saldo) async {
    final url = 'http://localhost:8000/insert_user/';

    final Map<String, dynamic> userData = {
      'user_nama': nama,
      'user_email': email,
      'user_no_telp': noTelp,
      'user_password': password,
      'user_role': role,
      'user_saldo': saldo,
    };

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // User inserted successfully
      register();
      print('User berhasil ditambahkan');
    } else {
      // Error occurred while inserting user
      print('Error saat menambahkan user');
    }
  }

  void register() {
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
  }

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
            controller: namaController,
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
            controller: emailController,
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
            controller: passwordController,
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
            controller: telpController,
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
                  onPressed: () {
                    setState(() {
                      insertUser(
                          namaController.text,
                          emailController.text,
                          telpController.text,
                          passwordController.text,
                          "admin",
                          0); //jika return 201 artinya sukses
                    });
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
