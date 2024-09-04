import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final Map<String, dynamic> profile;

  const InfoPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255,228,225),
                    Color.fromARGB(255, 255, 245, 244)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_box_rounded,
                          size: 40,
                          color: Color.fromARGB(255, 6, 42, 80),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(profile['user']['first_name'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 6, 42, 80),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                            Text(profile['user']['email'],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 6, 42, 80),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255,228,225),
                    Color.fromARGB(255, 255, 245, 244),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_pin,
                            size: 40, color: Color.fromARGB(255, 6, 42, 80)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Address',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 6, 42, 80),
                                      fontWeight: FontWeight.w700)),
                              Text(profile['address'],
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 6, 42, 80),
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.looks_one_rounded,
                            size: 40, color: Color.fromARGB(255, 6, 42, 80)),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Age',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            Text('${profile['age']}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            const Text('Gender',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            Text(profile['gender'],
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.sports_gymnastics,
                            size: 40, color: Color.fromARGB(255, 6, 42, 80)),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Shift',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            Text('${profile['shift']}',
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            const Text('Level',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700)),
                            Text(profile['level'],
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 6, 42, 80),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
