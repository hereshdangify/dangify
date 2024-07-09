import 'package:dio/dio.dart';
import 'package:my_test/helpers/endpoint.dart';

class BaseRepository {
  Dio dio = Dio(BaseOptions(baseUrl: Endpoint.base));
}
