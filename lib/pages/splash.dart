import 'package:flutter/material.dart';
import 'package:tes/pages/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _loadingValue = 0.0;
  final double _maxLoadingValue = 100.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  double _progress = 0.0;

  void _startLoading() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_loadingValue < _maxLoadingValue) {
        setState(() {
          _loadingValue += 10;
        });
        _startLoading();
      } else {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Onboarding()));
  }

  // void checkSession() async {
  //   await Future.delayed(const Duration(seconds: 100));
  // }

  @override
  void initState() {
    // checkSession();
    // _startLoading();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ))
      ..addListener(() {
        setState(() {
          if (_animation.value == 1.0) {
            _navigateToHome();
          }
          _progress = _animation.value;
        });
      });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          // mainAxisAligntment: MainAxisAligntMent.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: _progress,
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              minHeight: 5,
              backgroundColor: Colors.black38,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
