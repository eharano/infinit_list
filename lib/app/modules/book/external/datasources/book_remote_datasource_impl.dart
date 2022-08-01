import 'package:dio/dio.dart' hide HttpClientAdapter;

import '../../../../core/adapters/http_client/http_client_adapter.dart';
import '../../../../core/helpers/errors/errors.dart';
import '../../../../core/helpers/errors/http_client_error.dart';
import '../../domain/entities/book.dart';
import '../../infra/datasources/book_remote_datasource.dart';
import '../mappers/book_mapper.dart';

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final HttpClientAdapter httpClient;

  BookRemoteDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<List<Book>> getAll({
    required Map<String, dynamic> queries,
  }) async {
    try {
      final response = await httpClient.get(queries: queries);
      return BookMapper.fromListMap(maps: (response.data as List).cast<Map<String, dynamic>>());
    } on Failure {
      rethrow;
    } on DioError catch (e) {
      throw HttpClientError(
        e.message,
        e.stackTrace ?? StackTrace.current,
        statusCode: e.response?.statusCode ?? 400,
      );
    } catch (e, stackTrace) {
      throw DataSourceError(
        message: e.toString(),
        stacktrace: stackTrace,
      );
    }
  }
}
