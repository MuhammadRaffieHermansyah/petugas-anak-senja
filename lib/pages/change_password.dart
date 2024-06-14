import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

TextEditingController _passwordNowController = TextEditingController();
TextEditingController _passwordNewController = TextEditingController();
TextEditingController _passwordConfirmationController = TextEditingController();

bool isClose = true;
bool isClose2 = true;
bool isClose3 = true;

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Kata Sandi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              TextFormField(
                // key: _formKey,
                controller: _passwordNowController,
                obscureText: isClose ? true : false,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Masukan Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
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
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.close),
                    ),
                    label: const Text('Password Lama'),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                // key: _formKey,
                controller: _passwordNewController,
                obscureText: isClose2 ? true : false,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Masukan Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isClose2 == false) {
                            isClose2 = true;
                          } else {
                            isClose2 = false;
                          }
                        });
                      },
                      icon: isClose2
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.close),
                    ),
                    label: const Text('Password Baru'),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 20),
              TextFormField(
                // key: _formKey,
                controller: _passwordConfirmationController,
                obscureText: isClose3 ? true : false,
                cursorColor: Colors.black,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tolong Masukan Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20),
                    fillColor: Colors.black,
                    focusColor: Colors.black,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          if (isClose3 == false) {
                            isClose3 = true;
                          } else {
                            isClose3 = false;
                          }
                        });
                      },
                      icon: isClose3
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.close),
                    ),
                    label: const Text('Konfirmasi Password Baru'),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(height: 35),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)),
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(260, 50),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
