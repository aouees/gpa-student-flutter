
import 'dart:async';
import 'package:flutter/material.dart';
import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => const MyHomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.center,
                child: Image.asset('assets/UOK_logo.gif')),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Owis Al_hammoud",
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    wordSpacing: 5,
                    letterSpacing: 2,
                    shadows: const <Shadow>[
                      Shadow(
                          blurRadius: 10,
                          color: Colors.blueAccent,
                          offset: Offset(0, 10))
                    ]),
              ),
            )
          ],
        ));
  }
}