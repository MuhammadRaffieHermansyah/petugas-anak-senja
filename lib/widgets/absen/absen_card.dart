import 'package:flutter/material.dart';
import 'package:tes/providers/absen_provider.dart';

class CardAbsen extends StatefulWidget {
  const CardAbsen({
    super.key,
    required this.nama,
    required this.kelas,
    required this.id,
  });

  final String nama, kelas;
  final int id;

  @override
  State<CardAbsen> createState() => _CardAbsenState();
}

class _CardAbsenState extends State<CardAbsen> {
  bool isAbsen = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(134, 210, 210, 210),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                Text(
                  widget.kelas,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (isAbsen == true) {
                return;
              } else {
                AbsenProvider.createAbsen(widget.id.toString());
                setState(() {
                  isAbsen = !isAbsen;
                });
              }
            },
            style: !isAbsen
                ? ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.lightBlueAccent,
                  )
                : ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.grey,
                  ),
            child: Text(
              !isAbsen ? 'Berangkat' : "Pulang",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
