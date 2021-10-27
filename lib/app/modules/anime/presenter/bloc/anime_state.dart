part of 'anime_bloc.dart';

abstract class AnimeState extends Equatable {
  const AnimeState();
}

class AnimeInitialState extends AnimeState {
  const AnimeInitialState();

  @override
  List<Object?> get props => [];
}

class AnimeLoadingState extends AnimeState {
  const AnimeLoadingState();

  @override
  List<Object?> get props => [];
}

class AnimeSuccessState extends AnimeState {
  final List<Anime> animes;
  final int page;
  final bool isFetching;

  const AnimeSuccessState({
    required this.animes,
    required this.page,
    this.isFetching = false,
  });

  AnimeSuccessState copyWith({
    List<Anime>? animes,
    int? page,
    bool? isFetching,
  }) {
    return AnimeSuccessState(
      animes: animes ?? this.animes,
      page: page ?? this.page,
      isFetching: isFetching ?? this.isFetching,
    );
  }

  @override
  List<Object?> get props => [animes];
}

class AnimeErrorState extends AnimeState {
  final String error;

  const AnimeErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
