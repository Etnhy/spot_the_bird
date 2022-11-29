import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spot_the_bird/bloc/bird_post_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationCubit>(
          create: (BuildContext context) => LocationCubit()..getLocation(),
        ),
        BlocProvider<BirdPostCubit>(
          create: (BuildContext context) => BirdPostCubit(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // App bar color
            primaryColor: const Color.fromARGB(255, 141, 234, 200),
            colorScheme: const ColorScheme.light().copyWith(
              // Text Field color
              primary: const Color.fromARGB(255, 85, 156, 130),
              // Floating Action Button
              secondary: const Color.fromARGB(255, 118, 167, 166),
            )),
        home: MapScreen(),
      ),
    );
  }
}
