import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/book/domain/usecases/usecases.dart';
import 'modules/book/infra/repositories/book_repository_impl.dart';
import 'modules/book/presenter/bloc/book_bloc.dart';
import 'modules/book/presenter/views/book_view.dart';

import 'core/adapters/http_client/http_client_adapter_impl.dart';
import 'core/helpers/url/book_url.dart';
import 'modules/book/external/datasources/book_remote_datasource_impl.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BookBloc(
              useCase: context.read<BookGetAllUseCaseImpl>(),
            ),
          ),
        ],
        child: const MaterialApp(
          home: BookView(),
        ),
      ),
      providers: [
        RepositoryProvider(
          create: (context) => Dio(),
        ),
        RepositoryProvider(
          create: (context) => HttpClientAdapterImpl(
            dio: context.read<Dio>(),
            url: BooksUrl.search,
          ),
        ),
        RepositoryProvider(
          create: (context) => BookRemoteDataSourceImpl(
            httpClient: context.read<HttpClientAdapterImpl>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookRepositoryImpl(
            dataSource: context.read<BookRemoteDataSourceImpl>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => BookGetAllUseCaseImpl(
            repository: context.read<BookRepositoryImpl>(),
          ),
        ),
      ],
    );
  }
}
