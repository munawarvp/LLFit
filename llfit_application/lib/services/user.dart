
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/login_screen.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio dio = Dio()..interceptors.add(
    InterceptorsWrapper(
      onError: (DioException error, handler) async {
        if(error.response?.statusCode == 401){
          String token = await refreshAccessToken();
          final requestOptions = error.response!.requestOptions.copyWith(
            headers: {'Authorization': 'Bearer $token'}
          );

          final response = await dio.request(
            requestOptions.path,
            options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers
            ),
            data: requestOptions.data,
            queryParameters: requestOptions.queryParameters
          );
          return handler.resolve(response);
        }
      },
    ),
  );


void loginUser(context, data) async {
  try {
    final response = await dio.post('$baseUrl/api/token/pair', data: data);
    final prefs = await SharedPreferences.getInstance();
    final decodedToken = decodeJwt(response.data['access']);
    final metrics = await getUserMetrics(response.data['access']);
    final profile = await getUserProfile(decodedToken['userId'], response.data['access'], context);
    await prefs.setString('token', response.data['access']);
    await prefs.setString('refresh', response.data['refresh']);

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>ProfileScreen(token: response.data['access'], profile: profile, metrics: metrics)));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white)
      );
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
    final Map<String, dynamic> profile = await getUserProfile(decodedToken['userId'], token, context);
    final Map<String, dynamic> metrics = await getUserMetrics(token);
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ProfileScreen(token: token, profile: profile, metrics: metrics)));
  }
}

void registerUser(context, data) async {
  try {
    await dio.post('$baseUrl/api/user/register', data: data);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Activate your account..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white)
      );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> const HomeScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white)
      );
  }
}

void logoutUser(context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const LoginScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white)
      );
  }
}

Future<String> refreshAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? refresh = prefs.getString('refresh');

  Response response = await dio.post('$baseUrl/api/token/refresh', data: {'refresh': refresh});
  await prefs.setString('token', response.data['access']);
  await prefs.setString('refresh', response.data['refresh']);
  return response.data['access'];
}

decodeJwt(token) {
  Map<String, dynamic> decodeToken = JwtDecoder.decode(token);
  return decodeToken;
}

Future getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token;
}

Future<dynamic> getUserProfile(userId, token, context) async {
  try{
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get('$baseUrl/api/user/get-profile');
    return response.data;
  } catch(e){}
}

Future<dynamic> getUserMetrics(String token, {int? userId}) async {
  try{
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get('$baseUrl/api/user/user-metrics');
    return response.data;
  } catch(e){}
}

Future<dynamic> createMetrics(Map data, context) async {
  try{
    String? token = await getToken();
    final decodedToken = decodeJwt(token);
    data['user'] = decodedToken['user_id'];
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.post('$baseUrl/api/user/add-metrics', data: data);
    if(response.statusCode==200){
      Navigator.pop(context);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Metrics creation failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white)
        // margin: EdgeInsets.all(15))
      );
  }
}

Future calculateMetrics(int metricsId) async {
  try {
    final token = getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    final response = await dio.get('$baseUrl/api/user/calculate-bmi', queryParameters: {'metrics_id': metricsId});
    return response.data;
  } catch (e) {}
}