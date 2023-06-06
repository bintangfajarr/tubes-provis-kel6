import 'package:flutter/material.dart';
import 'package:tubes/pages/investor/topup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/pages/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          0,
          0,
          0,
          79,
        ),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 412,
                height: 186,
                child: BlocBuilder<UserCubit, UserModel>(
                  buildWhen: (previousState, state) {
                    developer.log(
                        "${previousState.user_id} -> ${state.user_id}",
                        name: 'reloadlog');
                    return true;
                  },
                  builder: (context, user) {
                    context.read<UserCubit>().fetchData();
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            height: 138,
                            decoration: BoxDecoration(
                              color: Color(0xffbcd9f1),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 19),
                            child: Text(
                              'Hi, ' + user.user_nama + '!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15, top: 14),
                            child: Icon(
                              Icons.notifications_none_rounded,
                              size: 25,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 55),
                            child: Text(
                              'Total asetmu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                height: 1.5,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 90),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 8,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Color(0xff000000),
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Total profit ',
                                  ),
                                  TextSpan(
                                    text: 'Rp ' + user.user_saldo.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 8,
                                      fontWeight: FontWeight.w400,
                                      height: 1.5,
                                      color: Color(0xff05ff00),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, top: 70),
                            child: Text(
                              'Rp ' + user.user_saldo.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                color: Color(0xff000000),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 84, top: 57),
                            child: Icon(
                              Icons.error_outline_rounded,
                              size: 12.52,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 7, top: 107, right: 7),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 13, 20, 0),
                              width: 399,
                              height: 77,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 252, 252),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3f000000),
                                    offset: Offset(0, 4),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          color: Color(0xff000000),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Saldo Aktif\n',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Rp 0',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              height: 1.5,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(30, 0, 20, 0),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return TopUpPage();
                                                    },
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons
                                                  .account_balance_wallet_outlined),
                                              color: Color(0xff0061af),
                                              iconSize: 30,
                                            ),
                                            Text(
                                              'Deposit',
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff0061af),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons
                                                .arrow_circle_down_outlined),
                                            color: Color(0xff0061af),
                                            iconSize: 30,
                                          ),
                                          Text(
                                            'Withdraw',
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff0061af),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rekomendasi UMKM",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            color: Color.fromARGB(255, 0, 97, 175),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                          margin: EdgeInsets.only(right: 10),
                          width: 335,
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          borderRadius:
                                              BorderRadius.circular(50),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Fauzan Ahmad",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Modal Tani Sawit",
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
                                                  "Riau",
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
                                  IconButton(
                                    padding:
                                        EdgeInsets.only(bottom: 20.0, left: 30),
                                    iconSize: 30,
                                    onPressed: () {},
                                    icon:
                                        Icon(Icons.add_circle_outline_rounded),
                                    color: Color.fromARGB(255, 0, 97, 175),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        "Rp.5.000.000",
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
                                        "11.5%",
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
                                        "50 Minggu",
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
                                            width: 230,
                                            height: 16,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: LinearProgressIndicator(
                                                backgroundColor:
                                                    Colors.grey[300],
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color.fromARGB(
                                                      255, 0, 97, 175),
                                                ),
                                                value: 0.8,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            height: 12,
                                            width: 200,
                                            child: Text(
                                              "Rp. 4.000.000",
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontSize: 10,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              "Wishlist",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.shopping_cart_checkout_rounded,
                  size: 60,
                ),
                Text(
                  "Anda belum menambahkan wishlist",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Tambah"),
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
            ),
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: index,
      //   selectedItemColor: const Color.fromARGB(255, 0, 97, 175),
      //   unselectedItemColor: Colors.grey[300],
      //   onTap: (value) {
      //     setState(() {
      //       index = value;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.pie_chart_rounded), label: "Portofolio"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.shopping_cart), label: "Marketplace"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.dashboard_rounded), label: "Activity"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle_rounded), label: "Account"),
      //   ],
      // ),
    );
  }
}
