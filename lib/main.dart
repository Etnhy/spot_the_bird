import 'package:flutter/material.dart';
import 'package:spot_the_bird/screens/map_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // App bar color
          primaryColor: Color(0xFFCFF5E7),
          colorScheme: ColorScheme.light().copyWith(
            // Text Field color
            primary: Color(0xFFA0E4CB),
            // Floating Action Button
            secondary: Color(0xFF59C1BD),
          )),
      home: MapScreen(),
    );
  }
}
