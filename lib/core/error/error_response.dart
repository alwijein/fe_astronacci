class ErrorResponse {
  bool? status;
  int? code;
  String? message;

  ErrorResponse({
    this.status,
    this.code,
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        status: json['status'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as String?,
      );
}
