import '../../domain/entities/book.dart';
import '../helpers/errors/book_mappers_error.dart';

class BookMapper {
  const BookMapper._();

  static Book fromMap({
    required Map<String, dynamic> map,
  }) {
    try {
      return Book(
        id: map['id'] as String?,
        title: map['volumeInfo']['title'] as String?,
        image: map['volumeInfo']['volumeInfo']['link'] as String?,
        author: map['volumeInfo']['authors'],
        categories: map['volumeInfo']['categories'],
        description: map['volumeInfo']['description'] as String?,
        datePublish: map['volumeInfo']['publishedDate'] as String?,
        publish: map['volumeInfo']['publisher'] as String?,
      );
    } catch (e, stacktrace) {
      throw BookMappersError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }

  static Map<String, dynamic> toMap({required Book book}) {
    try {
      return {
        'id': book.id,
        'title': book.title,
        'image': book.image,
        'author': book.author,
        'description': book.description,
      };
    } catch (e, stacktrace) {
      throw BookMappersError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }

  static List<Book> fromListMap({required List<Map<String, dynamic>> maps}) {
    try {
      return maps.map((map) => fromMap(map: map)).toList();
    } catch (e, stacktrace) {
      throw BookMappersError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }
}
