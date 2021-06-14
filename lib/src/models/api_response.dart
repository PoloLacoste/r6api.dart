class ApiResponse<T> {
  final T? data;
  final bool success;
  final String? error;

  ApiResponse({
    this.data,
    required this.success,
    this.error,
  });
}
