import '../../../../../core/helpers/errors/failure.dart';

class BookMappersError extends Failure {
  BookMappersError({
    required String message,
    required StackTrace stacktrace,
  }) : super(
          message: message,
          stackTrace: stacktrace,
        );
}
