import 'package:fe_astronacci/feature/auth/data/data_sources/network/register_remote_ds.dart';
import 'package:fe_astronacci/feature/auth/data/repositories/register_repository_impl.dart';
import 'package:fe_astronacci/feature/auth/domain/repositories/register_repository.dart';
import 'package:fe_astronacci/feature/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:fe_astronacci/feature/auth/domain/use_cases/register_usecase.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/forgot_password_cubit.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/register_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fe_astronacci/feature/auth/data/data_sources/network/auth_remote_ds.dart';
import 'package:fe_astronacci/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:fe_astronacci/feature/auth/domain/repositories/auth_repository.dart';
import 'package:fe_astronacci/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/login_cubit.dart';

final sl = GetIt.instance;
Future<void> initLoginDI() async {
  initLoginModule();
}

void initLoginModule() {
  sl.registerLazySingleton<IAuthRemoteDataSource>(() => AuthRemoteDataSource());

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => LoginUseCase(sl()));

  sl.registerFactory(() => LoginCubit(sl()));

  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));

  sl.registerFactory(() => ForgotPasswordCubit(sl()));

  sl.registerLazySingleton<IRegisterRemoteDataSource>(
    () => RegisterRemoteDataSource(),
  );

  sl.registerLazySingleton<RegisterRepository>(
    () => RegisterRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  sl.registerFactory(() => RegisterCubit(sl()));
}
