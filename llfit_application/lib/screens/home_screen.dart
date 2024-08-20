import 'package:flutter/material.dart';
import 'package:llfit_application/components/bottom_bar.dart';
import 'package:llfit_application/services/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> signout () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: ElevatedButton(onPressed: (){logoutUser(context);}, child: Text('Logout')),
      // ),
      body: SizedBox(
        child: ListView(
          children: [
            Padding(padding: EdgeInsets.all(5),
            child: Container(
              height: 200,
              color: Colors.yellow,  
            )),
            Padding(padding: EdgeInsets.all(5),
            child: Container(
              height: 200,
              color: Colors.yellow,  
            )),
            Padding(padding: EdgeInsets.all(5),
            child: Container(
              height: 200,
              color: Colors.yellow,  
            )),
            Padding(padding: EdgeInsets.all(5),
            child: Container(
              height: 200,
              color: Colors.yellow,  
            )),
            Padding(padding: EdgeInsets.all(5),
            child: Container(
              height: 200,
              color: Colors.yellow,  
            )),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar()
    );
  }
}