import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matthew_cpd_assignment/Screens/habit_list_screen.dart';
import 'package:matthew_cpd_assignment/Providers/habit_provider.dart';
import 'package:matthew_cpd_assignment/Services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotificationService.initialize();
  await LocalNotificationService.showNotification(
    'Test Notification',
    'This is just a manual test',
  );
  await _checkLocationPermission();
  await _checkNotificationPermission();

  runApp(
    ChangeNotifierProvider(
      create: (context) => HabitProvider(),
      child: const MyApp(),
    ),
  );
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

Future<void> _checkNotificationPermission() async {
  final FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  final AndroidFlutterLocalNotificationsPlugin? android =
      plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

  final bool? granted = await android?.areNotificationsEnabled();

  if (granted == false) {
    print("Notifications are not enabled. Please enable them manually.");
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
