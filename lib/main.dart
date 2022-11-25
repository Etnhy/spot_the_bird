import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_the_bird/bloc/location_cubit.dart';
import 'package:spot_the_bird/screens/map_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationCubit>(
      create: (BuildContext context) => LocationCubit()..getLocation(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // App bar color
            primaryColor: const Color(0xFFCFF5E7),
            colorScheme: const ColorScheme.light().copyWith(
              // Text Field color
              primary: const Color(0xFFA0E4CB),
              // Floating Action Button
              secondary: const Color(0xFF59C1BD),
            )),
        home: MapScreen(),
      ),
    );
  }
}
