import 'package:flutter/material.dart';
import 'package:tes/widgets/ooption_profile.dart';
import 'package:tes/widgets/profile_card.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                OptionProfile(),
                ProfileCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
