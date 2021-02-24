
import 'package:boilerplate/data/network/response/AuthResponse.dart';
import 'package:boilerplate/models/auth/Authorization.dart';
import 'package:dio/dio.dart';

import '../../constants/endpoints.dart';
import '../../dio_client.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;


  // injecting dio instance
  AuthApi(this._dioClient);

  /// Returns list of post in response
  Future<AuthResponse> login(FormData formData) async {
    try {

      final res = await _dioClient.post(Endpoints.login,data: formData);

      return AuthResponse.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<AuthResponse> register(FormData formData) async {
    try {
      final res = await _dioClient.post(Endpoints.register,data: formData);
      return AuthResponse.fromMap(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}