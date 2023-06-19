import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

class MarketplaceModel {
  int pemilik_id;
  int user_id;
  String pemilik_nama;
  String pemilik_nik;
  String pemlikik_tempat_lahir;
  String pemilik_tanggal_lahir;
  String pemilik_jenis_kelamin;
  String pemilik_alamat;
  String pemilik_pekerjaan;
  int pemilik_penghasilan;
  int umkm_id;
  int user_id2;
  int pemilik_id2;
  String umkm_nama;
  String umkm_kategori;
  String umkm_alamat;
  int umkm_foto;
  String umkm_deskripsi;
  int proyek_id;
  int umkm_id2;
  int proyek_target;
  int proyek_terkumpul;
  String proyek_tgl_masuk;
  String proyek_tgl_keluar;
  int proyek_bagi_hasil;
  int proyek_tenor;

  MarketplaceModel({
    required this.pemilik_id,
    required this.user_id,
    required this.pemilik_nama,
    required this.pemilik_nik,
    required this.pemlikik_tempat_lahir,
    required this.pemilik_tanggal_lahir,
    required this.pemilik_jenis_kelamin,
    required this.pemilik_alamat,
    required this.pemilik_pekerjaan,
    required this.pemilik_penghasilan,
    required this.umkm_id,
    required this.user_id2,
    required this.pemilik_id2,
    required this.umkm_nama,
    required this.umkm_kategori,
    required this.umkm_alamat,
    required this.umkm_foto,
    required this.umkm_deskripsi,
    required this.proyek_id,
    required this.umkm_id2,
    required this.proyek_target,
    required this.proyek_terkumpul,
    required this.proyek_tgl_masuk,
    required this.proyek_tgl_keluar,
    required this.proyek_bagi_hasil,
    required this.proyek_tenor,
  });
}

class MarketplaceCubit extends Cubit<MarketplaceModel> {
  MarketplaceCubit()
      : super(MarketplaceModel(
            pemilik_id: 0,
            user_id: 0,
            pemilik_nama: "",
            pemilik_nik: "",
            pemlikik_tempat_lahir: "",
            pemilik_tanggal_lahir: "",
            pemilik_jenis_kelamin: "",
            pemilik_alamat: "",
            pemilik_pekerjaan: "",
            pemilik_penghasilan: 0,
            umkm_id: 0,
            user_id2: 0,
            pemilik_id2: 0,
            umkm_nama: "",
            umkm_kategori: "",
            umkm_alamat: "",
            umkm_foto: 0,
            umkm_deskripsi: "",
            proyek_id: 0,
            umkm_id2: 0,
            proyek_target: 0,
            proyek_terkumpul: 0,
            proyek_tgl_masuk: "",
            proyek_tgl_keluar: "",
            proyek_bagi_hasil: 0,
            proyek_tenor: 0));

  void setFromJson(Map<String, dynamic> json) {
    var pemilik_id = json["pemilik_id"];
    var user_id = json["user_id"];
    var pemilik_nama = json["pemilik_nama"];
    var pemilik_nik = json["pemilik_nik"];
    var pemlikik_tempat_lahir = json["pemlik_tempat_lahir"];
    var pemilik_tanggal_lahir = json["pemilik_tanggal_lahir"];
    var pemilik_jenis_kelamin = json["pemilik_jenis_kelamin"];
    var pemilik_alamat = json["pemilik_alamat"];
    var pemilik_pekerjaan = json["pemilik_pekerjaan"];
    var pemilik_penghasilan = json["pemilik_penghasilan"];
    var umkm_id = json["umkm_id"];
    var user_id2 = json["user_id"];
    var pemilik_id2 = json["pemilik_id"];
    var umkm_nama = json["umkm_nama"];
    var umkm_kategori = json["umkm_kategori"];
    var umkm_alamat = json["umkm_alamat"];
    var umkm_foto = json["umkm_foto"];
    var umkm_deskripsi = json["umkm_deskripsi"];
    var proyek_id = json["proyek_id"];
    var umkm_id2 = json["umkm_id"];
    var proyek_target = json["proyek_target"];
    var proyek_terkumpul = json["proyek_terkumpul"];
    var proyek_tgl_masuk = json["proyek_tgl_masuk"];
    var proyek_tgl_keluar = json["proyek_tgl_keluar"];
    var proyek_bagi_hasil = json["proyek_bagi_hasil"];
    var proyek_tenor = json["proyek_tenor"];

    emit(MarketplaceModel(
      pemilik_id: pemilik_id,
      user_id: user_id,
      pemilik_nama: pemilik_nama,
      pemilik_nik: pemilik_nik,
      pemlikik_tempat_lahir: pemlikik_tempat_lahir,
      pemilik_tanggal_lahir: pemilik_tanggal_lahir,
      pemilik_jenis_kelamin: pemilik_jenis_kelamin,
      pemilik_alamat: pemilik_alamat,
      pemilik_pekerjaan: pemilik_pekerjaan,
      pemilik_penghasilan: pemilik_penghasilan,
      user_id2: user_id2,
      pemilik_id2: pemilik_id2,
      umkm_nama: umkm_nama,
      umkm_kategori: umkm_kategori,
      umkm_alamat: umkm_alamat,
      umkm_foto: umkm_foto,
      umkm_deskripsi: umkm_deskripsi,
      proyek_id: proyek_id,
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

class ListMarketplaceModel {
  List<MarketplaceModel> listMarketplaceModel = <MarketplaceModel>[];
  ListMarketplaceModel({required this.listMarketplaceModel});
}

class ListMarketplaceCubit extends Cubit<ListMarketplaceModel> {
  String url = "http://localhost:8000/get_marketplace_data";

  ListMarketplaceCubit()
      : super(ListMarketplaceModel(listMarketplaceModel: []));

  void setFromJson(Map<String, dynamic> json) {
    List<MarketplaceModel> listMarketplaceModel = <MarketplaceModel>[];
    var data = json["data"];
    for (var val in data) {
      var pemilik_id = val[0];
      var user_id = val[1];
      var pemilik_nama = val[2];
      var pemilik_nik = val[3];
      var pemlikik_tempat_lahir = val[4];
      var pemilik_tanggal_lahir = val[5];
      var pemilik_jenis_kelamin = val[6];
      var pemilik_alamat = val[7];
      var pemilik_pekerjaan = val[8];
      var pemilik_penghasilan = val[9];
      var umkm_id = val[10];
      var user_id2 = val[11];
      var pemilik_id2 = val[12];
      var umkm_nama = val[13];
      var umkm_kategori = val[14];
      var umkm_alamat = val[15];
      var umkm_foto = val[16];
      var umkm_deskripsi = val[17];
      var proyek_id = val[18];
      var umkm_id2 = val[19];
      var proyek_target = val[20];
      var proyek_terkumpul = val[21];
      var proyek_tgl_masuk = val[22];
      var proyek_tgl_keluar = val[23];
      var proyek_bagi_hasil = val[24];
      var proyek_tenor = val[25];

      listMarketplaceModel.add(
        MarketplaceModel(
          pemilik_id: pemilik_id,
          user_id: user_id,
          pemilik_nama: pemilik_nama,
          pemilik_nik: pemilik_nik,
          pemlikik_tempat_lahir: pemlikik_tempat_lahir,
          pemilik_tanggal_lahir: pemilik_tanggal_lahir,
          pemilik_jenis_kelamin: pemilik_jenis_kelamin,
          pemilik_alamat: pemilik_alamat,
          pemilik_pekerjaan: pemilik_pekerjaan,
          pemilik_penghasilan: pemilik_penghasilan,
          umkm_id: umkm_id,
          user_id2: user_id2,
          pemilik_id2: pemilik_id2,
          umkm_nama: umkm_nama,
          umkm_kategori: umkm_kategori,
          umkm_alamat: umkm_alamat,
          umkm_foto: umkm_foto,
          umkm_deskripsi: umkm_deskripsi,
          proyek_id: proyek_id,
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
    emit(ListMarketplaceModel(listMarketplaceModel: listMarketplaceModel));
  }

  void fetchData() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setFromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal load');
    }
  }
}
