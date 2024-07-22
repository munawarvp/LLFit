import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


final dio = Dio();

Future<Response?> loginUser(context, data) async{
  try {
      final response = await dio.post('$baseUrl/api/token/pair', data: data);
      final shared_preference = await SharedPreferences.getInstance();
      await shared_preference.setString('token', response.data['access']);
      await shared_preference.setString('refresh', response.data['refresh']);
      Navigator.of(context).pushNamed('/home-screen');
  } catch (e) {
      print('Error Type: ${e}');
      return null;
  }
}

Future<String?> checkToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token;
}