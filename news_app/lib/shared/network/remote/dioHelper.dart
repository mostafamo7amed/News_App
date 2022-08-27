import 'package:dio/dio.dart';

class DioHelper{
   static late Dio dio;
   static init(){
      dio = Dio(
         BaseOptions(
            baseUrl: 'https://newsapi.org/',
            receiveDataWhenStatusError: true,
         ),
      );
   }

   static Future<Response> getData({
      required String url,
      required Map<String , dynamic> query
}) async {
      return await dio.get(
         url,
         queryParameters: query
      );
   }
}
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fcb8108a1c6440408a96c64ca098744c
//fcb8108a1c6440408a96c64ca098744c