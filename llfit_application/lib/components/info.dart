import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final Map<String, dynamic> profile;
  final Map<String, dynamic> user;
  const InfoPage({super.key, required this.profile, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            TextFormField(
              initialValue: '${user['first_name']}',
              decoration: InputDecoration(
                  labelText: 'name',
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            const SizedBox(height: 5),
            const Text('Phone Number'),
            TextFormField(
              initialValue: '${profile['phone_number']}',
              decoration: InputDecoration(
                  labelText: 'phone number',
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            const SizedBox(height: 5),
            const Text('Age'),
            TextFormField(
              initialValue: '${profile['age']}',
              decoration: InputDecoration(
                  labelText: 'age',
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            const SizedBox(height: 5),
            const Text('Level'),
            TextFormField(
              initialValue: '${profile['level']}',
              decoration: InputDecoration(
                  labelText: 'level',
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
            const SizedBox(height: 5),
            const Text('Level'),
            TextFormField(
              initialValue: '${profile['level']}',
              decoration: InputDecoration(
                  labelText: 'level',
                  filled: true,
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none))),
            ),
          ],
        ),
      ),
    );
  }
}
