import '../../../../core/adapters/http_client/http_client_adapter.dart';
import '../../../../core/helpers/errors/errors.dart';
import '../../../../core/helpers/errors/http_client_error.dart';
import '../../domain/entities/anime.dart';
import '../../infra/datasources/anime_remote_datasource.dart';
import '../helpers/errors/anime_mappers_error.dart';
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
    } on HttpClientError {
      rethrow;
    } on AnimeMappersError {
      rethrow;
    } catch (e, stackTrace) {
      throw DataSourceError(
        message: e.toString(),
        stacktrace: stackTrace,
      );
    }
  }
}
