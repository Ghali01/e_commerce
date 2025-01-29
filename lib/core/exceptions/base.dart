abstract class AppException implements Exception {
  //an readable message
  final String message;
  final int code;
  AppException({
    required this.message,
    required this.code,
  });

  @override
  String toString() {
    return '$runtimeType exception == code: $code, message: $message';
  }
}
