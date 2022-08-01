import 'package:dartz/dartz.dart';

import '../../../../core/helpers/errors/errors.dart';
import '../../domain/entities/book.dart';
import '../../domain/dtos/book_dto.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/book_remote_datasource.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource dataSource;

  BookRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<Failure, List<Book>>> getAll({
    required BookDTO params,
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
