import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../dtos/book_dto.dart';
import '../entities/entities.dart';

abstract class BookRepository {
  Future<Either<Failure, List<Book>>> getAll({required BookDTO params});
}
