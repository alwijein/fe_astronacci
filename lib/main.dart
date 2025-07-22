import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/navbar_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/navbar_page.dart';
import 'package:fe_astronacci/feature/profile/di/profile_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fe_astronacci/feature/login/di/login_di.dart' show initLoginDI;
import 'package:fe_astronacci/feature/home/di/home_di.dart' show initHomeDI;
import 'package:fe_astronacci/feature/login/presentation/cubits/login_cubit.dart';
import 'package:fe_astronacci/feature/login/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inisialisasi dependency injection
  await initLoginDI();
  await initHomeDI();
  await initProfileDI();

  String token = await CommonSharedPreferences.shared
      .load<String>(CommonSharedPreferences.headerTokenKey);

  final isLoggedIn = token.isNotEmpty;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frontend Astronacci',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn
          ? BlocProvider(
              create: (_) => sl<NavbarCubit>(),
              child: const NavbarPage(),
            )
          : BlocProvider(
              create: (_) => sl<LoginCubit>(),
              child: const LoginPage(),
            ),
    );
  }
}
