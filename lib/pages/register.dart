import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/login.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isHidden = true;
  bool isHiddenn = true;
  late String selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(40),
        children: [
          SizedBox(
            height: 60,
            //child: Container(color: Colors.amber),
          ),
          Column(
            children: [
              Image.asset(
                "assets/images/LogoPromvis1.png",
                alignment: Alignment.topCenter,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          SizedBox(height: 80),
          TextField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.email),
              hintText: "Masukkan Email",
              labelText: "Email",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
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
                hintText: "Masukkan Password",
                labelText: "Password",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
          ),
          SizedBox(height: 20),
          TextField(
            obscureText: isHiddenn,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: () {
                    if (isHiddenn == true) {
                      isHiddenn = false;
                    } else {
                      isHiddenn = true;
                    }
                    setState(() {});
                  },
                  icon: Icon(Icons.remove_red_eye)),
              hintText: "Ulangi Password",
              labelText: "Retype Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              prefixIcon: Icon(Icons.phone),
              hintText: "Masukkan No. Telephone",
              labelText: "Telephone",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          SizedBox(height: 20),
          DropdownButton(
            value: selectedValue,
            items: <String>['pagi', 'siang', 'sore']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
          SizedBox(height: 100),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        backgroundColor: Color.fromARGB(255, 0, 97, 175),
                        content: Text(
                          "Berhasil Membuat Akun",
                          style: TextStyle(
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    );
                    Navigator.of(context).pop(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "Register",
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
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Sudah memiliki akun?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginPage();
                        },
                      ),
                    );
                  },
                text: "Login disini",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 97, 175),
                  decoration: TextDecoration.underline,
                )),
          ),
        ],
      ),
    );
  }
}
