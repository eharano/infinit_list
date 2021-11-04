import 'failure.dart';

class HttpClientError extends Failure {
  final int? statusCode;

  HttpClientError(String message, StackTrace stackTrace, {this.statusCode})
      : super(
          message: message,
          stackTrace: stackTrace,
        );
}
