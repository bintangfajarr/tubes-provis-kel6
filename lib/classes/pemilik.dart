import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decode/jwt_decode.dart';

class PemilikModel {
  int pemilik_id;
  String pemilik_nama;
  String pemilik_email;
  String pemilik_no_telp;
  String pemilik_password;
  String pemilik_role;
  int pemilik_saldo;

  PemilikModel({
    required this.pemilik_id,
    required this.pemilik_nama,
    required this.pemilik_email,
    required this.pemilik_no_telp,
    required this.pemilik_password,
    required this.pemilik_role,
    required this.pemilik_saldo,
  });
}

class PemilikCubit extends Cubit<PemilikModel> {
  final String url_login = "http://localhost:8000/login/";

  PemilikCubit()
      : super(
          PemilikModel(
            pemilik_id: 0,
            pemilik_nama: "",
            pemilik_email: "",
            pemilik_no_telp: "",
            pemilik_password: "",
            pemilik_role: "",
            pemilik_saldo: 0,
          ),
        ) {
    getPemilik();
  }

  Future<void> getPemilik() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString('token') == null) {
      emit(
        PemilikModel(
          pemilik_id: 0,
          pemilik_nama: "",
          pemilik_email: "",
          pemilik_no_telp: "",
          pemilik_password: "",
          pemilik_role: "",
          pemilik_saldo: 0,
        ),
      );
    } else {
      Map<String, dynamic> decodedToken =
          Jwt.parseJwt(prefs.getString('token') ?? "");

      emit(
        PemilikModel(
          pemilik_id: decodedToken['pemilik_id'],
          pemilik_nama: decodedToken['pemilik_nama'],
          pemilik_email: decodedToken['pemilik_email'],
          pemilik_no_telp: decodedToken['pemilik_no_telp'],
          pemilik_password: decodedToken['pemilik_password'],
          pemilik_role: decodedToken['pemilik_role'],
          pemilik_saldo: decodedToken['pemilik_saldo'],
        ),
      );
    }
  }

  Future<void> savePemilik(String email, String password) async {
    final response = await http.post(
      Uri.parse(url_login),
      body: jsonEncode({
        'pemilik_nama': '',
        'pemilik_email': email,
        'pemilik_no_telp': '',
        'pemilik_password': password,
        'pemilik_role': '',
        'pemilik_saldo': 0,
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
        PemilikModel(
          pemilik_id: decodedToken['pemilik_id'],
          pemilik_nama: decodedToken['pemilik_nama'],
          pemilik_email: decodedToken['pemilik_email'],
          pemilik_no_telp: decodedToken['pemilik_no_telp'],
          pemilik_password: decodedToken['pemilik_password'],
          pemilik_role: decodedToken['pemilik_role'],
          pemilik_saldo: decodedToken['pemilik_saldo'],
        ),
      );
    } else {
      print('Login failed with status code ${response.statusCode}');
    }
  }

  Future<void> deletePemilik() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    emit(
      PemilikModel(
        pemilik_id: 0,
        pemilik_nama: '',
        pemilik_email: '',
        pemilik_no_telp: '',
        pemilik_password: '',
        pemilik_role: '',
        pemilik_saldo: 0,
      ),
    );
  }
}
