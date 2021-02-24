import 'dart:async';


import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/data/local/datasources/authUserDao.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/auth/Authorization.dart';
import 'package:dio/dio.dart';


import '../local/datasources/authDao.dart';
import '../network/apis/auth/auth_api.dart';

class AuthRepository {
  // api objects
  final AuthApi _authApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // data source object
  final AuthDao _authDao;
  final AuthUserDao _authUserDao;
  // constructor
  AuthRepository( this._authApi,this._sharedPrefsHelper,this._authDao,this._authUserDao);

  // Login:---------------------------------------------------------------------
  Future<bool> login(String username, String password,String device_name) async {
    // return await Future.delayed(Duration(seconds: 2), ()=> true);
    FormData formData = new FormData.fromMap({
      "email": username,
      "password": password,
      "device_name": device_name
    });
    return await _authApi.login(formData).then((authResponse) {
      var authObj=authResponse.authorization;
      _authDao.deleteAll();
      _authDao.insert(authObj);

      _authUserDao.deleteAll();
      _authUserDao.insert(authResponse.authUser);
      saveAuthToken(authObj.access_token);  //save user is logged in pref manager
      return true;
    }).catchError((error) {
      throw error;
    });
  }

  // register
  Future<bool> register(String name, String email,String password, String device_name,String password_confirmation) async{
    FormData formData= new FormData.fromMap({
      "name":name,
      "email":email,
      "password":password,
      "device_name":device_name,
      "password_confirmation":password_confirmation
    });
    return await _authApi.register(formData).then((authResponse){
      var authObj=authResponse.authorization;
      _authDao.deleteAll();
      _authDao.insert(authObj);

      _authUserDao.deleteAll();
      _authUserDao.insert(authResponse.authUser);
      saveAuthToken(authObj.access_token);  //save user is logged in pref manager
      return true;
    }).catchError((error) {
      throw error;
    });

  }


  Future<void> saveAuthToken(String token) =>
      _sharedPrefsHelper.saveAuthToken(token);

  Future<String> get authToken => _sharedPrefsHelper.authToken;

  Future<void> removeAuthToken()=>_sharedPrefsHelper.removeAuthToken();
}
