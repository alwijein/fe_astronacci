import 'package:fe_astronacci/common/utils/assets/common_icons.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/register_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/cubits/navbar_cubit.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/home_page.dart';
import 'package:fe_astronacci/feature/home/presentation/pages/navbar_page.dart';
import 'package:fe_astronacci/feature/profile/di/profile_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  static const routeName = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Sign up",
          style: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "Register Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Complete your details to register your account",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Form(
                    key: _formKey,
                    child: _buildProfileForm(context),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  const Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF757575),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileForm(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) => value!.isEmpty ? 'Enter email' : null,
              textInputAction: TextInputAction.next,
              decoration: _buildInputDecoration(
                hint: "Enter your email",
                label: "Email",
                icon: CommonIcons.mailIcon,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: TextFormField(
                controller: _passwordController,
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
                obscureText: true,
                textInputAction: TextInputAction.next,
                decoration: _buildInputDecoration(
                  hint: "Enter your password",
                  label: "Password",
                  icon: CommonIcons.lockIcon,
                ),
              ),
            ),
            TextFormField(
              controller: _firstNameController,
              validator: (value) => value!.isEmpty ? 'Enter first name' : null,
              decoration: _buildInputDecoration(
                hint: "Enter your first name",
                label: "First Name",
                icon: CommonIcons.userIcon,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _lastNameController,
              validator: (value) => value!.isEmpty ? 'Enter last name' : null,
              decoration: _buildInputDecoration(
                hint: "Enter your last name",
                label: "Last Name",
                icon: CommonIcons.userIcon,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: _buildInputDecoration(
                hint: "Enter your phone number",
                label: "Phone Number",
                icon: CommonIcons.phoneIcon,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  state is RegisterLoading ? null : () => _submitForm(context),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: CommonColors.primaryRed,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
              ),
              child: state is RegisterLoading
                  ? const CircularProgressIndicator()
                  : const Text("Register"),
            )
          ],
        );
      },
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required String label,
    required String icon,
  }) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: const TextStyle(color: Color(0xFF757575)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      suffix: SvgPicture.string(icon),
      border: authOutlineInputBorder,
      enabledBorder: authOutlineInputBorder,
      focusedBorder: authOutlineInputBorder.copyWith(
        borderSide: const BorderSide(color: CommonColors.primaryRed),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final fullName =
          '${_firstNameController.text} ${_lastNameController.text}';
      await context
          .read<RegisterCubit>()
          .register(
            name: fullName,
            email: _emailController.text,
            password: _passwordController.text,
            phone: _phoneController.text,
          )
          .then((_) {
        _navigateToHomePage(context);
      });
    }
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

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);
