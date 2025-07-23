part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSearching extends HomeState {}

class HomeLoaded extends HomeState {
  final List<UserEntity> users;
  final bool hasMore;
  final bool isLoadingMore;

  HomeLoaded(this.users, this.hasMore, {this.isLoadingMore = false});
}

class HomeSearchResult extends HomeState {
  final List<UserEntity> users;
  HomeSearchResult(this.users);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
