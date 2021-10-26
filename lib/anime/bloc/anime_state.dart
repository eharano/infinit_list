import 'package:infinit_list/app/modules/anime/domain/entities/anime.dart';

abstract class AnimeState {
  const AnimeState();
}

class AnimeInitialState extends AnimeState {
  const AnimeInitialState();
}

class AnimeLoadingState extends AnimeState {
  final String message;

  const AnimeLoadingState({required this.message});
}

class AnimeSuccessState extends AnimeState {
  final List<AnimeModel> animes;

  const AnimeSuccessState({required this.animes});
}

class AnimeErrorState extends AnimeState {
  final String error;

  const AnimeErrorState({required this.error});
}
