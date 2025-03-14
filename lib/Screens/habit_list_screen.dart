import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matthew_cpd_assignment/Models/habit.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  List<Habit> habits = [];

  Future<void> _addHabit() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      habits.add(Habit(
        name: "New Habit",
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Habit Tracker")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(habits[index].name),
                  subtitle: Text(
                      "Location: ${habits[index].latitude}, ${habits[index].longitude}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addHabit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button color
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Add Habit", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
