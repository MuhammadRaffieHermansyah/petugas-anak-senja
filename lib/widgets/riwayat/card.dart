import 'package:flutter/material.dart';
import 'package:tes/pages/detail_siswa.dart';

class CardRiwayat extends StatefulWidget {
  const CardRiwayat({super.key});

  @override
  State<CardRiwayat> createState() => _CardRiwayatState();
}

class _CardRiwayatState extends State<CardRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '08 Mei 2024',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailSiswa(),
                  ),
                );
              },
              child: const Text(
                'Lihat Semua',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        // nanti di maping aja pas udah fix
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: const Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Abdul Razaq Fadli',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Kelas IX - B',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Abdul Razaq Fadli',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Kelas IX - B',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Abdul Razaq Fadli',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'Kelas IX - B',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.4,
              )
            ],
          ),
        )
      ],
    );
  }
}
