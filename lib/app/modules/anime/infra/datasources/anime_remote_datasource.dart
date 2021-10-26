import '../../domain/entities/anime.dart';

abstract class AnimeRemoteDataSource {
  Future<List<Anime>> getAll({
    required Map<String, dynamic> queries,
  });
}
