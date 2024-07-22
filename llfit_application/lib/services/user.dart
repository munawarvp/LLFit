import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/login_screen.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dio = Dio();

void loginUser(context, data) async {
  try {
    final response = await dio.post('$baseUrl/api/token/pair', data: data);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['access']);
    await prefs.setString('refresh', response.data['refresh']);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const ProfileScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login failed..!'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white30,
        margin: EdgeInsets.all(15)));
  }
}

Future<void> checkToken(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token == null || token.isEmpty){
    print('$token this is token');
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  }
  else{
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const ProfileScreen()));
  }
}