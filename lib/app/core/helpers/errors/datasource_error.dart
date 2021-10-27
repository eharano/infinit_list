import 'failure.dart';

class DataSourceError extends Failure {
  DataSourceError({
    required String message,
    required StackTrace stacktrace,
  }) : super(
          message: message,
          stackTrace: stacktrace,
        );
}
