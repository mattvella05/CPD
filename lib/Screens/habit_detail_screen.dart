import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matthew_cpd_assignment/Models/habit.dart';

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;

  const HabitDetailScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(habit.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(habit.latitude, habit.longitude),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId("habit_location"),
                  position: LatLng(habit.latitude, habit.longitude),
                  infoWindow: InfoWindow(title: habit.name),
                ),
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Habit: ${habit.name}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Latitude: ${habit.latitude}"),
                Text("Longitude: ${habit.longitude}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
