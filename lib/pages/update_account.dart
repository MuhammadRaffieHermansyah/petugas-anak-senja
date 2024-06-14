import 'package:flutter/material.dart';
import 'package:tes/widgets/info_account.dart';

class UpdateAccount extends StatelessWidget {
  const UpdateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Data Account',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: const Column(
          children: [
            SizedBox(height: 26),
            InfoAccount(
              title: 'Nama',
              subTitle: 'Budi Jawa',
              icon: Icon(
                Icons.person_outline,
                color: Colors.blue,
                size: 22,
              ),
            ),
            InfoAccount(
              title: 'Email',
              subTitle: 'budijawa@gmail.com',
              icon: Icon(
                Icons.email_outlined,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
            InfoAccount(
              title: 'NIP',
              subTitle: '123456789',
              icon: Icon(
                Icons.person_pin_outlined,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
            InfoAccount(
              title: 'Nomer Kendaraan',
              subTitle: 'P 1234 ST',
              icon: Icon(
                Icons.car_repair_outlined,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
            InfoAccount(
              title: 'Phone',
              subTitle: '082144665290',
              icon: Icon(
                Icons.phone,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
            InfoAccount(
              title: 'Status',
              subTitle: 'Sopir Angkot',
              icon: Icon(
                Icons.people,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
            InfoAccount(
              title: 'Alamat',
              subTitle: 'M9H4+MG8,Panggul Mlati,Kepanjen,Kec.Gum',
              icon: Icon(
                Icons.location_on_outlined,
                color: Colors.blue,
                size: 22,
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
