import 'package:adda/utils/color.dart';
import 'package:adda/utils/dimens.dart';
import 'package:adda/view/home/home.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    getHome();
    super.initState();
  }

  getHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
        (route) {
          return false;
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Event App",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: size18 * 1.5,
          ),
        ),
      ),
    );
  }
}
