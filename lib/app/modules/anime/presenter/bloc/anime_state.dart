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
  final bool hasMax;
  final bool isLoading;

  const AnimeSuccessState({
    required this.animes,
    this.hasMax = false,
    this.isLoading = false,
  });

  AnimeSuccessState copyWith({
    List<Anime>? animes,
    bool? hasMax,
    bool? isLoading,
  }) {
    return AnimeSuccessState(
      animes: animes ?? this.animes,
      hasMax: hasMax ?? this.hasMax,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [animes, hasMax];
}

class AnimeErrorState extends AnimeState {
  final String error;

  const AnimeErrorState({required this.error});

  @override
  List<Object?> get props => [];
}
