import 'package:flutter/material.dart';
import 'package:tes/pages/absen_siswa.dart';
import 'package:tes/pages/bantuan_page.dart';
import 'package:tes/pages/home_page.dart';
import 'package:tes/pages/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.indexPage,
  });

  final int? indexPage;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    AbsenSiswa(),
    BantuanPage(),
    ProfilPage()
  ];

  @override
  void initState() {
    _selectedIndex = widget.indexPage ?? 0;
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_outlined),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_help_outlined),
            label: 'Bantuan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        useLegacyColorScheme: true,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        selectedIconTheme: const IconThemeData(size: 32),
        onTap: _onItemTapped,
      ),
    );
  }
}
