import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';

typedef EitherError<T> = Either<ErrorDto, T>;
typedef FutureOrError<T> = Future<EitherError<T>>;
