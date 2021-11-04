import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_list/app/core/helpers/errors/http_client_error.dart';

import '../../domain/dtos/dtos.dart';
import '../../domain/usecases/usecases.dart';
import '../../domain/entities/anime.dart';

part 'anime_event.dart';
part 'anime_state.dart';

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final AnimeGetAllUseCase useCase;

  AnimeBloc({
    required this.useCase,
  }) : super(const AnimeInitialState());

  @override
  Stream<AnimeState> mapEventToState(AnimeEvent event) async* {
    if (event is AnimeFetchEvent) {
      yield* mapAnimeFetchEventToState(event);
    } else if (event is AnimePaginateEvent) {
      yield* mapAnimePaginateEventToState(event);
    }
  }

  Stream<AnimeState> mapAnimeFetchEventToState(AnimeFetchEvent event) async* {
    yield const AnimeLoadingState();

    final response = await useCase.call(params: event.params);
    yield response.fold(
      (l) => AnimeErrorState(error: l.message),
      (r) => AnimeSuccessState(animes: r),
    );
  }

  Stream<AnimeState> mapAnimePaginateEventToState(
      AnimePaginateEvent event) async* {
    yield (state as AnimeSuccessState).copyWith(isLoading: true);

    var response = await useCase(params: event.params);
    var paginateState = response.fold((left) {
      if (left is HttpClientError && left.statusCode == 400) {
        return ((state as AnimeSuccessState)
            .copyWith(hasMax: true, isLoading: false));
      } else {
        return (AnimeErrorState(error: left.message));
      }
    }, (right) {
      return AnimeSuccessState(
        animes: (state as AnimeSuccessState).animes..addAll(right),
        isLoading: false,
      );
    });

    yield const AnimeLoadingState();
    yield paginateState;
  }
}
