import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/dtos/dtos.dart';
import '../bloc/anime_bloc.dart';
import '../widgets/anime_list_item.dart';
import '../widgets/bottom_loader.dart';

class AnimeView extends StatefulWidget {
  const AnimeView({Key? key}) : super(key: key);

  @override
  State<AnimeView> createState() => _AnimeViewState();
}

class _AnimeViewState extends State<AnimeView> {
  final _scrollController = ScrollController();
  final params = AnimeGetAllDTO(page: 1, perPage: 20);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

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
              if (state.animes.isEmpty) {
                return const Center(
                  child: Text('No animes.'),
                );
              }

              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.animes.length) {
                    return const Text('');
                  }
                  return AnimeListItem(
                    anime: state.animes[index],
                  );
                },
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

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<AnimeBloc>().add(
            const AnimeFetchEvent(
              params: AnimeGetAllDTO(),
            ),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
