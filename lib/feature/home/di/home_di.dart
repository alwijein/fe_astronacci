import 'package:fe_astronacci/feature/home/presentation/cubits/navbar_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:fe_astronacci/feature/home/data/data_sources/network/user_remote_ds.dart';
import 'package:fe_astronacci/feature/home/data/repositories/user_repository_impl.dart';
import 'package:fe_astronacci/feature/home/domain/repositories/user_repository.dart';
import 'package:fe_astronacci/feature/home/domain/use_cases/get_users_usecase.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/home_cubit.dart';

final sl = GetIt.instance;
Future<void> initHomeDI() async {
  initHomeModule();
}

void initHomeModule() {
  sl.registerLazySingleton<IUserRemoteDataSource>(() => UserRemoteDataSource());
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));
  sl.registerFactory(() => HomeCubit(sl()));
  sl.registerFactory(() => NavbarCubit());
}
