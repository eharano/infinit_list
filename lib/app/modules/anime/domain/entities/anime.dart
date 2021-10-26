import 'package:equatable/equatable.dart';

class Anime extends Equatable {
  final int id;
  final String title;
  final String link;
  final String image;

  const Anime({
    required this.id,
    required this.title,
    required this.link,
    required this.image,
  });

  @override
  List<Object?> get props => [id, title, link, image];
}
