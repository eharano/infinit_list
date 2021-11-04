import 'package:dio/dio.dart' hide HttpClientAdapter;

import '../../../../core/adapters/http_client/http_client_adapter.dart';
import '../../../../core/helpers/errors/errors.dart';
import '../../../../core/helpers/errors/http_client_error.dart';
import '../../domain/entities/anime.dart';
import '../../infra/datasources/anime_remote_datasource.dart';
import '../mappers/anime_mapper.dart';

class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  final HttpClientAdapter httpClient;

  AnimeRemoteDataSourceImpl({
    required this.httpClient,
  });

  @override
  Future<List<Anime>> getAll({
    required Map<String, dynamic> queries,
  }) async {
    try {
      final response = await httpClient.get(queries: queries);
      return AnimeMapper.fromListMap(
          maps: (response.data as List).cast<Map<String, dynamic>>());
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
