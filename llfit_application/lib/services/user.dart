import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:llfit_application/models/shonawar.dart';
import 'package:llfit_application/screens/home_screen.dart';
import 'package:llfit_application/screens/login_screen.dart';
import 'package:llfit_application/screens/profile_screen.dart';
import 'package:llfit_application/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Dio dio = Dio()
  ..interceptors.add(
    InterceptorsWrapper(
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          print('access token expired --- called for refresh');
          String token = await refreshAccessToken();
          final requestOptions = error.response!.requestOptions
              .copyWith(headers: {'Authorization': 'Bearer $token'});

          final response = await dio.request(requestOptions.path,
              options: Options(
                  method: requestOptions.method,
                  headers: requestOptions.headers),
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters);
          print("${response.data} --- refresh response");
          return handler.resolve(response);
        }
      },
    ),
  );

void loginUser(context, data) async {
  try {
    final response = await dio.post('$baseUrl/api/token/pair', data: data);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['access']);
    await prefs.setString('refresh', response.data['refresh']);

    final decodedToken = decodeJwt(response.data['access']);
    final username = await getUsername(decodedToken['user_id']);
    await prefs.setString('username', username);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Login failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white));
  }
}

Future<void> checkToken(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  if (token == null || token.isEmpty) {
    print('No access token exist');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  } else {
    print('access token exist');
    // final decodedToken = decodeJwt(token);
    // final Map<String, dynamic> profile = await getUserProfile(decodedToken['userId'], token, context);
    // final Map<String, dynamic> metrics = await getUserMetrics(token);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const ProfileScreen()));
  }
}

Future<String> getUsername(int userId) async {
  try {
    final response =
        await dio.get('$baseUrl/api/user/get-user?user_id=$userId');
    return response.data['username'];
  } catch (e) {
    return 'username';
  }
}

void registerUser(context, data) async {
  try {
    await dio.post('$baseUrl/api/user/register', data: data);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Activate your account..!',
            style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registration failed..!',
            style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white));
  }
}

void logoutUser(context) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Login failed..!', style: TextStyle(color: Colors.black45)),
        width: 200,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.white));
  }
}

Future<String> refreshAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? refresh = prefs.getString('refresh');

  Response response =
      await dio.post('$baseUrl/api/token/refresh', data: {'refresh': refresh});
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

Future<dynamic> getUserProfile(token) async {
  try {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get('$baseUrl/api/user/get-profile');
    return response.data;
  } catch (e) {}
}

Future<dynamic> getUserMetrics(String token) async {
  try {
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response = await dio.get('$baseUrl/api/user/user-metrics');
    return response.data;
  } catch (e) {}
}

Future<dynamic> createMetrics(Map data, context) async {
  try {
    String? token = await getToken();
    final decodedToken = decodeJwt(token);
    data['user'] = decodedToken['user_id'];
    dio.options.headers["Authorization"] = "Bearer $token";
    Response response =
        await dio.post('$baseUrl/api/user/add-metrics', data: data);
    if (response.statusCode == 200) {
      Navigator.pop(context);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Metrics creation failed..!',
                style: TextStyle(color: Colors.black45)),
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
    final response = await dio.get('$baseUrl/api/user/calculate-bmi',
        queryParameters: {'metrics_id': metricsId});
    return response.data;
  } catch (e) {}
}

Future fetchUserMetrics(DateTime? filterModel) async {
  try {
    final token = getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    final response = await dio.get('$baseUrl/api/user/metrics-report');
    final shonawar = Shonawars.fromJson(response.data).data;
    return shonawar;
  } catch (e) {}
}

Future fetchUserWorkout() async {
  try {
    final token = getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    final response = await dio.get('$baseUrl/api/user/workout/list');
    return response.data;
  } catch (e) {}
}

Future updateUserProfileData(data, context) async {
  try {
    final token = getToken();
    dio.options.headers["Authorization"] = "Bearer $token";
    final response =
        await dio.post('$baseUrl/api/user/add-profile', data: data);
    if (response.data != null) {
      print('response data found');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Profile updated..!',
                  style: TextStyle(color: Colors.white)),
              width: 200,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.lightGreen)
          // margin: EdgeInsets.all(15))
          );
    }
  } catch (e) {
    print('in catch block $e');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Profile update failed..!',
                  style: TextStyle(color: Colors.white)),
              width: 200,
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red)
          // margin: EdgeInsets.all(15))
          );
  }
}
