part of 'anime_bloc.dart';

abstract class AnimeEvent extends Equatable {
  const AnimeEvent();
}

class AnimeFetchEvent extends AnimeEvent {
  final AnimeDTO params;

  const AnimeFetchEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}

class AnimePaginateEvent extends AnimeEvent {
  final AnimeDTO params;

  const AnimePaginateEvent({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}
