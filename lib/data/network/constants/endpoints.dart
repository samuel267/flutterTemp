class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://192.168.100.188:3000/api/";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 3000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  //login end point
  static const String login = baseUrl + "login";

  //register end point
  static const String register = baseUrl + "register";
}