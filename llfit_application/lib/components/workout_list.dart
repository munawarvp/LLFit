import 'package:flutter/material.dart';
import 'package:llfit_application/services/user.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserWorkout(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No workouts available"));
        }

        List<dynamic> workouts = snapshot.data!;

        return ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            var workout = workouts[index];
            return ExpansionTile(
              iconColor: Colors.purple,
              collapsedIconColor: Colors.purple[800],
              textColor: Colors.purple,
              collapsedTextColor: Colors.purple[800],
              minTileHeight: 85.0,
              title:Text(
                '${workout['excerise']['name']}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${workout['excerise']['muscle']}',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.fitness_center_rounded, color: Colors.purple[800]),
                      const SizedBox(width: 10),
                      Text(
                        '${workout['excerise']['equipment']}',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    '${workout['excerise']['instructions']}',
                    style: const TextStyle(fontSize: 15),),
                )
              ],
            );
          }
        );
      }
    );
  }
}