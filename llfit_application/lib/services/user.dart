
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
    final decodedToken = decodeJwt(response.data['access']);
    final profile = await getUserProfile(decodedToken['userId'], response.data['access']);
    await prefs.setString('token', response.data['access']);
    await prefs.setString('refresh', response.data['refresh']);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ProfileScreen(token: response.data['access'], profile: profile,)));
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
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  }
  else{
    final decodedToken = decodeJwt(token);
    final profile = await getUserProfile(decodedToken['userId'], token);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ProfileScreen(token: token, profile: profile)));
  }
}

void registerUser(context, data) async {
  try {
    await dio.post('$baseUrl/api/user/register', data: data);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Activate you account in mail.'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white30,
      margin: EdgeInsets.all(15),
    ));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const HomeScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Registration failed..!'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white30,
      margin: EdgeInsets.all(15),
    ));
  }
}

void logoutUser(context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Logout failed..!'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.white30,
      margin: EdgeInsets.all(15),
    ));
  }
}

decodeJwt(token) {
  Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
  return decodeToken;
}

Future getUserProfile(userId, token) async {
  try{
    dio.options.headers["Authorization"] = "Bearer $token";
    final response  =await dio.get('$baseUrl/api/user/get-profile');
    return response;
  } catch(e){}
}