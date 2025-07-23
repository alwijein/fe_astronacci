import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fe_astronacci/common/utils/logging/common_log.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';
import 'package:fe_astronacci/feature/home/domain/use_cases/get_users_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetUsersUseCase _getUsers;
  int _page = 1;
  List<UserEntity> _accumulated = [];
  bool _hasMore = true;
  bool _isFetching = false;

  Timer? _searchDebounce;
  String _currentSearch = '';

  HomeCubit(this._getUsers) : super(HomeInitial());

  Future<void> fetchUsers({bool isInitial = true, String? search}) async {
    if (search != null && _currentSearch != search) {
      _resetPagination();
      _currentSearch = search;
      emit(HomeLoading());
    }

    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    try {
      if (isInitial && _accumulated.isEmpty) {
        emit(HomeLoading());
      } else if (isInitial) {
        emit(HomeSearching());
      } else {
        emit(HomeLoaded(_accumulated, _hasMore, isLoadingMore: true));
      }

      final result = await _getUsers(page: _page, search: search);

      result.fold(
        (err) => emit(HomeError(err.message)),
        (users) {
          Log.debug('Ini Data: ${_accumulated.length}');
          if (search != null && search.isNotEmpty) {
            _accumulated = users
                .map((e) => e.copyWith(
                      avatar: e.avatar == null
                          ? 'https://testing.sulapaeppastudio.com/public/default_avatar.png'
                          : 'https://testing.sulapaeppastudio.com/storage/${e.avatar}',
                    ))
                .toList();
            emit(HomeSearchResult(_accumulated));
          } else {
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
          }
        },
      );
    } finally {
      _isFetching = false;
    }
  }

  void searchUsers(String query) {
    _currentSearch = query;
    _searchDebounce?.cancel();

    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        _resetPagination();
        fetchUsers();
      } else {
        fetchUsers(search: query);
      }
    });
  }

  void _resetPagination() {
    _page = 1;
    _accumulated = [];
    _hasMore = true;
    emit(HomeInitial());
  }

  @override
  Future<void> close() async {
    _searchDebounce?.cancel();
    await super.close();
  }
}
