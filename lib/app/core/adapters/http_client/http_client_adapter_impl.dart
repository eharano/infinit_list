import 'package:dio/dio.dart' hide HttpClientAdapter;

import '../../helpers/errors/http_client_error.dart';
import 'http_client_adapter.dart';
import 'response_adapter.dart';

class HttpClientAdapterImpl implements HttpClientAdapter {
  final Dio dio;
  final String url;

  HttpClientAdapterImpl({
    required this.dio,
    required this.url,
  });

  @override
  Future<ResponseAdapter> get({
    required Map<String, dynamic> queries,
  }) async {
    final response = await dio.get(url, queryParameters: queries);
    if (!(response.statusCode == 200)) {
      throw HttpClientError(
        response.statusMessage ?? 'Erro inesperado',
        StackTrace.current,
        statusCode: response.statusCode,
      );
    }

    return ResponseAdapter(
      data: response.data,
      statusCode: response.statusCode!,
    );
  }
}
