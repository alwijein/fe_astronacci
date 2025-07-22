import 'package:fe_astronacci/feature/home/presentation/cubits/navbar_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fe_astronacci/common/utils/assets/common_images.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/home/di/home_di.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/home_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/home_page.dart';
import 'package:fe_astronacci/feature/login/presentation/cubits/login_cubit.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(text: 'test@mail.io');
  final _passCtrl = TextEditingController(text: 'password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (_) => context.read<LoginCubit>(),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: _listenLoginState,
            builder: _buildLoginState,
          ),
        ),
      ),
    );
  }

  void _listenLoginState(BuildContext ctx, LoginState state) {
    if (state is LoginSuccess) {
      _navigateToHomePage(ctx);
    } else if (state is LoginFailure) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  }

  Widget _buildLoginState(BuildContext ctx, LoginState state) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.1),
            SvgPicture.asset(CommonImages.logo, width: 300),
            SizedBox(height: constraints.maxHeight * 0.1),
            Text(
              "Sign In",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: CommonColors.primaryBlue,
                  ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            _buildForm(state),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(LoginState state) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(
            controller: _emailCtrl,
            hintText: 'Username or Email',
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: _passCtrl,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 24),
          state is LoginLoading
              ? const CircularProgressIndicator()
              : _buildSignInButton(),
          const SizedBox(height: 16),
          _buildForgotPassword(),
          _buildSignUpText(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: CommonColors.fieldBackground,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Please enter $hintText' : null,
    );
  }

  Widget _buildSignInButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          context.read<LoginCubit>().login(
                _emailCtrl.text,
                _passCtrl.text,
              );
        }
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: CommonColors.primaryBlue,
        foregroundColor: CommonColors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
      ),
      child: const Text("Sign in"),
    );
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: CommonColors.grayText),
      ),
    );
  }

  Widget _buildSignUpText() {
    return TextButton(
      onPressed: () {},
      child: const Text.rich(
        TextSpan(
          text: "Don't have an account? ",
          children: [
            TextSpan(
              text: "Sign Up",
              style: TextStyle(color: CommonColors.primaryBlue),
            ),
          ],
        ),
        style: TextStyle(color: CommonColors.grayText),
      ),
    );
  }

  void _navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx) => BlocProvider<NavbarCubit>(
          create: (_) => sl<NavbarCubit>(),
          child: const NavbarPage(),
        ),
      ),
      (route) => false,
    );
  }
}
