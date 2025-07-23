import 'package:fe_astronacci/common/utils/assets/common_icons.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/forgot_password_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(100)),
);

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ForgotPasswordCubit>(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Email reset berhasil dikirim')),
            );
            Navigator.pop(context);
          } else if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                "Forgot Password",
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
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Please enter your email and we will send \nyou a new password to your account",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF757575)),
                        ),
                        // const SizedBox(height: 16),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.15),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (email) {},
                                onChanged: (email) {},
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  }
                                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                      .hasMatch(value)) {
                                    return 'Format email salah';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  labelText: "Email",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF757575)),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  suffix:
                                      SvgPicture.string(CommonIcons.mailIcon),
                                  border: authOutlineInputBorder,
                                  enabledBorder: authOutlineInputBorder,
                                  focusedBorder:
                                      authOutlineInputBorder.copyWith(
                                    borderSide: const BorderSide(
                                      color: CommonColors.primaryRed,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1),
                              ElevatedButton(
                                onPressed: state is ForgotPasswordLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<ForgotPasswordCubit>()
                                              .sendResetEmail(
                                                _emailCtrl.text,
                                              );
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: CommonColors.primaryRed,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 48),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  ),
                                ),
                                child: state is ForgotPasswordLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text("Continue"),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
