import 'package:dio/dio.dart';

class DioHelper
{
  static late Dio dio;  // Take object form Dio (dio)

  static init()    // to create this object
  {
    dio = Dio(  //definition dio
      BaseOptions(
        baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response>  getData({
    required String url,
    required Map<String, dynamic> query,
})
  async {
    return await dio.get(url, queryParameters: query);
  }
}