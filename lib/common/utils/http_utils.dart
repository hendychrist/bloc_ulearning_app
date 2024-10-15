// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, avoid_print
import 'package:dio/dio.dart';
import 'package:ulearning_app/common/values/constant.dart';
import 'package:ulearning_app/common/widget/flutter_toast.dart';
import 'package:ulearning_app/global.dart';

class HttpUtil{
  late Dio dio;
  
  static final HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil(){
    return _instance;
  }

  HttpUtil._internal(){
    BaseOptions options = BaseOptions(
                              baseUrl: AppConstants.SERVER_API_URL, // "http://127.0.0.1:8000",
                              connectTimeout: Duration(seconds: 30),      
                              receiveTimeout: Duration(seconds: 30), // waiting for response after getting connection
                              headers: {},
                              contentType: "application/json: charset=utf-8",
                              responseType: ResponseType.json
                            );
    dio = Dio(options);
  }

  Future post(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options, bool isLogin = false}) async {
    Map<String, dynamic>? authorization;
    
    if(options == null && isLogin == false){
      authorization = getAuthorizationHeader();
      
      if(authorization == null){
        toastInfo(msg: 'post() -> authorization is null');
      }
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, responseInterceptorHandler) async {
          print('DioObserver - onResponse - ${response.statusCode} - ${response.data.toString()}\n');
          return responseInterceptorHandler.next(response);
        },
        onRequest: (request, requestInterceptorHandler) {
          print("DioObserver - onRequest - ${request.method} - ${request.path} - ${request.data}");
          print("DioObserver - onRequest - ${ authorization ?? "authorization is empty" }");
        
          // request.headers.addAll({HttpHeaders.authorizationHeader: 'Bearer 156|JnZfLV8MVvDQ4M60Tj0voIMRCL662fYXnQtPFuuW34f8c286'});
          // request.headers.addAll(authorization ?? {HttpHeaders.authorizationHeader: 'Bearer 158|iP8bQnW0DDB4ftf4oCws00MDubMPgmM4IApg6fNlf4eae781'});
          request.headers.addAll(authorization ?? {});

          return requestInterceptorHandler.next(request);
        },
              
        onError: (DioException dioError, errorInterceptor) {
        switch (dioError.type) {
          case DioExceptionType.cancel:
            toastInfo(msg: "Request to API server was cancelled");
            break;
          case DioExceptionType.connectionTimeout:
            toastInfo(msg: "Connection timeout with API server");
            break;
          case DioExceptionType.receiveTimeout:
            toastInfo(msg: "Receive timeout in connection with API server");
            break;
          case DioExceptionType.badResponse:
            toastInfo(msg: "${dioError.response?.data["message"]} - ${dioError.response?.statusCode}");
            break;
          case DioExceptionType.connectionError:
            toastInfo(msg: 'No Internet');
            break;
          case DioExceptionType.sendTimeout:
            toastInfo(msg: "Send timeout in connection with API server");
            break;
          case DioExceptionType.unknown:
            toastInfo(msg: "Unexpected error occurred");
            break;
          default:
            toastInfo(msg: "Something went wrong");
            break;
        }
        return errorInterceptor.next(dioError); 
      },

      ),
    );
  
    try {
          var response = await dio.post(
                                      path,
                                      data: data,
                                      queryParameters: queryParameters,
                                      options: options ?? Options(headers: authorization),
                                    );

          print("DEBUG: http_utils.dart -> ");
          print("DEBUG: http_utils.dart -> post() -> STATUS  CODE : ${response.statusCode}");
          print("DEBUG: http_utils.dart -> post() -> RESPONSE : ${response.toString()}");
          print("DEBUG: http_utils.dart -> ");

          return response.data;

        } catch (e) {
          if (e is DioException) {
            // Handle Dio-specific exceptions
            print("DEBUG: http_utils.dart -> Request error: ${e.message}");
          } else {
            // Handle other types of exceptions
            print("DEBUG: http_utils.dart -> Unexpected error: $e");
          }
          rethrow; // Optionally rethrow the error to handle it further up the chain
        }
    
    // return object  
    // return response.data;
  }

   Map<String,dynamic> getAuthorizationHeader(){
    Map<String,dynamic> header = <String, dynamic>{};
    String accessToken = Global.storageService.getUserToken();
    // String modifiedAccessToken = accessToken.substring(3);

    if(accessToken.isNotEmpty){
      header['Authorization'] = 'Bearer $accessToken';
    }else{
      toastInfo(msg: "getAuthorizationHeader() -> accessToken() is Empty");
    }
    return header;
  }


}