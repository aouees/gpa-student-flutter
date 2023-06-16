
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ],
  ); // To turn off landscape mode
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   const MaterialApp(
      title: 'GPA',
      home: SplashScreen(),
    );
  }
}

