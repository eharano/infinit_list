import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/dtos/dtos.dart';
import '../bloc/book_bloc.dart';
import '../widgets/book_list_item.dart';
import '../widgets/bottom_loader.dart';

class BookView extends StatefulWidget {
  const BookView({Key? key}) : super(key: key);

  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  final _scrollController = ScrollController();
  ValueNotifier<BookDTO> params = ValueNotifier(
    const BookDTO(
      page: 1,
      perPage: 100,
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(BookFetchEvent(params: params.value));
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
    final state = context.read<BookBloc>().state;
    final page = params.value.page;
    if (_isBottom && state is BookSuccessState && !state.isLoading) {
      params.value = params.value.copyWith(page: page + 1);

      context.read<BookBloc>().add(
            BookPaginateEvent(
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

  buildBody(BookState state) {
    switch (state.runtimeType) {
      case BookSuccessState:
        state as BookSuccessState;
        if (state.books.isEmpty) {
          return const Center(
            child: Text('No books.'),
          );
        }

        return ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: state.books.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index >= state.books.length) {
              return Visibility(
                child: const BottomLoader(),
                visible: !state.hasMax,
                replacement: const SizedBox.shrink(),
              );
            }
            return BookListItem(
              book: state.books[index],
            );
          },
        );

      case BookErrorState:
        state as BookErrorState;
        return Center(
          child: Text(state.error),
        );

      case BookLoadingState:
        return const Center(
          child: CircularProgressIndicator(),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<BookBloc>();
    Widget body = buildBody(bloc.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Livros'),
      ),
      body: body,
    );
  }
}
