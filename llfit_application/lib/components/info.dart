import 'package:flutter/material.dart';
import 'package:llfit_application/services/user.dart';

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

  void updateInfo() {
    int? age = int.tryParse(ageController.text);
    Map data = {
      'phone_number': phoneNumberController.text,
      'gender': genderController.text,
      'age': age,
      'shift': shiftController.text,
      'level': levelController.text,
      'address': 'sample address'
    };
    updateUserProfileData(data, context);
  }

  // @override
  // void dispose() {
  //   firstNameController.dispose();
  //   lastNameController.dispose();
  //   phoneNumberController.dispose();
  //   genderController.dispose();
  //   ageController.dispose();
  //   super.dispose();
  // }

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
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
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
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Gender'),
                      TextField(
                        controller: genderController,
                        decoration: const InputDecoration(
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
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Age'),
                      TextField(
                        controller: ageController,
                        decoration: const InputDecoration(
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
            TextField(
              controller: shiftController,
                decoration: const InputDecoration(
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Level'),
                      TextField(
                        controller: levelController,
                          decoration: const InputDecoration(
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
                  onPressed: () {
                    updateInfo();
                  },
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
