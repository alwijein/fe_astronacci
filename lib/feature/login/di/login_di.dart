import 'package:get_it/get_it.dart';
import 'package:fe_astronacci/feature/login/data/data_sources/network/auth_remote_ds.dart';
import 'package:fe_astronacci/feature/login/data/repositories/auth_repository_impl.dart';
import 'package:fe_astronacci/feature/login/domain/repositories/auth_repository.dart';
import 'package:fe_astronacci/feature/login/domain/use_cases/login_usecase.dart';
import 'package:fe_astronacci/feature/login/presentation/cubits/login_cubit.dart';

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
}
