/* import */
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tubes/pages/middleware.dart';
import 'package:tubes/pages/register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;
import 'package:tubes/classes/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool isHidden = true;

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
            padding: EdgeInsets.all(30),
            children: [
              const SizedBox(
                height: 60,
              ),

              //foto
              Column(
                children: [
                  Image.asset(
                    "assets/images/LogoPromvis1.png",
                    alignment: Alignment.topCenter,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 140,
              ),

              //email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  prefixIcon: const Icon(Icons.email),
                  hintText: "Masukkan Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              //password
              TextField(
                controller: passwordController,
                obscureText: isHidden,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (isHidden == true) {
                          isHidden = false;
                        } else {
                          isHidden = true;
                        }
                        setState(() {});
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                  hintText: "Masukkan Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),

              const SizedBox(
                height: 100,
              ),

              //button
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<UserCubit>()
                            .saveUser(
                                emailController.text, passwordController.text)
                            .then((_) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return Middleware();
                              },
                            ),
                          );
                        }).catchError((error) {
                          print('Login failed: $error');
                        });
                      },
                      child: Text("Login"),
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
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Belum punya akun?",
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
                            return RegisterPage();
                          },
                        ),
                      );
                    },
                  text: "Register disini",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 97, 175),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
