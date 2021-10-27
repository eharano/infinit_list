import 'failure.dart';

class HttpClientError extends Failure {
  HttpClientError(String message, StackTrace stackTrace)
      : super(
          message: message,
          stackTrace: stackTrace,
        );
}
