import 'package:bloc/bloc.dart';
import 'package:fe_astronacci/feature/login/domain/use_cases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase useCase;

  LoginCubit(this.useCase) : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final result = await useCase(email: email, password: password);
    result.fold(
      (err) => emit(LoginFailure(err.message)),
      (data) => emit(LoginSuccess(data.token)),
    );
  }
}
