import 'package:infinit_list/app/core/adapters/http_client/response_adapter.dart';

abstract class HttpClientAdapter {
  Future<ResponseAdapter> get({
    required Map<String, dynamic> queries,
  });
}
