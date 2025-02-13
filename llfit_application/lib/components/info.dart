import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  final Map<String, dynamic> profile;

  const InfoPage({super.key, required this.profile});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController shiftController;
  late TextEditingController levelController;


  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(
        text: widget.profile['user']?['first_name'] ?? '');
    lastNameController = TextEditingController(
        text: widget.profile['user']?['last_name'] ?? '');
    phoneNumberController = TextEditingController(
        text: widget.profile['user']?['phone_number'] ?? '');
    genderController = TextEditingController(
        text: widget.profile['user']?['gender'] ?? '');
    ageController = TextEditingController(
        text: widget.profile['user']?['age'] ?? '');
    shiftController = TextEditingController(
        text: widget.profile['user']?['shift'] ?? '');
    levelController = TextEditingController(
        text: widget.profile['user']?['level'] ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            const Text('First Name'),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
                filled: true,
                fillColor:
                    Color.fromARGB(187, 237, 237, 237),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text('Last Name'),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Last Name',
                filled: true,
                fillColor:
                    Color.fromARGB(187, 237, 237, 237),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text('Phone Number'),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Phone Number',
                filled: true,
                fillColor:
                    Color.fromARGB(187, 237, 237, 237),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none, 
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gender'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Gender',
                          filled: true,
                          fillColor: Color.fromARGB(
                              187, 237, 237, 237),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Age'),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Age',
                          filled: true,
                          fillColor: Color.fromARGB(
                              187, 237, 237, 237),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const Text('Shift'),
            const TextField(
                decoration: InputDecoration(
              hintText: 'Shift',
              filled: true,
              fillColor:
                  Color.fromARGB(187, 237, 237, 237),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey, width: 2),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2),
              ),
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Level'),
                      TextField(
                          decoration: InputDecoration(
                        hintText: 'Level',
                        filled: true,
                        fillColor: Color.fromARGB(
                            187, 237, 237, 237),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2),
                        ),
                      )),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 76, 223, 76)),
                  onPressed: () {},
                  child: const Text('Update',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
