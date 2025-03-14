import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:matthew_cpd_assignment/Models/habit.dart';
import 'package:matthew_cpd_assignment/Screens/habit_detail_screen.dart';

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  List<Habit> habits = [];

  Future<void> _addHabit() async {
    TextEditingController habitController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter Habit Name"),
          content: TextField(
            controller: habitController,
            decoration: const InputDecoration(hintText: "Habit Name"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (habitController.text.isNotEmpty) {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);

                  setState(() {
                    habits.add(Habit(
                      name: habitController.text,
                      latitude: position.latitude,
                      longitude: position.longitude,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitDetailScreen(habit: habits[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _addHabit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
