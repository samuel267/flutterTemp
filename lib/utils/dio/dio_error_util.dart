import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioErrorUtil {
  // general methods:------------------------------------------------------------
  static String handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
            switch(error.response.statusCode){
              case 400:errorDescription=" 	Bad request.";break;
              case 401: errorDescription="	Access denied. IIS defines a number of different 401 errors that indicate a more specific cause of the error. These specific error codes are displayed in the browser but are not displayed in the IIS log:" ;break;
              case 403: errorDescription="	Forbidden. IIS defines a number of different 403 errors that indicate a more specific cause of the error"; break;
              case 404: errorDescription="	Not found."; break;
              case 405: errorDescription="	HTTP verb used to access this page is not allowed (method not allowed.)"; break;
              case 406: errorDescription="	Client browser does not accept the MIME type of the requested page."; break;
              case 407: errorDescription="	Proxy authentication required."; break;
              case 412: errorDescription="	Precondition failed."; break;
              case 413: errorDescription="	Request entity too large."; break;
              case 414: errorDescription="	Request-URI too long."; break;
              case 415: errorDescription="	Unsupported media type."; break;
              case 416: errorDescription="	Requested range not satisfiable."; break;
              case 417: errorDescription="	Execution failed."; break;
              case 423: errorDescription="	Locked error."; break;
              case 500: errorDescription=	"Internal server error."; break;
              case 501: errorDescription=	"Header values specify a configuration that is not implemented."; break;
              case 502: errorDescription=	"Web server received an invalid response while acting as a gateway or proxy."; break;
              case 503: errorDescription=	"Service unavailable. This error code is specific to IIS 6.0."; break;
              case 504: errorDescription=	"Gateway timeout."; break;
              case 505: errorDescription=	"HTTP version not supported."; break;
              default :
                errorDescription = "${error.response.statusCode}" ;
                break;
            }

          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}