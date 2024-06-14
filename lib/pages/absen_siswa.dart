import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tes/widgets/filter_sheet.dart';

class AbsenSiswa extends StatefulWidget {
  const AbsenSiswa({super.key, this.query, this.search});

  final String? query;
  final String? search;

  @override
  State<AbsenSiswa> createState() => _AbsenSiswaState();
}

class _AbsenSiswaState extends State<AbsenSiswa> {
  List<bool> isGoList =
      List.generate(50, (index) => false); // Initialize the list with false

  Timer? _searchTimer;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _onSearch(String value) {
    _searchTimer?.cancel();
    _searchTimer = Timer(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;

        if (value.isEmpty) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SaldoPage(
          //       search: value,
          //     ),
          //   ),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SaldoPage(
          //       query: "nama=$value",
          //       search: value,
          //     ),
          //   ),
          // );
        }
      },
    );
  }

  @override
  void initState() {
    _searchController.text = widget.search ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _searchTimer?.cancel();
    _searchController.dispose();
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        bottom: AppBar(
          title: Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                margin: const EdgeInsets.only(
                  left: 0,
                  top: 10,
                  right: 0,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  left: 0,
                  top: 0,
                  right: 0,
                  bottom: 0,
                ),
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(6.0), // Border radius
                ),
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    hintText: 'Cari nasabah...',
                    hintStyle: const TextStyle(color: Colors.black),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.black),
                    contentPadding: const EdgeInsets.only(
                      top: 2,
                      bottom: 0,
                      left: 0,
                      right: 0,
                    ),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              _searchController.clear();
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const SaldoPage(),
                              //   ),
                              // );
                            },
                          )
                        : null,
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                    letterSpacing: 1,
                    fontSize: 16,
                  ),
                  cursorColor: Colors.black,
                  onSubmitted: (value) {
                    if (mounted) {
                      _onSearch(value);
                    }
                  },
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) => const FilterSheet(),
                  );
                },
                icon: const Icon(
                  Icons.tune_sharp,
                  size: 30,
                )),
            const SizedBox(
              width: 14,
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.separated(
          itemCount: 50,
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(85, 210, 210, 210),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Abdul Tiyas Ramadhan',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Kelas IX-A',
                          style: TextStyle(color: Colors.black45, fontSize: 10),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (isGoList[index] == true) {
                        return;
                      } else {
                        setState(() {
                          isGoList[index] = !isGoList[index];
                        });
                      }
                    },
                    style: !isGoList[index]
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
                      !isGoList[index] ? 'Berangkat' : "Pulang",
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
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}
