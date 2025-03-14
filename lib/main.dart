import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matthew_cpd_assignment/Screens/habit_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _checkLocationPermission();
  runApp(const MyApp());
}

Future<void> _checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HabitListScreen(),
    );
  }
}
