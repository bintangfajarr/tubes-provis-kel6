import 'package:flutter/material.dart';
import 'package:tubes/classes/auth.dart';
import 'package:tubes/classes/invest.dart';
import 'package:tubes/classes/pendanaan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:tubes/classes/format.dart';
import 'package:auto_size_text/auto_size_text.dart';

class InvestorPortofolioPage extends StatefulWidget {
  const InvestorPortofolioPage({super.key});

  @override
  State<InvestorPortofolioPage> createState() => _InvestorPortofolioPageState();
}

class _InvestorPortofolioPageState extends State<InvestorPortofolioPage> {
  int totalAset = 0;
  int totalProfit = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(250, 250, 250, 250),
      body: BlocBuilder<UserCubit, UserModel>(
        builder: (context, user) {
          return BlocBuilder<ListInvestasiCubit, ListInvestasiModel>(
            builder: (context, model) {
              context.read<ListInvestasiCubit>().fetchDataUser(user.user_id);
              if (model.listInvestasiModel.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                totalAset = 0;
                totalProfit = 0;
                for (var i = 0; i < model.listInvestasiModel.length; i++) {
                  totalAset += model.listInvestasiModel[i].investasi_nilai;
                  totalProfit += (model.listInvestasiModel[i].investasi_nilai *
                          (model.listInvestasiModel[i].proyek_bagi_hasil / 100))
                      .toInt();
                }
                return ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      height: 154,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
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
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Portofolio",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Total Asetmu",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Rp" + Format.moneyFormat(totalAset),
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Total Profit Rp" +
                                      Format.moneyFormat(totalProfit),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        "Mitra Pendanaanmu",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Table(
                        children: [
                          TableRow(
                            children: [
                              Text(
                                'Mitra',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Jumlah Investasi',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Bagi Hasil',
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          for (var i = 0;
                              i < model.listInvestasiModel.length;
                              i++)
                            TableRow(
                              children: [
                                Text(
                                  model.listInvestasiModel[i].umkm_nama,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  "Rp" +
                                      Format.moneyFormat(model
                                          .listInvestasiModel[i]
                                          .investasi_nilai),
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                Text(
                                  "Rp" +
                                      Format.moneyFormat((model
                                                  .listInvestasiModel[i]
                                                  .investasi_nilai *
                                              (model.listInvestasiModel[i]
                                                      .proyek_bagi_hasil /
                                                  100))
                                          .toInt()) +
                                      " (" +
                                      model.listInvestasiModel[i]
                                          .proyek_bagi_hasil
                                          .toString() +
                                      "%)",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
