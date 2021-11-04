import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../repositories/anime_repository.dart';
import '../entities/entities.dart';
import '../dtos/dtos.dart';
import 'anime_get_all_usecase.dart';

class AnimeGetAllUseCaseImpl implements AnimeGetAllUseCase {
  final AnimeRepository repository;

  const AnimeGetAllUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Anime>>> call({
    required AnimeDTO params,
  }) {
    return repository.getAll(params: params);
  }
}
