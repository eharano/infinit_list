import 'dart:async';
import 'package:http/http.dart' as http;

class AnimeRepository {
  static const int _perPage = 10;
  static final AnimeRepository _animeRepository = AnimeRepository._();

  AnimeRepository._();

  factory AnimeRepository() {
    return _animeRepository;
  }

  Future<dynamic> getAnimes({
    required int page,
  }) async {
    try {
      return await http.get(
        Uri.parse("https://www.intoxianime.com/?rest_route=/wp/v2/posts&page=$page&per_page=$_perPage"),
      );
    } catch (e) {
      return e.toString();
    }
  }
}
