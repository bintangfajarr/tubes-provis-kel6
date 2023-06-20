import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'changepw_borrower.dart';
import 'kebijakanreg_borrower.dart';
import 'pusatbantuan_borrower.dart';
import 'risikopendanaan_borrower.dart';
import 'syaratketentuan_borrower.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tubes/pages/landing.dart';
import 'package:tubes/classes/auth.dart';
import 'dart:developer' as developer;

class BorrowerAccountPage extends StatefulWidget {
  BorrowerAccountPage({
    super.key,
  });

  @override
  State<BorrowerAccountPage> createState() => _BorrowerAccountPageState();
}

class _BorrowerAccountPageState extends State<BorrowerAccountPage> {
  File? image;

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagePicked =
        await picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 100,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Account",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            text: TextSpan(
                              text: "Halo",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: ", ",
                                ),
                                TextSpan(
                                  text: user.user_nama,
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    height: 142,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 36,
                          ),
                          image != null
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(53),
                                      child: Container(
                                        width: 106,
                                        height: 106,
                                        color: Colors.white,
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.file(
                                        image!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -7,
                                      left: 61,
                                      child: IconButton(
                                        onPressed: () async {
                                          await getImage();
                                        },
                                        icon: Icon(Icons.edit_square),
                                        color: Color.fromRGBO(0, 97, 175, 1),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(53),
                                      child: Container(
                                        width: 106,
                                        height: 106,
                                        color: Colors.white,
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: 53,
                                      backgroundImage: NetworkImage(
                                        'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                      ),
                                      backgroundColor: Colors.white,
                                    ),
                                    Positioned(
                                      bottom: -7,
                                      left: 61,
                                      child: IconButton(
                                        onPressed: () async {
                                          await getImage();
                                        },
                                        icon: Icon(Icons.edit_square),
                                        color: Color.fromRGBO(0, 97, 175, 1),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black12,
                thickness: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Informasi Akun",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.user_email,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 97, 175, 1)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return BorrowerChangePasswordPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Ganti Password",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "No. Handphone",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user.user_no_telp,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Surat Perjanjian Pendanaan",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(167, 167, 167, 1)),
                      onPressed: () {},
                      child: Text(
                        "Dokumen",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 3,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Informasi Akun Bank",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Akun Bank Saya",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "BCA",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.black12,
                thickness: 3,
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Text(
                  "Informasi Lainnya",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins'),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pusat Bantuan",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PusatBantuanPage();
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Resiko Pendanaan",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return RisikoPendanaanPage();
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Syarat & Ketentuan",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return SyaratKetentuanPage();
                                  },
                                ),
                              );
                            },
                            icon: Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Kebijakan Regulasi",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return KebijakanRegulasiPage();
                                },
                              ),
                            );
                          },
                          icon: Icon(Icons.arrow_forward_ios),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 32, right: 32, top: 20, bottom: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(0, 97, 175, 1)),
                  onPressed: () {
                    context.read<UserCubit>().deleteUser().then((_) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return LandingPage();
                          },
                        ),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
