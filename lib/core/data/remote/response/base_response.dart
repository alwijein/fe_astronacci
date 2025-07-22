class BaseResponse<T> {
  final bool? status;
  final int? code;
  final String? message;
  final T? data;

  BaseResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      BaseResponse<T>(
        status: json['status'] as bool?,
        code: json['code'] as int?,
        message: json['message'] as String?,
        data: json['data'] == null ? null : fromJsonT(json['data']),
      );
}
