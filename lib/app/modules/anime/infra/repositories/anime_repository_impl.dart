import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/errors.dart';
import '../../domain/entities/anime.dart';
import '../../domain/dtos/anime_get_all_dto.dart';
import '../../domain/repositories/anime_repository.dart';
import '../datasources/anime_remote_datasource.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource dataSource;

  AnimeRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Anime>>> getAll({
    required AnimeGetAllDTO params,
  }) async {
    try {
      final response = await dataSource.getAll(queries: params.toMap());
      return Right(response);
    } on DataSourceError catch (error) {
      return Left(error);
    } on Failure catch (error) {
      return Left(error);
    }
  }
}
