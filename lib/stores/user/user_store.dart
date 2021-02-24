import 'package:boilerplate/data/repository/AuthRepository.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

import '../../utils/dio/dio_error_util.dart';
import 'package:device_info/device_info.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final AuthRepository _repository;

  // store for handling form errors
  final UserErrorStore formErrorStore = UserErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(AuthRepository repository) : this._repository = repository {

    // setting up disposers
    _setupDisposers();
    // checking if user is logged in
    repository.authToken.then((value) {
      this.isLoggedIn = value!=null?true:false;
    });
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => userName, validateUserName),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword)
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
  ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  @observable
  String userEmail = '';

  @observable
  String userName = '';

  @observable
  String password = '';

  @observable
  String confirmPassword = '';


  @computed
  String get userPassword => password;


  @observable
  bool loading = false;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin && userEmail.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
          userEmail.isNotEmpty &&
          password.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          userName.isNotEmpty;

  @computed
  bool get canForgetPassword =>
      !formErrorStore.hasErrorInForgotPassword && userEmail.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    loading=true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
    final future = _repository.login(email, password,androidInfo.model);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      loading=false;
      if (value) {
        // _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        this.success = true;
      } else {
        print('failed to login');
      }
    }).catchError((e) {
      loading=false;
      this.isLoggedIn = false;
      this.success = false;
      errorStore.errorMessage =
          DioErrorUtil.handleError(e);

      print(e);
    });
  }

  @action
  Future register(String name, String email,String password,String password_confirmation) async{
    loading=true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"

    // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
    final future = _repository.register(name,email,password,androidInfo.model,password_confirmation);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      loading=false;
      if (value) {
        this.isLoggedIn = true;
        this.success = true;
      } else {
        print('failed to register');
      }
    }).catchError((e) {
      loading=false;
      this.isLoggedIn = false;
      this.success = false;
      errorStore.errorMessage =
          DioErrorUtil.handleError(e);

      print(e);
    });
  }
  @action
  void setUserId(String value) {
    userEmail = value;
  }

  @action
  void setUserName(String value) {
    userName = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Email can't be empty";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Please enter a valid email address';
    } else {
      formErrorStore.userEmail = null;
    }
  }
  @action
  void validateUserName(String value) {
    if (value.isEmpty) {
      formErrorStore.userName = "Username can't be empty";
    } else {
      formErrorStore.userName = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Password can't be empty";
    } else if (value.length < 6) {
      formErrorStore.password = "Password must be at-least 6 characters long";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Confirm password can't be empty";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Password doesn't match";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }


  @action
  Future forgotPassword() async {
    loading = true;
  }


  logout() {
    loading=true;
    this.isLoggedIn = false;
    _repository.removeAuthToken();
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
  void validateAll() {
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class UserErrorStore = _UserErrorStore with _$UserErrorStore;

abstract class _UserErrorStore with Store {
  @observable
  String userEmail;

  @observable
  String userName;

  @observable
  String password;

  @observable
  String confirmPassword;

  @computed
  bool get hasErrorsInLogin => userEmail != null || password != null;

  @computed
  bool get hasErrorsInRegister =>
      userEmail != null || password != null || confirmPassword != null || userName !=null;

  @computed
  bool get hasErrorInForgotPassword => userEmail != null;
}