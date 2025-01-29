class Failure {
  final String message;
  final int code;

  const Failure({required this.message, required this.code});

  @override
  String toString() {
    return '$runtimeType failure == code: $code, message: $message';
  }
}
