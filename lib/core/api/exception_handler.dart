class ExceptionHandler implements Exception {
  final dynamic message;

  ExceptionHandler([this.message]);

  String get error => this.message; 
  String toString() {
    Object? message = this.message;
    if (message == null) return "Exception";
    return "Exception: $message";
  }
}