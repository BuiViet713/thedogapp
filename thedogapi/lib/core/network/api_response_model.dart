class ApiResponse {
  dynamic message;
  String? status;

  ApiResponse({
    this.message,
    this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      message: json['message'],
      status: json['status'],
    );
  }
}
