import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class UserModel {
  int user_id;
  String user_nama;
  String user_email;
  String user_no_telp;
  String user_password;
  String user_role;
  int user_saldo;

  UserModel({
    required this.user_id,
    required this.user_nama,
    required this.user_email,
    required this.user_no_telp,
    required this.user_password,
    required this.user_role,
    required this.user_saldo,
  });
}

class UserCubit extends Cubit<UserModel> {
  final String url_login = "http://localhost:8000/login/";

  UserCubit()
      : super(
          UserModel(
            user_id: 0,
            user_nama: "",
            user_email: "",
            user_no_telp: "",
            user_password: "",
            user_role: "",
            user_saldo: 0,
          ),
        ) {
    getUser();
  }

  Future<void> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') == null) {
      emit(
        UserModel(
          user_id: 0,
          user_nama: "",
          user_email: "",
          user_no_telp: "",
          user_password: "",
          user_role: "",
          user_saldo: 0,
        ),
      );
    } else {
      Map<String, dynamic> decodedToken =
          Jwt.parseJwt(prefs.getString('token') ?? "");

      emit(
        UserModel(
          user_id: decodedToken['user_id'],
          user_nama: decodedToken['user_nama'],
          user_email: decodedToken['user_email'],
          user_no_telp: decodedToken['user_no_telp'],
          user_password: decodedToken['user_password'],
          user_role: decodedToken['user_role'],
          user_saldo: decodedToken['user_saldo'],
        ),
      );
    }
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

      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

      emit(
        UserModel(
          user_id: decodedToken['user_id'],
          user_nama: decodedToken['user_nama'],
          user_email: decodedToken['user_email'],
          user_no_telp: decodedToken['user_no_telp'],
          user_password: decodedToken['user_password'],
          user_role: decodedToken['user_role'],
          user_saldo: decodedToken['user_saldo'],
        ),
      );
    } else {
      print('Login failed with status code ${response.statusCode}');
    }
  }

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    emit(
      UserModel(
        user_id: 0,
        user_nama: '',
        user_email: '',
        user_no_telp: '',
        user_password: '',
        user_role: '',
        user_saldo: 0,
      ),
    );
  }
}
