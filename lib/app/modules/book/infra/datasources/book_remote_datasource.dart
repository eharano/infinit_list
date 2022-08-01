import '../../domain/entities/book.dart';

abstract class BookRemoteDataSource {
  Future<List<Book>> getAll({
    required Map<String, dynamic> queries,
  });
}
