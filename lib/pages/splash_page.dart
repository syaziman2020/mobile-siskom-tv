import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:siskom_tv_dosen/pages/login_page.dart';
import 'package:siskom_tv_dosen/pages/profile_page.dart';
import 'package:siskom_tv_dosen/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void init() async {
    final storage = const FlutterSecureStorage();
    String? value = await storage.read(key: 'save');
    print('=========');
    print(value);

    Future.delayed(
        const Duration(
          milliseconds: 2500,
        ), () {
      if (value != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      }
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteC,
      body: Center(
        child: Image.asset(
          'assets/logo-untan.png',
          width: size.width * 0.32,
        ),
      ),
    );
  }
}
