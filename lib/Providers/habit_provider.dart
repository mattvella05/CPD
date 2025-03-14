import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matthew_cpd_assignment/Models/habit.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = [];

  List<Habit> get habits => _habits;

  Future<void> addHabit(String name) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _habits.add(Habit(
      name: name,
      latitude: position.latitude,
      longitude: position.longitude,
    ));

    notifyListeners();
  }
}