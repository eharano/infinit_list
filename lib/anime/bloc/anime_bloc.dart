import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:infinit_list/anime/bloc/anime_event.dart';
import 'package:infinit_list/anime/bloc/anime_state.dart';
import 'package:infinit_list/anime/models/anime.dart';
import 'package:infinit_list/anime/repository/anime_repository.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeRepository animeRepository;
  int page = 1;
  bool isFetching = false;

  AnimeBloc({
    required this.animeRepository,
  }) : super(const AnimeInitialState());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetchEvent) {
      yield const AnimeLoadingState(message: 'Loading Animes');
      final response = await animeRepository.getAnimes(page: page);
      if (response is http.Response) {
        if (response.statusCode == 200) {
          final animes = jsonDecode(response.body) as List;
          yield AnimeSuccessState(
            animes: animes.map((anime) => AnimeModel.fromJson(anime).toList()),
          );
          page++;
        } else {
          yield AnimeErrorState(error: response.body);
        }
      } else if (response is String) {
        yield AnimeErrorState(error: response);
      }
    }
  }
}
