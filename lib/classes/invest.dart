import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestasiModel {
  int investasi_id;
  int user_id;
  int proyek_id;
  int investasi_nilai;
  String investasi_waktu;
  String tanggal_transaksi;
  int pemilik_id;
  int user_id2;
  String pemilik_nama;
  String pemilik_nik;
  String pemlikik_tempat_lahir;
  String pemilik_tanggal_lahir;
  String pemilik_jenis_kelamin;
  String pemilik_alamat;
  String pemilik_pekerjaan;
  int pemilik_penghasilan;
  int umkm_id;
  int user_id3;
  int pemilik_id2;
  String umkm_nama;
  String umkm_kategori;
  String umkm_kota;
  String umkm_alamat;
  int umkm_foto;
  String umkm_deskripsi;
  int proyek_id2;
  int umkm_id2;
  int proyek_target;
  int proyek_terkumpul;
  String proyek_tgl_masuk;
  String proyek_tgl_keluar;
  int proyek_bagi_hasil;
  int proyek_tenor;

  InvestasiModel({
    required this.investasi_id,
    required this.user_id,
    required this.proyek_id,
    required this.investasi_nilai,
    required this.investasi_waktu,
    required this.tanggal_transaksi,
    required this.pemilik_id,
    required this.user_id2,
    required this.pemilik_nama,
    required this.pemilik_nik,
    required this.pemlikik_tempat_lahir,
    required this.pemilik_tanggal_lahir,
    required this.pemilik_jenis_kelamin,
    required this.pemilik_alamat,
    required this.pemilik_pekerjaan,
    required this.pemilik_penghasilan,
    required this.umkm_id,
    required this.user_id3,
    required this.pemilik_id2,
    required this.umkm_nama,
    required this.umkm_kategori,
    required this.umkm_kota,
    required this.umkm_alamat,
    required this.umkm_foto,
    required this.umkm_deskripsi,
    required this.proyek_id2,
    required this.umkm_id2,
    required this.proyek_target,
    required this.proyek_terkumpul,
    required this.proyek_tgl_masuk,
    required this.proyek_tgl_keluar,
    required this.proyek_bagi_hasil,
    required this.proyek_tenor,
  });
}

class InvestasiCubit extends Cubit<InvestasiModel> {
  InvestasiCubit()
      : super(InvestasiModel(
            investasi_id: 0,
            user_id: 0,
            proyek_id: 0,
            investasi_nilai: 0,
            investasi_waktu: "",
            tanggal_transaksi: "",
            pemilik_id: 0,
            user_id2: 0,
            pemilik_nama: "",
            pemilik_nik: "",
            pemlikik_tempat_lahir: "",
            pemilik_tanggal_lahir: "",
            pemilik_jenis_kelamin: "",
            pemilik_alamat: "",
            pemilik_pekerjaan: "",
            pemilik_penghasilan: 0,
            umkm_id: 0,
            user_id3: 0,
            pemilik_id2: 0,
            umkm_nama: "",
            umkm_kategori: "",
            umkm_kota: "",
            umkm_alamat: "",
            umkm_foto: 0,
            umkm_deskripsi: "",
            proyek_id2: 0,
            umkm_id2: 0,
            proyek_target: 0,
            proyek_terkumpul: 0,
            proyek_tgl_masuk: "",
            proyek_tgl_keluar: "",
            proyek_bagi_hasil: 0,
            proyek_tenor: 0));

  void emitState(InvestasiModel InvestasiModel) => emit(InvestasiModel);

  void setFromJson(Map<String, dynamic> json) {
    var investasi_id = json["investasi_id"];
    var user_id = json["user_id"];
    var proyek_id = json["proyek_id"];
    var investasi_nilai = json["investasi_nilai"];
    var investasi_waktu = json["investasi_waktu"];
    var tanggal_transaksi = json["tanggal_transaksi"];
    var pemilik_id = json["pemilik_id"];
    var user_id2 = json["user_id"];
    var pemilik_nama = json["pemilik_nama"];
    var pemilik_nik = json["pemilik_nik"];
    var pemlikik_tempat_lahir = json["pemlik_tempat_lahir"];
    var pemilik_tanggal_lahir = json["pemilik_tanggal_lahir"];
    var pemilik_jenis_kelamin = json["pemilik_jenis_kelamin"];
    var pemilik_alamat = json["pemilik_alamat"];
    var pemilik_pekerjaan = json["pemilik_pekerjaan"];
    var pemilik_penghasilan = json["pemilik_penghasilan"];
    var umkm_id = json["umkm_id"];
    var user_id3 = json["user_id"];
    var pemilik_id2 = json["pemilik_id"];
    var umkm_nama = json["umkm_nama"];
    var umkm_kategori = json["umkm_kategori"];
    var umkm_kota = json["umkm_kota"];
    var umkm_alamat = json["umkm_alamat"];
    var umkm_foto = json["umkm_foto"];
    var umkm_deskripsi = json["umkm_deskripsi"];
    var proyek_id2 = json["proyek_id"];
    var umkm_id2 = json["umkm_id"];
    var proyek_target = json["proyek_target"];
    var proyek_terkumpul = json["proyek_terkumpul"];
    var proyek_tgl_masuk = json["proyek_tgl_masuk"];
    var proyek_tgl_keluar = json["proyek_tgl_keluar"];
    var proyek_bagi_hasil = json["proyek_bagi_hasil"];
    var proyek_tenor = json["proyek_tenor"];

    emit(InvestasiModel(
      investasi_id: investasi_id,
      user_id: user_id,
      proyek_id: proyek_id,
      investasi_nilai: investasi_nilai,
      investasi_waktu: investasi_waktu,
      tanggal_transaksi: tanggal_transaksi,
      pemilik_id: pemilik_id,
      user_id2: user_id,
      pemilik_nama: pemilik_nama,
      pemilik_nik: pemilik_nik,
      pemlikik_tempat_lahir: pemlikik_tempat_lahir,
      pemilik_tanggal_lahir: pemilik_tanggal_lahir,
      pemilik_jenis_kelamin: pemilik_jenis_kelamin,
      pemilik_alamat: pemilik_alamat,
      pemilik_pekerjaan: pemilik_pekerjaan,
      pemilik_penghasilan: pemilik_penghasilan,
      user_id3: user_id2,
      pemilik_id2: pemilik_id2,
      umkm_nama: umkm_nama,
      umkm_kategori: umkm_kategori,
      umkm_kota: umkm_kota,
      umkm_alamat: umkm_alamat,
      umkm_foto: umkm_foto,
      umkm_deskripsi: umkm_deskripsi,
      proyek_id2: proyek_id,
      umkm_id2: umkm_id2,
      umkm_id: umkm_id,
      proyek_target: proyek_target,
      proyek_terkumpul: proyek_terkumpul,
      proyek_tgl_masuk: proyek_tgl_masuk,
      proyek_tgl_keluar: proyek_tgl_keluar,
      proyek_bagi_hasil: proyek_bagi_hasil,
      proyek_tenor: proyek_tenor,
    ));
  }

  void fetchData() async {
    String url = "http://localhost:8000/";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}

class ListInvestasiModel {
  List<InvestasiModel> listInvestasiModel = <InvestasiModel>[];
  ListInvestasiModel({required this.listInvestasiModel});
}

class ListInvestasiCubit extends Cubit<ListInvestasiModel> {
  String url = "http://localhost:8000/get_data_Investasi";
  String url_user = "http://localhost:8000/get_investasi_user/";

  ListInvestasiCubit() : super(ListInvestasiModel(listInvestasiModel: []));

  void setFromJson(Map<String, dynamic> json) {
    List<InvestasiModel> listInvestasiModel = <InvestasiModel>[];
    var data = json["data"];
    for (var val in data) {
      var investasi_id = val[0];
      var user_id = val[1];
      var proyek_id = val[2];
      var investasi_nilai = val[3];
      var investasi_waktu = val[4];
      var tanggal_transaksi = val[5];
      var pemilik_id = val[6];
      var user_id2 = val[7];
      var pemilik_nama = val[8];
      var pemilik_nik = val[9];
      var pemilik_tempat_lahir = val[10];
      var pemilik_tanggal_lahir = val[11];
      var pemilik_jenis_kelamin = val[12];
      var pemilik_alamat = val[13];
      var pemilik_pekerjaan = val[14];
      var pemilik_penghasilan = val[15];
      var umkm_id = val[16];
      var user_id3 = val[17];
      var pemilik_id2 = val[18];
      var umkm_nama = val[19];
      var umkm_kategori = val[20];
      var umkm_kota = val[21];
      var umkm_alamat = val[22];
      var umkm_foto = val[23];
      var umkm_deskripsi = val[24];
      var proyek_id2 = val[25];
      var umkm_id2 = val[26];
      var proyek_target = val[27];
      var proyek_terkumpul = val[28];
      var proyek_tgl_masuk = val[29];
      var proyek_tgl_keluar = val[30];
      var proyek_bagi_hasil = val[31];
      var proyek_tenor = val[32];

      // var pemilik_id = val[0];
      // var user_id = val[1];
      // var pemilik_nama = val[2];
      // var pemilik_nik = val[3];
      // var pemlikik_tempat_lahir = val[4];
      // var pemilik_tanggal_lahir = val[5];
      // var pemilik_jenis_kelamin = val[6];
      // var pemilik_alamat = val[7];
      // var pemilik_pekerjaan = val[8];
      // var pemilik_penghasilan = val[9];
      // var umkm_id = val[10];
      // var user_id2 = val[11];
      // var pemilik_id2 = val[12];
      // var umkm_nama = val[13];
      // var umkm_kategori = val[14];
      // var umkm_kota = val[15];
      // var umkm_alamat = val[16];
      // var umkm_foto = val[17];
      // var umkm_deskripsi = val[18];
      // var proyek_id = val[19];
      // var umkm_id2 = val[20];
      // var proyek_target = val[21];
      // var proyek_terkumpul = val[22];
      // var proyek_tgl_masuk = val[23];
      // var proyek_tgl_keluar = val[24];
      // var proyek_bagi_hasil = val[25];
      // var proyek_tenor = val[26];

      listInvestasiModel.add(
        InvestasiModel(
          investasi_id: investasi_id,
          user_id: user_id,
          proyek_id: proyek_id,
          investasi_nilai: investasi_nilai,
          investasi_waktu: investasi_waktu,
          tanggal_transaksi: tanggal_transaksi,
          pemilik_id: pemilik_id,
          user_id2: user_id,
          pemilik_nama: pemilik_nama,
          pemilik_nik: pemilik_nik,
          pemlikik_tempat_lahir: pemilik_tempat_lahir,
          pemilik_tanggal_lahir: pemilik_tanggal_lahir,
          pemilik_jenis_kelamin: pemilik_jenis_kelamin,
          pemilik_alamat: pemilik_alamat,
          pemilik_pekerjaan: pemilik_pekerjaan,
          pemilik_penghasilan: pemilik_penghasilan,
          umkm_id: umkm_id,
          user_id3: user_id3,
          pemilik_id2: pemilik_id2,
          umkm_nama: umkm_nama,
          umkm_kategori: umkm_kategori,
          umkm_kota: umkm_kota,
          umkm_alamat: umkm_alamat,
          umkm_foto: umkm_foto,
          umkm_deskripsi: umkm_deskripsi,
          proyek_id2: proyek_id,
          umkm_id2: umkm_id2,
          proyek_target: proyek_target,
          proyek_terkumpul: proyek_terkumpul,
          proyek_tgl_masuk: proyek_tgl_masuk,
          proyek_tgl_keluar: proyek_tgl_keluar,
          proyek_bagi_hasil: proyek_bagi_hasil,
          proyek_tenor: proyek_tenor,
        ),
      );
    }
    emit(ListInvestasiModel(listInvestasiModel: listInvestasiModel));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }

  void fetchDataUser(int user_id) async {
    final response = await http.get(Uri.parse(url_user + user_id.toString()));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
