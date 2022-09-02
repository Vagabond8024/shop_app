class HttpExeptions implements Exception {
  final String message;

  HttpExeptions(this.message);

  @override
  String toString() {
    return message;
  }
}
