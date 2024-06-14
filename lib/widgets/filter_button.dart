import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({super.key});

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  DateTimeRange _selectedDate =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Pilih Tanggal',
          style: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          height: 8,
        ),
        InkWell(
          onTap: () {
            _selectDateRange(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.calendar_month,
                size: 40,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Pilih Tanggal',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    "${DateFormat('dd/MM/y').format(_selectedDate.start)} - ${DateFormat('dd/MM/y').format(_selectedDate.end)}",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.blue,
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ElevatedButton(
          onPressed: () {
            String dateRange =
                "?start=${DateFormat('y-MM-dd').format(_selectedDate.start)}&end=${DateFormat('y-MM-dd').format(_selectedDate.end)}";
            // print(selectedDate);
            print(dateRange);
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
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.blue),
          child: const Text(
            'Cari',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              wordSpacing: 2,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}
