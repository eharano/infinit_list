import '../../domain/entities/anime.dart';

class AnimeMapper {
  static Anime fromMap({
    required Map<String, dynamic> map,
  }) {
    return Anime(
      id: map['id'] as int,
      title: map['title'] as String,
      link: map['link'] as String,
      image: map['image'] as String,
    );
  }

  static Map<String, dynamic> toMap({required Anime anime}) {
    return {
      'id': anime.id,
      'title': anime.title,
      'link': anime.link,
      'image': anime.image,
    };
  }
}
