import 'package:equatable/equatable.dart';

class Book extends Equatable {
  final String? id;
  final String? title;
  final String? image;
  final Map<String, dynamic>? author;
  final String? description;
  final Map<String, dynamic>? categories;
  final String? publish;
  final String? datePublish;

  const Book({
    required this.id,
    required this.title,
    this.image,
    this.author,
    this.description,
    this.categories,
    this.publish,
    this.datePublish,
  });

  @override
  List<Object?> get props => [id, title, author];
}
