import '../../../../../core/helpers/errors/failure.dart';

class AnimeMappperError extends Failure {
  AnimeMappperError({
    required String message,
    required StackTrace stacktrace,
  }) : super(
          message: message,
          stackTrace: stacktrace,
        );
}
