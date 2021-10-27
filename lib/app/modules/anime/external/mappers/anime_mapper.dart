import '../../domain/entities/anime.dart';
import '../helpers/errors/anime_mappers_error.dart';

class AnimeMapper {
  const AnimeMapper._();

  static Anime fromMap({
    required Map<String, dynamic> map,
  }) {
    try {
      return Anime(
        id: map['id'] as int,
        title: map['title'] as String,
        link: map['link'] as String,
        image: map['image'] as String,
      );
    } catch (e, stacktrace) {
      throw AnimeMappperError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }

  static Map<String, dynamic> toMap({required Anime anime}) {
    try {
      return {
        'id': anime.id,
        'title': anime.title,
        'link': anime.link,
        'image': anime.image,
      };
    } catch (e, stacktrace) {
      throw AnimeMappperError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }

  static List<Anime> fromListMap({required List<Map<String, dynamic>> maps}) {
    try {
      return maps.map((map) => fromMap(map: map)).toList();
    } catch (e, stacktrace) {
      throw AnimeMappperError(
        message: e.toString(),
        stacktrace: stacktrace,
      );
    }
  }
}
