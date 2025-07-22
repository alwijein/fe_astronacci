import 'package:fe_astronacci/feature/profile/data/data_sources/network/profile_remote_ds.dart';
import 'package:fe_astronacci/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:fe_astronacci/feature/profile/domain/repositories/profile_repository.dart';
import 'package:fe_astronacci/feature/profile/domain/use_cases/get_profile_user_case.dart';
import 'package:fe_astronacci/feature/profile/domain/use_cases/update_profile_usecase.dart';
import 'package:fe_astronacci/feature/profile/presentation/cubits/profile_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
Future<void> initProfileDI() async {
  // Data source
  sl.registerLazySingleton<IProfileRemoteDataSource>(
      () => ProfileRemoteDataSource());

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));

  // Cubit
  sl.registerFactory(() => ProfileCubit(sl(), sl()));
}
