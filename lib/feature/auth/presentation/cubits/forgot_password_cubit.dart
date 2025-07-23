import 'package:bloc/bloc.dart';
import 'package:fe_astronacci/feature/auth/domain/use_cases/forgot_password_use_case.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase useCase;

  ForgotPasswordCubit(this.useCase) : super(ForgotPasswordInitial());

  Future<void> sendResetEmail(String email) async {
    emit(ForgotPasswordLoading());
    final result = await useCase(email: email);
    result.fold(
      (err) => emit(ForgotPasswordFailure(err.message)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }
}
