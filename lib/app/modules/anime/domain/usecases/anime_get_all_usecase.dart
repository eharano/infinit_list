import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../dtos/dtos.dart' show AnimeGetAllDTO;
import '../entities/entities.dart';

abstract class AnimeGetAllUseCase {
  Future<Either<Failure, List<Anime>>> call({
    required AnimeGetAllDTO params,
  });
}
