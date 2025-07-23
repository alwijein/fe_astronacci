import 'package:bloc/bloc.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';
import 'package:fe_astronacci/feature/profile/domain/use_cases/get_profile_user_case.dart';
import 'package:fe_astronacci/feature/profile/domain/use_cases/update_profile_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_cubit.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;
  const factory ProfileState.loading() = _Loading;
  const factory ProfileState.loaded(ProfileEntity user) = _Loaded;
  const factory ProfileState.error(String message) = _Error;
}

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  ProfileCubit(this.getProfileUseCase, this.updateProfileUseCase)
      : super(const ProfileState.initial());

  Future<void> getProfile() async {
    emit(const ProfileState.loading());
    final result = await getProfileUseCase();
    result.fold(
      (l) => emit(ProfileState.error(l.message)),
      (r) => emit(ProfileState.loaded(r.copyWith(
        avatar: r.avatar == null
            ? 'https://testing.sulapaeppastudio.com/public/default_avatar.png'
            : 'https://testing.sulapaeppastudio.com/storage/${r.avatar}',
      ))),
    );
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? avatarPath,
  }) async {
    emit(const ProfileState.loading());

    final result = await updateProfileUseCase(
      name: name,
      email: email,
      phone: phone,
      avatarPath: avatarPath,
    );
    result.fold(
      (l) => emit(ProfileState.error(l.message)),
      (r) => emit(ProfileState.loaded(r.copyWith(
        avatar: r.avatar == null
            ? 'https://testing.sulapaeppastudio.com/public/default_avatar.png'
            : 'https://testing.sulapaeppastudio.com/storage/${r.avatar}',
      ))),
    );
  }
}
