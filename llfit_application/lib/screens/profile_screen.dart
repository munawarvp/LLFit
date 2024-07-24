import 'package:flutter/material.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/services/user.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: ()=>logoutUser(context), child: const Text('Logout')),
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}