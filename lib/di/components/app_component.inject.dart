import 'app_component.dart' as _i1;
import '../modules/local_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import '../../data/network/dio_client.dart' as _i6;
import '../../data/network/apis/posts/post_api.dart' as _i7;
import '../../data/local/datasources/post/post_datasource.dart' as _i8;
import '../../data/repository.dart' as _i9;
import '../../data/network/apis/auth/auth_api.dart' as _i10;
import '../../data/local/datasources/authDao.dart' as _i11;
import '../../data/local/datasources/authUserDao.dart' as _i12;
import '../../data/repository/AuthRepository.dart' as _i13;
import 'dart:async' as _i14;
import '../modules/netwok_module.dart' as _i15;
import '../../main.dart' as _i16;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._localModule, this._preferenceModule);

  final _i2.LocalModule _localModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Dio _singletonDio;

  _i6.DioClient _singletonDioClient;

  _i7.PostApi _singletonPostApi;

  _i8.PostDataSource _singletonPostDataSource;

  _i9.Repository _singletonRepository;

  _i10.AuthApi _singletonAuthApi;

  _i11.AuthDao _singletonAuthDao;

  _i12.AuthUserDao _singletonAuthUserDao;

  _i13.AuthRepository _singletonAuthRepository;

  static _i14.Future<_i1.AppComponent> create(
      _i15.NetworkModule _,
      _i2.LocalModule localModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(localModule, preferenceModule);

    return injector;
  }

  _i16.MyApp _createMyApp() => _i16.MyApp();
  _i9.Repository _createRepository() =>
      _singletonRepository ??= _localModule.provideRepository(_createPostApi(),
          _createSharedPreferenceHelper(), _createPostDataSource());
  _i7.PostApi _createPostApi() =>
      _singletonPostApi ??= _localModule.providePostApi(_createDioClient());
  _i6.DioClient _createDioClient() =>
      _singletonDioClient ??= _localModule.provideDioClient(_createDio());
  _i5.Dio _createDio() => _singletonDio ??=
      _localModule.provideDio(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  _i8.PostDataSource _createPostDataSource() =>
      _singletonPostDataSource ??= _localModule.providePostDataSource();
  _i13.AuthRepository _createAuthRepository() =>
      _singletonAuthRepository ??= _localModule.provideAuthRepository(
          _createAuthApi(),
          _createSharedPreferenceHelper(),
          _createAuthDao(),
          _createAuthUserDao());
  _i10.AuthApi _createAuthApi() =>
      _singletonAuthApi ??= _localModule.provideAuthApi(_createDioClient());
  _i11.AuthDao _createAuthDao() =>
      _singletonAuthDao ??= _localModule.provideAuthDao();
  _i12.AuthUserDao _createAuthUserDao() =>
      _singletonAuthUserDao ??= _localModule.provideAuthUserDao();
  @override
  _i16.MyApp get app => _createMyApp();
  @override
  _i9.Repository getRepository() => _createRepository();
  @override
  _i13.AuthRepository getAuthRepository() => _createAuthRepository();
}
