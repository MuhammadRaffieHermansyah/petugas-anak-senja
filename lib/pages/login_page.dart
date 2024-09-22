// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:tes/pages/bottom_bar.dart';
import 'package:tes/widgets/utilities.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formLoginKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isClose = true;
  bool isClose2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formLoginKey,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 170,
                  width: 170,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Masuk Akun',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                    'Masuk terlebih dahulu untuk mengakses berbagai fitur'),
                const SizedBox(height: 16),
                const Text(
                  'Email',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  cursorColor: const Color.fromARGB(255, 16, 32, 125),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukan Password Konfirmasi';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    focusColor: Color.fromARGB(255, 16, 32, 125),
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    suffixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey,
                    ),
                    label: Text(
                      'Masukan Email',
                      style: TextStyle(color: Colors.grey),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isClose ? true : false,
                  cursorColor: const Color.fromARGB(255, 16, 32, 125),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tolong Masukan Password Konfirmasi';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.grey,
                    focusColor: const Color.fromARGB(255, 16, 32, 125),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isClose == false) {
                            isClose = true;
                          } else {
                            isClose = false;
                          }
                        });
                      },
                      icon: isClose
                          ? const Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                    ),
                    label: const Text(
                      'Masukan Password',
                      style: TextStyle(color: Colors.grey),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 45),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    onPressed: () async {
                      if (formLoginKey.currentState!.validate()) {
                        Utilities.showLoaderDialog(context);
                        Uri url = Uri.parse(ApiKey.login);

                        final response = await http.post(
                          url,
                          body: {
                            "email": _emailController.text,
                            "password": _passwordController.text
                          },
                        );
                        if (response.statusCode == 200) {
                          _emailController.clear();
                          _passwordController.clear();
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString(
                              'token', json.decode(response.body)['token']);
                          print(json.decode(response.body)['token']);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomBar(),
                            ),
                          );
                          return;
                        }
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 1700),
                          content: Text(
                            'Email atau Password salah !',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, letterSpacing: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
