import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/failure.dart';
import '../repositories/book_repository.dart';
import '../entities/entities.dart';
import '../dtos/dtos.dart';
import 'book_get_all_usecase.dart';

class BookGetAllUseCaseImpl implements BookGetAllUseCase {
  final BookRepository repository;

  const BookGetAllUseCaseImpl({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<Book>>> call({
    required BookDTO params,
  }) {
    return repository.getAll(params: params);
  }
}
