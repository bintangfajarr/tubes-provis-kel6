import 'package:flutter/material.dart';
import 'package:tubes/classes/pendanaan.dart';
import 'package:tubes/pages/borrower/funding/funding_borrower.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/classes/auth.dart';
import 'dart:developer' as developer;
import 'package:tubes/classes/format.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:tubes/pages/borrower/home/notification_borrower.dart';

class BorrowerHomePage extends StatelessWidget {
  const BorrowerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: BlocBuilder<UserCubit, UserModel>(
        buildWhen: (previousState, state) {
          developer.log("${previousState.user_id} -> ${state.user_id}",
              name: 'reloadlog');
          return true;
        },
        builder: (context, user) {
          return ListView(
            children: [
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                    height: 155,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 97, 175, 1),
                          Color.fromRGBO(18, 62, 99, 1),
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              child: Text(
                                "Halo, " + user.user_nama + "!",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return BorrowerNotificationPage();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.notifications),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 110,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          height: 100,
                          margin: EdgeInsets.only(right: 16.0, left: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Tagihan Selanjutnya",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Color.fromRGBO(0, 97, 175, 1),
                                    ),
                                  ),
                                  Text(
                                    "Rp 500.000",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(0, 97, 175, 1),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.calendar_month),
                                        color: Color(0xff0061af),
                                        iconSize: 30,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "3 Juni 2020",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Color(0xff0061af),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Pendanaan",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: BlocBuilder<ListPendanaanCubit, ListPendanaanModel>(
                  builder: (context, model) {
                    context
                        .read<ListPendanaanCubit>()
                        .fetchDataUser(user.user_id);
                    if (model.listPendanaanModel.isEmpty) {
                      return Column(
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            "Kamu Belum Mengajukan\nPendanaan",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BorrowerFundingPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Ajukan",
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
                          )
                        ],
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 255, 255, 255),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 4,
                              offset: Offset(2, 4),
                            ),
                          ],
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
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "https://picsum.photos/200/300"),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AutoSizeText(
                                              model.listPendanaanModel[0]
                                                  .pemilik_nama,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              minFontSize: 10),
                                          AutoSizeText(
                                            model.listPendanaanModel[0]
                                                .umkm_nama,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                            ),
                                            maxLines: 2,
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
                                                model.listPendanaanModel[0]
                                                    .umkm_kota,
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
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      onPressed: () {
                                        context
                                            .read<PendanaanCubit>()
                                            .emitState(
                                                model.listPendanaanModel[0]);
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) {
                                        //       return DetailMitraPage();
                                        //     },
                                        //   ),
                                        // );
                                      },
                                      icon: Icon(
                                          Icons.add_circle_outline_rounded),
                                      color: Color(0xff0061af),
                                      iconSize: 30,
                                    ),
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
                                          Format.moneyFormat(model
                                              .listPendanaanModel[0]
                                              .proyek_target),
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
                                      model.listPendanaanModel[0]
                                              .proyek_bagi_hasil
                                              .toString() +
                                          "%",
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
                                      model.listPendanaanModel[0].proyek_tenor
                                              .toString() +
                                          " Minggu",
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
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          width: (model.listPendanaanModel[0]
                                                      .proyek_terkumpul /
                                                  model.listPendanaanModel[0]
                                                      .proyek_target) *
                                              230,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 0, 97, 175),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          height: 12,
                                          width: 230,
                                          child: Text(
                                            "Rp" +
                                                Format.moneyFormat(model
                                                    .listPendanaanModel[0]
                                                    .proyek_terkumpul),
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
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
