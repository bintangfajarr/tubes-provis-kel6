/* import */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

import 'app.dart';

class UserModel {
  int user_id;
  String user_nama;
  String user_no_telp;
  String user_password;
  String user_role;
  int user_saldo;

  UserModel(
      {required this.user_id,
      required this.user_nama,
      required this.user_no_telp,
      required this.user_password,
      required this.user_role,
      required this.user_saldo});
}

class UserCubit extends Cubit<UserModel> {
  String url = "http://localhost:8000/select_user/";

  UserCubit()
      : super(UserModel(
            user_id: 0,
            user_nama: "",
            user_no_telp: "",
            user_password: "",
            user_role: "",
            user_saldo: 0));

  void setFromJson(Map<String, dynamic> json) {
    int user_id = json['user_id'];
    String user_nama = json['user_nama'];
    String user_no_telp = json['user_no_telp'];
    String user_password = json['user_password'];
    String user_role = json['user_role'];
    int user_saldo = json['user_saldo'];

    emit(UserModel(
        user_id: user_id,
        user_nama: user_nama,
        user_no_telp: user_no_telp,
        user_password: user_password,
        user_role: user_role,
        user_saldo: user_saldo));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mengambil data user');
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          const SizedBox(
            height: 60,
          ),

          //foto
          Column(
            children: [
              Image.asset(
                "assets/images/LogoPromvis1.png",
                alignment: Alignment.topCenter,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 140,
          ),

          //email
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: const Icon(Icons.email),
              hintText: "Masukkan Email",
              labelText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          //password
          TextField(
            controller: passwordController,
            obscureText: isHidden,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: () {
                    if (isHidden == true) {
                      isHidden = false;
                    } else {
                      isHidden = true;
                    }
                    setState(() {});
                  },
                  icon: const Icon(Icons.remove_red_eye)),
              hintText: "Masukkan Password",
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          const SizedBox(
            height: 100,
          ),

          //button
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MyAppPage();
                        },
                      ),
                    );
                  },
                  child: Text("Login"),
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Belum punya akun?",
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
                        return RegisterPage();
                      },
                    ),
                  );
                },
              text: "Register disini",
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 97, 175),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
