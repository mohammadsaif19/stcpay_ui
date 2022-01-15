//Author: Mohammad Saiful Islam Saif
//Github: https://github.com/mohammadsaif19

import 'package:flutter/material.dart';
import 'screens/explore_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'stc pay',
      debugShowCheckedModeBanner: false,
      home: ExploreScreen(),
    );
  }
}
