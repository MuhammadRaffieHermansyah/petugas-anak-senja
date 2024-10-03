// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tes/get_models/get_siswa.dart';
import 'package:tes/models/siswa.dart';
import 'package:tes/pages/bottom_bar.dart';
import 'package:tes/providers/siswa_provider.dart';
import 'package:tes/widgets/absen/absen_card.dart';

class AbsenSiswa extends StatefulWidget {
  const AbsenSiswa({
    super.key,
    this.query,
    this.search,
  });

  final String? query;
  final String? search;

  @override
  State<AbsenSiswa> createState() => _AbsenSiswaState();
}

class _AbsenSiswaState extends State<AbsenSiswa> {
  final TextEditingController searchController = TextEditingController();

  setSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    searchController.text = prefs.get('search').toString() == 'null'
        ? ''
        : prefs.get('search').toString();
  }

  deleteSearch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('search');
  }

  @override
  void initState() {
    setSearch();
    super.initState();
  }

  @override
  void dispose() {
    deleteSearch();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Absen Siswa',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(33, 150, 243, 1),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 18,
              left: 12,
              right: 12,
            ),
            child: Column(
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  controller: searchController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onEditingComplete: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('search', searchController.text);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBar(
                          indexPage: 1,
                        ),
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    alignLabelWithHint: false,
                    focusColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    suffixIconColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    label: Text(
                      'Cari Siswa',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: Colors.white,
        child: FutureBuilder<GetSiswa>(
          future: SiswaProvider.getSiswa("search=${searchController.text}"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                ),
              );
            } else {
              final List<Siswa> data = snapshot.data!.data;
              if (data.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tidak ada data !',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'ATAU',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Semua siswa sudah ter-absen !',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Siswa item = data[index];
                  return CardAbsen(
                    nama: item.name,
                    id: item.id,
                    kelas: item.siswaClass.name,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10);
                },
                itemCount: data.length,
              );
            }
          },
        ),
      ),
    );
  }
}
