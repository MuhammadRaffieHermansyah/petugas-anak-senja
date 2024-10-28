import 'package:flutter/material.dart';
import 'package:tes/pages/absen_siswa.dart';
import 'package:tes/pages/bantuan_page.dart';
import 'package:tes/pages/home_page.dart';
import 'package:tes/pages/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    this.indexPage,
    this.search,
  });

  final int? indexPage;
  final String? search;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  static List<Widget> _widgetOptions(String? search) => [
        const HomePage(),
        AbsenSiswa(search: search),
        const BantuanPage(),
        const ProfilPage()
      ];

  int _selectedIndex = 0;
  String? search;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.indexPage ?? 0;
    search = widget.search; 
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index != 1) {
        search = null; 
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions(search).elementAt(_selectedIndex),
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
