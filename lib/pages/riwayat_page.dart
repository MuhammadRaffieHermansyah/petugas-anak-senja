import 'package:flutter/material.dart';
import 'package:tes/widgets/riwayat/berangkat.dart';
import 'package:tes/widgets/riwayat/pulang.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 600),
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Riwayat',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            labelStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            indicatorColor: Colors.white,
            indicatorWeight: 5,
            indicatorPadding: EdgeInsets.all(0),
            unselectedLabelColor: Colors.black,
            labelColor: Colors.black,
            tabs: [
              Tab(text: 'Berangkat'),
              Tab(text: 'Pulang '),
            ],
          ),
        ),
        body: const TabBarView(
          children: [Berangkat(), Pulang()],
        ),
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: Colors.white,
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const NullRiwayat(),
        //       ),
        //     );
        //   },
        //   label: const Text('Null Riwayat'),
        // ),
      ),
    );
  }
}
