import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarState(index: 0));

  /// panggil ini saat user tap bottom nav item
  void changeIndex(int newIndex) {
    emit(NavbarState(index: newIndex));
  }
}
