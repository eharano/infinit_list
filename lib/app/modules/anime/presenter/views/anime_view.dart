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
  ValueNotifier<AnimeDTO> params = ValueNotifier(
    const AnimeDTO(
      page: 1,
      perPage: 100,
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<AnimeBloc>().add(AnimeFetchEvent(params: params.value));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final state = context.read<AnimeBloc>().state;
    final page = params.value.page;
    if (_isBottom && state is AnimeSuccessState && !state.isLoading) {
      params.value = params.value.copyWith(page: page + 1);

      context.read<AnimeBloc>().add(
            AnimePaginateEvent(
              params: params.value,
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

  buildBody(AnimeState state) {
    switch (state.runtimeType) {
      case AnimeSuccessState:
        state as AnimeSuccessState;
        if (state.animes.isEmpty) {
          return const Center(
            child: Text('No animes.'),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.animes.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index >= state.animes.length) {
              return Visibility(
                child: const BottomLoader(),
                visible: !state.hasMax,
                replacement: const SizedBox.shrink(),
              );
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
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<AnimeBloc>();
    Widget body = buildBody(bloc.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Animes'),
      ),
      body: body,
    );
  }
}
