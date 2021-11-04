import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_list/app/modules/anime/domain/usecases/usecases.dart';
import 'package:infinit_list/app/modules/anime/infra/repositories/anime_repository_impl.dart';
import 'package:infinit_list/app/modules/anime/presenter/bloc/anime_bloc.dart';
import 'package:infinit_list/app/modules/anime/presenter/views/anime_view.dart';

import 'core/adapters/http_client/http_client_adapter_impl.dart';
import 'core/helpers/url/anime_url.dart';
import 'modules/anime/external/datasources/anime_remote_datasource_impl.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AnimeBloc(
              useCase: context.read<AnimeGetAllUseCaseImpl>(),
            ),
          ),
        ],
        child: const MaterialApp(
          home: AnimeView(),
        ),
      ),
      providers: [
        RepositoryProvider(
          create: (context) => Dio(),
        ),
        RepositoryProvider(
          create: (context) => HttpClientAdapterImpl(
            dio: context.read<Dio>(),
            url: AnimeUrl.anime,
          ),
        ),
        RepositoryProvider(
          create: (context) => AnimeRemoteDataSourceImpl(
            httpClient: context.read<HttpClientAdapterImpl>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AnimeRepositoryImpl(
            dataSource: context.read<AnimeRemoteDataSourceImpl>(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AnimeGetAllUseCaseImpl(
            repository: context.read<AnimeRepositoryImpl>(),
          ),
        ),
      ],
    );
  }
}
