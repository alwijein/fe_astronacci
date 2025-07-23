import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fe_astronacci/core/domain/models/error_dto.dart';
import 'package:fe_astronacci/feature/auth/domain/use_cases/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterCubit(this.registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    emit(RegisterLoading());
    final result = await registerUseCase(
      name: name,
      email: email,
      password: password,
      phone: phone,
    );
    result.fold(
      (error) => emit(RegisterError(error.message)),
      (_) => emit(RegisterSuccess()),
    );
  }
}
