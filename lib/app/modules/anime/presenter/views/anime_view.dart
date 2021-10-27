import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_list/app/modules/anime/domain/dtos/dtos.dart';
import 'package:infinit_list/app/modules/anime/presenter/bloc/anime_bloc.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Animes'),
      ),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        bloc: context.read<AnimeBloc>()
          ..add(
            const AnimeFetchEvent(
              params: AnimeGetAllDTO(),
            ),
          ),
        builder: (context, state) {
          switch (state.runtimeType) {
            case AnimeSuccessState:
              state as AnimeSuccessState;
              return Center(
                child: Text(state.animes.length.toString()),
              );

            case AnimeErrorState:
              state as AnimeErrorState;
              return Center(
                child: Text(state.error),
              );

            case AnimeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
