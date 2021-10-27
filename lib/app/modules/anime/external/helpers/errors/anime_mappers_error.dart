import '../../../../../core/helpers/errors/failure.dart';

class AnimeMappersError extends Failure {
  AnimeMappersError({
    required String message,
    required StackTrace stacktrace,
  }) : super(
          message: message,
          stackTrace: stacktrace,
        );
}
