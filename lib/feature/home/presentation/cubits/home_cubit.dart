import 'package:bloc/bloc.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';
import 'package:fe_astronacci/feature/home/domain/use_cases/get_users_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUsersUseCase _getUsers;
  int _page = 1;
  final List<UserEntity> _accumulated = [];
  bool _hasMore = true;
  bool _isFetching = false;

  HomeCubit(this._getUsers) : super(HomeInitial());

  Future<void> fetchUsers({bool isInitial = true}) async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    try {
      if (isInitial) {
        emit(HomeLoading());
      } else {
        emit(HomeLoaded(_accumulated, _hasMore, isLoadingMore: true));
      }

      final result = await _getUsers(page: _page);

      result.fold(
        (err) => emit(HomeError(err.message)),
        (users) {
          if (users.isEmpty) {
            _hasMore = false;
          } else {
            _accumulated.addAll(users
                .map((e) => e.copyWith(
                      avatar: e.avatar == null
                          ? 'https://testing.sulapaeppastudio.com/public/default_avatar.png'
                          : 'https://testing.sulapaeppastudio.com/storage/${e.avatar}',
                    ))
                .toList());
            _page++;
          }
          emit(HomeLoaded(_accumulated, _hasMore));
        },
      );
    } finally {
      _isFetching = false;
    }
  }
}
