import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:tubes/pages/investor/marketplace/market_investor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/pendanaan.dart';
import 'package:tubes/classes/auth.dart';
import 'package:tubes/classes/format.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Investor.dart';

enum modal { nominal1, nominal2, nominal3, nominal4, nominal5 }

class DetailMitraPage extends StatefulWidget {
  const DetailMitraPage({super.key});
  @override
  State<DetailMitraPage> createState() => _DetailMitraPageState();
}

class _DetailMitraPageState extends State<DetailMitraPage> {
  String textFieldValue = "";
  final TextEditingController _textEditingController = TextEditingController();
  int biayaModal = 1000;

  int valueNominal = 0;
  int result = 0;

  modal? macamModal;

  Future<void> investasi(
    int proyek_id,
    int valueProyek,
    int user_id,
    int valueUser,
    int value,
  ) async {
    final url_proyek = "http://localhost:8000/update_proyek/$proyek_id";

    final Map<String, dynamic> proyekData = {
      "proyek_terkumpul": valueProyek + value,
    };

    final responseProyek = await http.patch(
      Uri.parse(url_proyek),
      body: jsonEncode(proyekData),
      headers: {'Content-Type': 'application/json'},
    );

    if (responseProyek.statusCode == 200) {
      print('Proyek Updated');
    } else {
      throw Exception('Gagal update proyek');
    }

    final url_user = "http://localhost:8000/update_user/$user_id";

    final Map<String, dynamic> userData = {
      "user_saldo": valueUser - value,
    };

    final responseUser = await http.patch(
      Uri.parse(url_user),
      body: jsonEncode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (responseUser.statusCode == 200) {
      print('User Updated');
    } else {
      throw Exception('Gagal update user');
    }

    final url_investasi = "http://localhost:8000/insert_investasi/";

    final Map<String, dynamic> investasiData = {
      "user_id": user_id,
      "proyek_id": proyek_id,
      "investasi_nilai": value,
      "investasi_waktu": DateTime.now().toString(),
      "tanggal_transaksi": DateTime.now().toString(),
    };

    final responseInvestasi = await http.post(
      Uri.parse(url_investasi),
      body: jsonEncode(investasiData),
      headers: {'Content-Type': 'application/json'},
    );

    if (responseInvestasi.statusCode == 200) {
      print('Investasi Updated');
    } else {
      throw Exception('Gagal update investasi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      appBar: AppBar(
        elevation: 0,
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
          "Detail Mitra",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocBuilder<PendanaanCubit, PendanaanModel>(
        buildWhen: (previousState, state) {
          developer.log("${previousState.proyek_id} -> ${state.proyek_id}",
              name: 'reloadlog');
          return true;
        },
        builder: (context, pendanaan) {
          return ListView(
            padding: EdgeInsets.fromLTRB(16, 30, 16, 10),
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                margin: EdgeInsets.only(right: 10),
                width: 335,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 0, 97, 175),
                                    Color.fromARGB(255, 102, 178, 226)
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 54,
                              width: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/dagang.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pendanaan.pemilik_nama,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    pendanaan.umkm_nama,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 12,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        pendanaan.umkm_kota,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontSize: 10,
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
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Plafond",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Rp" +
                                  Format.moneyFormat(pendanaan.proyek_target),
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "%Bagi Hasil",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pendanaan.proyek_bagi_hasil.toString() + "%",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Tenor",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              pendanaan.proyek_tenor.toString() + " Minggu",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text(
                      "Tentang Mitra",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black))),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tenor Pendanaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          pendanaan.proyek_tenor.toString() + "Minggu",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bagi Hasil",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Rp" +
                              Format.moneyFormat((pendanaan.proyek_target *
                                      (pendanaan.proyek_bagi_hasil / 100))
                                  .toInt()),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jenis Angsuran",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Mingguan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Jumlah Angsuran",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Rp" +
                              Format.moneyFormat((pendanaan.proyek_target +
                                      (pendanaan.proyek_target *
                                              (pendanaan.proyek_bagi_hasil /
                                                  100))
                                          .toInt()) ~/
                                  pendanaan.proyek_tenor),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Penghasilan perbulan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Rp" +
                              Format.moneyFormat(pendanaan.pemilik_penghasilan),
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pekerjaan",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          pendanaan.pemilik_pekerjaan,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sektor",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          pendanaan.umkm_kategori,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Resiko Pendanaan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Setiap industri yang digeluti oleh Mitra Usaha kamu memiliki risikonya masing-masing. Beriku adalah beberapa risiko yang dihadapi oleh Mitra Usaha ini yang perlu anda ketahui:",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "1. Dipengaruhi oleh kompetisi antar penjual yang mengakibatkan berkurangnya permintaan penjualan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "2. Keadaan ekonomi makro di Negara tersebut melambat",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      "3. Perbedaan karakteristik permintaan dan kurangnya pengetahuan di market yang menyebabkan menurunnya penjualan",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 12,
                        width: 230,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        height: 12,
                        width: (pendanaan.proyek_terkumpul /
                                pendanaan.proyek_target) *
                            230,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 97, 175),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        height: 12,
                        child: Text(
                          "Rp" + Format.moneyFormat(pendanaan.proyek_terkumpul),
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 8,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Text(
                    "3 Hari lagi",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      hintText: "Masukkan Nominal",
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1.0),
                      ),
                    ),
                    onChanged: (value) {
                      setState(
                        () {
                          textFieldValue = value;
                          valueNominal = int.parse(value);
                          result = biayaModal;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            macamModal = modal.nominal1;
                            _textEditingController.text = '500.000';
                            textFieldValue = '500.000';
                            valueNominal = 500000;
                          });
                        },
                        child: Text(
                          "Rp500 rb",
                          style: TextStyle(
                            color: macamModal == modal.nominal1
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: macamModal == modal.nominal1
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.white,
                          onPrimary:
                              Colors.blue, // Change the onPrimary color to blue
                          side: BorderSide(
                            color: macamModal == modal.nominal1
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color.fromARGB(255, 0, 162, 255),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            macamModal = modal.nominal2;
                            _textEditingController.text = '1.000.000';
                            textFieldValue = '1.000.000';
                            valueNominal = 1000000;
                          });
                        },
                        child: Text(
                          "Rp1 jt",
                          style: TextStyle(
                            color: macamModal == modal.nominal2
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: macamModal == modal.nominal2
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.white,
                          onPrimary:
                              Colors.blue, // Change the onPrimary color to blue
                          side: BorderSide(
                            color: macamModal == modal.nominal2
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color.fromARGB(255, 0, 162, 255),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            macamModal = modal.nominal3;
                            _textEditingController.text = '2.000.000';
                            textFieldValue = '2.000.000';
                            valueNominal = 2000000;
                          });
                        },
                        child: Text(
                          "Rp2 jt",
                          style: TextStyle(
                            color: macamModal == modal.nominal3
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: macamModal == modal.nominal3
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.white,
                          onPrimary:
                              Colors.blue, // Change the onPrimary color to blue
                          side: BorderSide(
                            color: macamModal == modal.nominal3
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color.fromARGB(255, 0, 162, 255),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            macamModal = modal.nominal4;
                            _textEditingController.text = "MAX";
                          });
                        },
                        child: Text(
                          "Max",
                          style: TextStyle(
                            color: macamModal == modal.nominal4
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: macamModal == modal.nominal4
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.white,
                          onPrimary:
                              Colors.blue, // Change the onPrimary color to blue
                          side: BorderSide(
                            color: macamModal == modal.nominal4
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color.fromARGB(255, 0, 162, 255),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            macamModal = modal.nominal5;
                            _textEditingController.clear();
                            textFieldValue = "";
                          });
                        },
                        child: Text(
                          "Nominal Lain",
                          style: TextStyle(
                            color: macamModal == modal.nominal5
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: macamModal == modal.nominal5
                              ? Color.fromARGB(255, 0, 97, 175)
                              : Colors.white,
                          onPrimary:
                              Colors.blue, // Change the onPrimary color to blue
                          side: BorderSide(
                            color: macamModal == modal.nominal5
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color.fromARGB(255, 0, 162, 255),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dana Tersedia Rp. 0",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "Sisa Plafond Rp. 1.500.000",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        builder: (context) => Container(
                          height: 400,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          pendanaan.umkm_nama,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          "Rp ${textFieldValue}",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          pendanaan.pemilik_nama,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          child: Text(
                                            "CROWDFUNDING",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xff0061af),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 10, bottom: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Akad Pendanaan",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Lihat Dokumen",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                              Color(0xff0061af),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      textAlign: TextAlign.justify,
                                      "Saya mengerti dan menyetujui syarat dan ketentuan pendanaan dan dengan ini setuju untuk melanjutkan ke proses pembayaran",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black12,
                                thickness: 3,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Pembayaran",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Subtotal",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Rp ${textFieldValue}",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Dana Tersedia",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "Rp 0",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Divider(
                                color: Colors.black12,
                                thickness: 3,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: BlocBuilder<UserCubit, UserModel>(
                                  builder: (context, user) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        if (user.user_saldo < valueNominal) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 0, 97, 175),
                                              content: Text(
                                                "Saldo tidak cukup!",
                                                style: TextStyle(
                                                  fontFamily: "Poppins",
                                                ),
                                              ),
                                            ),
                                          );
                                          return;
                                        }
                                        investasi(
                                          pendanaan.proyek_id,
                                          pendanaan.proyek_terkumpul,
                                          user.user_id,
                                          user.user_saldo,
                                          valueNominal,
                                        );
                                        context.read<UserCubit>().saveUser(
                                              user.user_email,
                                              user.user_password,
                                            );
                                        context
                                            .read<ListPendanaanCubit>()
                                            .fetchData();

                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          text: 'Pembayaran Berhasil',
                                          confirmBtnColor:
                                              Color.fromARGB(255, 0, 97, 175),
                                          onConfirmBtnTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return InvestorPage();
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Text(
                                        "Modalin",
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Color.fromARGB(255, 0, 97, 175),
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                          Size(256.0, 48.0),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Modalin Mitra",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
            ],
          );
        },
      ),
    );
  }
}
