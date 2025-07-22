import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fe_astronacci/common/utils/typedef_util.dart';
import 'package:fe_astronacci/core/error/failure.dart';

abstract class UseCase<T, Params> {
  const UseCase();

  Future<Either<Failure, T>> call(Params params);
}

/// [NOTE] This UseCase can return ErrorDto on Left, so you can get message from the API
abstract class UseCaseB<T, Params> {
  const UseCaseB();

  FutureOrError<T> call(Params params);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
