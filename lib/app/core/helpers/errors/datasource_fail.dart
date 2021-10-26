import 'failure.dart';

class DataSourceFail extends Failure {
  DataSourceFail(String message, StackTrace stacktrace)
      : super(
          message: message,
          stackTrace: stacktrace,
        );
}
