import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../dtos/dtos.dart';
import '../entities/entities.dart';

abstract class BookGetAllUseCase {
  Future<Either<Failure, List<Book>>> call({
    required BookDTO params,
  });
}
