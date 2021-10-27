import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/dtos/dtos.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/entities/anime.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeGetAllUseCase animeGetAllUseCase;

  AnimeBloc({
    required this.animeGetAllUseCase,
  }) : super(const AnimeInitialState());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetchEvent) {
      yield* mapAnimeFetchEventToState(event);
    }
  }

  Stream<AnimeState> mapAnimeFetchEventToState(AnimeFetchEvent event) async* {
    yield const AnimeLoadingState();

    final response = await animeGetAllUseCase.call(params: event.params);
    yield response.fold(
      (l) => AnimeErrorState(error: l.message),
      (r) => AnimeSuccessState(animes: r, page: 1),
    );
  }
}
