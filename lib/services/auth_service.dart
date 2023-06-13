import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer';
import 'package:siskom_tv_dosen/models/login_model.dart' as login;
import 'package:siskom_tv_dosen/models/profile_model.dart' as profile;
import 'package:siskom_tv_dosen/services/main_url.dart';

class AuthService {
  final MainUrl _mainUrl = MainUrl();
  Dio dio = Dio();
  final storage = const FlutterSecureStorage();

  Future<login.LoginModel>? loginProfile(
      {required String email, required String password}) async {
    try {
      final response = await dio.post("${_mainUrl.mainUrl}/login",
          data: jsonEncode({
            'email': email,
            'password': password,
          }));

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        login.LoginModel result = login.LoginModel.fromJson(response.data);
        if (result.meta?.status == 'success') {
          _mainUrl.setToken(result.data!.accessToken.toString());
          await storage.write(key: 'save', value: _mainUrl.getToken());

          return result;
        }
        log(result.data!.accessToken.toString());
      }
      if (_mainUrl.getToken().isEmpty) {
        throw Exception('token kosong');
      } else {
        throw Exception(
            'Post tidak berhasil dengan code ${response.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<bool>? changeName(String name) async {
    try {
      String? value = await storage.read(key: 'save');
      final response = await dio.post(
        "${_mainUrl.mainUrl}/update",
        data: jsonEncode({
          'name': name,
        }),
        options: Options(
          headers: {'Authorization': "Bearer ${value}"},
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool>? changeStatus(String status) async {
    try {
      String? value = await storage.read(key: 'save');
      final response = await dio.post(
        "${_mainUrl.mainUrl}/change",
        data: jsonEncode({
          'status': status,
        }),
        options: Options(
          headers: {'Authorization': "Bearer ${value}"},
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool>? logout() async {
    try {
      String? value = await storage.read(key: 'save');
      final response = await dio.post(
        "${_mainUrl.mainUrl}/logout",
        options: Options(
          headers: {'Authorization': "Bearer ${value}"},
        ),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: 'save');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<profile.ProfileModel> getProfile() async {
    try {
      String? value = await storage.read(key: 'save');
      _mainUrl.setToken(value);
      if (_mainUrl.getToken().isEmpty) {
        throw Exception('Token kosong');
      }

      final response = await dio.get(
        "${_mainUrl.mainUrl}/user",
        options: Options(
          headers: {'Authorization': "Bearer ${value}"},
        ),
      );
      if (response.statusCode == 200) {
        profile.ProfileModel result =
            profile.ProfileModel.fromJson(response.data);

        return result;
      } else {
        throw Exception(
            'Get tidak berhasil dengan code ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
