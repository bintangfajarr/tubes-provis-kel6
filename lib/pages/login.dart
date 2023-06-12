/* import */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/pages/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:jwt_decode/jwt_decode.dart';

import 'investor/Investor.dart';

class UserModel {
  int user_id;
  String user_nama;
  String user_email;
  String user_no_telp;
  String user_password;
  String user_role;
  int user_saldo;

  UserModel(
      {required this.user_id,
      required this.user_nama,
      required this.user_email,
      required this.user_no_telp,
      required this.user_password,
      required this.user_role,
      required this.user_saldo});
}

class UserCubit extends Cubit<UserModel> {
  final String url = "http://localhost:8000/select_user/";
  final String url_login = "http://localhost:8000/login/";

  UserCubit()
      : super(UserModel(
            user_id: 0,
            user_nama: "",
            user_email: "",
            user_no_telp: "",
            user_password: "",
            user_role: "",
            user_saldo: 0));

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> decodedToken =
        Jwt.parseJwt(prefs.getString('token') ?? "");

    emit(UserModel(
        user_id: decodedToken['user_id'],
        user_nama: decodedToken['user_nama'],
        user_email: decodedToken['user_email'],
        user_no_telp: decodedToken['user_no_telp'],
        user_password: decodedToken['user_password'],
        user_role: decodedToken['user_role'],
        user_saldo: decodedToken['user_saldo']));
  }

  Future<void> saveUser(String email, String password) async {
    final response = await http.post(
      Uri.parse(url_login),
      body: jsonEncode({
        'user_nama': '',
        'user_email': email,
        'user_no_telp': '',
        'user_password': password,
        'user_role': '',
        'user_saldo': 0,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      emit(UserModel(
          user_id: 0,
          user_nama: '',
          user_email: email,
          user_no_telp: '',
          user_password: password,
          user_role: '',
          user_saldo: 0));
    } else {
      print('Login failed with status code ${response.statusCode}');
    }
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    emit(UserModel(
        user_id: 0,
        user_nama: '',
        user_email: '',
        user_no_telp: '',
        user_password: '',
        user_role: '',
        user_saldo: 0));
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

  void _login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    context
        .read<UserCubit>()
        .saveUser(emailController.text, passwordController.text)
        .then((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return InvestorPage();
          },
        ),
      );
    }).catchError((error) {
      print('Login failed: $error');
    });
  }

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
                    _login();
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
