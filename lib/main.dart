import 'package:adda/utils/theme.dart';
import 'package:adda/view/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.defaultTheme,
      debugShowCheckedModeBanner: false,
      home: const Splash(),
    );
  }
}
