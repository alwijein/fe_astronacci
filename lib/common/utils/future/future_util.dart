import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/core/domain/models/error_type.dart';
import 'package:fe_astronacci/core/error/error_response.dart';

typedef EitherError<T> = Either<ErrorDto, T>;
typedef FutureOrError<T> = Future<EitherError<T>>;

class FutureUtil {
  static FutureOrError<T> callOrError<T>(
    Future<T> Function() block, {
    bool isLoginPage = false,
  }) async {
    try {
      return Right(await block());
    } on DioException catch (e) {
      Log.debug('lagi error nih 2 respones :${e.response?.data}');
      switch (e.type) {
        case DioExceptionType.connectionTimeout ||
              DioExceptionType.sendTimeout ||
              DioExceptionType.receiveTimeout:
          return Left(
            ErrorDto(
              message: 'Gagal menghubungkan ke server,coba lagi',
              errorType: ErrorType.connectionTimeout,
            ),
          );
        case DioExceptionType.badResponse:
          Log.debug('lagi error nih2 ${e.response?.statusCode}');
          Log.debug('lagi error nih2 ${e.response?.statusMessage}');
          var statusCode = e.response?.statusCode ?? 0;
          var message = '';
          var errorCode = '0';
          try {
            var r = ErrorResponse(
              status: false,
              code: e.response?.statusCode,
              message: e.response?.statusMessage ?? 'Unknown error',
            );
            message = r.message ?? '';
            errorCode = r.code.toString();
          } on Exception {
            message = 'Unknown Error';
          }

          switch (statusCode) {
            case 400:
              final responseData = e.response?.data;
              final errorMessage = responseData is Map<String, dynamic>
                  ? responseData['error'] ?? 'Bad Request'
                  : 'Bad Request';

              return Left(
                ErrorDto(
                  message: errorMessage,
                  errorCode: errorCode,
                  errorType: ErrorType.badRequest,
                ),
              );

            case 401:
              final responseData = e.response?.data;
              final errorMessage = responseData is Map<String, dynamic> &&
                      responseData.containsKey('meta')
                  ? responseData['meta']['message'] ?? 'Unauthorized'
                  : 'Unauthorized';
              if (!isLoginPage) {
                // Jika tidak di halaman login, direct ke halaman splash
                // TODO: Remove SharedPreferences if needed
              }
              return Left(
                ErrorDto(
                  message: errorMessage,
                  errorCode: errorCode,
                  errorType: ErrorType.unauthorized,
                ),
              );

            case 404:
              final responseData = e.response?.data;
              final errorMessage = responseData is Map<String, dynamic> &&
                      responseData.containsKey('meta')
                  ? responseData['meta']['message'] ?? 'Data tidak ditemukan'
                  : 'Data tidak ditemukan';
              return Left(
                ErrorDto(
                  message: errorMessage,
                  errorCode: errorCode,
                  errorType: ErrorType.notFound,
                ),
              );
            case 500:
              return Left(
                ErrorDto(
                  message: 'Terjadi Kesalahan Server, silakan coba lagi',
                  errorCode: errorCode,
                  errorType: ErrorType.internalServerError,
                ),
              );
            case 99281:
            default:
              return Left(
                ErrorDto(
                  message: message,
                  errorCode: errorCode,
                  errorType: ErrorType.unknown,
                ),
              );
          }
        case DioExceptionType.cancel:
        case DioExceptionType.unknown:
          return Left(
            ErrorDto(message: 'Terjadi kesalahan, silakan coba lagi nanti'),
          );
        case DioExceptionType.badCertificate:
        case DioExceptionType.connectionError:
          return Left(
            ErrorDto(
              message: 'Pastikan Anda terhubung ke internet',
              errorType: ErrorType.connectionTimeout,
            ),
          );
      }
    } on Exception catch (e) {
      return Left(ErrorDto(message: e.toString()));
    } on ArgumentError catch (e) {
      return Left(ErrorDto(message: e.message));
    } catch (e) {
      Log.debug('Unexpected error: $e');
      return Left(ErrorDto(message: 'Terjadi kesalahan yang tidak diketahui'));
    }
  }
}
