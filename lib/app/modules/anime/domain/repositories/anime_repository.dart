import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../dtos/anime_dto.dart';
import '../entities/entities.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<Anime>>> getAll({required AnimeDTO params});
}
