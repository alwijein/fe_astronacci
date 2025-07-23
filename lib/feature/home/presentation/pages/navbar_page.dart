import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/home/di/home_di.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/home_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/navbar_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/home_page.dart';
import 'package:fe_astronacci/feature/profile/presentation/cubits/profile_cubit.dart';
import 'package:fe_astronacci/feature/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavbarPage extends StatelessWidget {
  static const routeName = '/navbar';
  const NavbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Cubit untuk handle nav index
        BlocProvider<NavbarCubit>(
          create: (_) => NavbarCubit(),
        ),
        // Cubit untuk HomePage
        BlocProvider<HomeCubit>(
          create: (_) => sl<HomeCubit>()..fetchUsers(isInitial: true),
        ),
        // Cubit untuk ProfilePage
        BlocProvider(
          create: (_) => sl<ProfileCubit>()..getProfile(),
        ),
      ],
      child: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.index,
              children: const [
                HomePage(),
                ProfilePage(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.index,
              onTap: (idx) => context.read<NavbarCubit>().changeIndex(idx),
              items: [
                navbarItem(
                  context: context,
                  icon: Icons.home_filled,
                  label: 'Home',
                ),
                navbarItem(
                  context: context,
                  icon: Icons.person_2_rounded,
                  label: 'Profile',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem navbarItem({
    required BuildContext context,
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: Icon(icon, size: 24, color: CommonColors.primaryRed),
      icon: Icon(icon, size: 24, color: CommonColors.softRed),
      label: label,
    );
  }
}
