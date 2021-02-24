import 'package:boilerplate/models/auth/AuthUser.dart';
import 'package:boilerplate/models/auth/Authorization.dart';

class AuthResponse {
  Authorization authorization;
  int status;
  AuthUser authUser;
  AuthResponse({
    this.authorization,
    this.status,
    this.authUser
  });

  factory AuthResponse.fromMap(Map<String, dynamic> json) => AuthResponse(
    authorization: Authorization.fromMap(json["auth"]),  //https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51
    status: json['status'],
    authUser: AuthUser.fromMap(json['user'])
  );

  Map<String, dynamic> toMap() => {
    "auth": authorization,
    "status":status,
    "user":authUser
  };

}