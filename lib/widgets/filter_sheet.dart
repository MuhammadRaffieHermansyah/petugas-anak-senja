// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tes/pages/detail_siswa.dart';
// import 'package:tabungan/pages/simpan_data.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  DateTimeRange _selectedDate = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now(),
  );
  DateTime now = DateTime.now();
  bool isDateRangeChange = false;
  bool isSelectedDateChange = false;

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2016),
      lastDate: DateTime.now(),
      initialDateRange: _selectedDate,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        isDateRangeChange = true;
      });
    }
  }

  final List<DateTime> dateOptions = [
    DateTime.now().subtract(const Duration(days: 7)), // 7 hari lalu
    DateTime.now().subtract(const Duration(days: 30)), // 30 hari lalu
    DateTime.now().subtract(const Duration(days: 90)), // 90 hari lalu
  ];

  int _selectedOptionIndex = 0;

  // String _radioValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Divider(
              endIndent: 160,
              thickness: 3.5,
              indent: 160,
              height: 4,
            ),
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              _selectDateRange(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.lightBlue,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    size: 32,
                    color: Colors.lightBlue,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    "${DateFormat('dd/MM/y').format(_selectedDate.start)} - ${DateFormat('dd/MM/y').format(_selectedDate.end)}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('7 Hari lalu'),
            leading: Radio(
              activeColor: Colors.lightBlue,
              value: 7,
              groupValue: _selectedOptionIndex,
              onChanged: (value) {
                print(value);
                setState(() {
                  _selectedOptionIndex = value as int;
                  _selectedDate = DateTimeRange(
                    start: DateTime.now().subtract(const Duration(days: 7)),
                    end: DateTime.now(),
                  );
                });
              },
            ),
          ),
          ListTile(
            title: const Text('30 Hari Lalu'),
            leading: Radio(
              activeColor: Colors.lightBlue,
              value: 30,
              groupValue: _selectedOptionIndex,
              onChanged: (value) {
                print(value);
                setState(() {
                  _selectedOptionIndex = value as int;
                  _selectedDate = DateTimeRange(
                    start: DateTime.now().subtract(const Duration(days: 30)),
                    end: DateTime.now(),
                  );
                });
              },
            ),
          ),
          ListTile(
            title: const Text('90 Hari Lalu'),
            leading: Radio(
              activeColor: Colors.lightBlue,
              value: 90,
              groupValue: _selectedOptionIndex,
              onChanged: (value) {
                print(value);
                setState(() {
                  _selectedOptionIndex = value as int;
                  _selectedDate = DateTimeRange(
                    start: DateTime.now().subtract(const Duration(days: 90)),
                    end: DateTime.now(),
                  );
                });
              },
            ),
          ),
          const SizedBox(height: 0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailSiswa(),
                ),
              );
              // String dateRange =
              //     "?start=${DateFormat('y-MM-dd').format(_selectedDate.start)}&end=${DateFormat('y-MM-dd').format(_selectedDate.end)}";
              // print(selectedDate);
              // print(dateRange);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => SimpanData(
              //       query: dateRange,
              //     ),
              //   ),
              // );
            },
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                )),
            child: const Text(
              'Terapkan Filter',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                wordSpacing: 2,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
