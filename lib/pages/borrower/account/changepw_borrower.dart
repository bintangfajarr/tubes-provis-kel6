import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({
    super.key,
  });

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  @override
  Widget build(BuildContext context) {
    final passwordLama = TextEditingController();
    final passwordBaru = TextEditingController();
    final passwordBaru2 = TextEditingController();
    bool isHidden = true;
    bool isHidden2 = true;
    bool isHidden3 = true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ganti Password",
          style: TextStyle(
            fontFamily: "Poppins",
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: passwordLama,
            obscureText: isHidden,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (isHidden == true) {
                        isHidden = false;
                      } else {
                        isHidden = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye)),
                hintText: "Masukkan Password Lama",
                labelText: "Masukkan Password Lama",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordBaru,
            obscureText: isHidden2,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (isHidden2 == true) {
                        isHidden2 = false;
                      } else {
                        isHidden2 = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye)),
                hintText: "Masukkan Password Baru",
                labelText: "Masukkan Password Baru",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: passwordBaru2,
            obscureText: isHidden3,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    onPressed: () {
                      if (isHidden == true) {
                        isHidden = false;
                      } else {
                        isHidden = true;
                      }
                      setState(() {});
                    },
                    icon: Icon(Icons.remove_red_eye)),
                hintText: "Masukkan Kembali Password Baru",
                labelText: "Masukkan Kembali Password Baru",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 97, 175),
              ),
              onPressed: () {},
              child: const Text(
                "Ganti Password",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
