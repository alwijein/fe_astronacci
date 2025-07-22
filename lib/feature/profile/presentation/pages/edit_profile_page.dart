import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/profile/di/profile_di.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';
import 'package:fe_astronacci/feature/profile/presentation/cubits/profile_cubit.dart';

class EditProfilePage extends StatefulWidget {
  static const routeName = '/edit_profile';
  final ProfileEntity user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  File? _avatarFile;
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.user.name);
    _emailCtrl = TextEditingController(text: widget.user.email);
    _phoneCtrl = TextEditingController(text: widget.user.phone ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickAndCropImage() async {
    final XFile? picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: picked.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Avatar',
          toolbarColor: CommonColors.primaryBlue,
          toolbarWidgetColor: Colors.white,
        ),
        IOSUiSettings(title: 'Crop Avatar'),
      ],
    );
    if (cropped == null) return;

    setState(() {
      _avatarFile = File(cropped.path);
    });
  }

  void _onSave() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<ProfileCubit>().updateProfile(
            name: _nameCtrl.text,
            email: _emailCtrl.text,
            phone: _phoneCtrl.text,
            avatarPath: _avatarFile?.path,
          );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ProfileCubit>(),
      child: Scaffold(
        backgroundColor: CommonColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CommonColors.primaryBlue,
          foregroundColor: CommonColors.white,
          title: const Text('Edit Profile'),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (ctx, state) {
            state.when(
              initial: () {},
              loading: () {},
              loaded: (_) => Navigator.pop(context),
              logoutSuccess: () {},
              error: (msg) => ScaffoldMessenger.of(ctx).showSnackBar(
                SnackBar(content: Text(msg)),
              ),
            );
          },
          builder: (ctx, state) {
            return SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: CommonColors.softBlue,
                            backgroundImage: _avatarFile != null
                                ? FileImage(_avatarFile!)
                                : NetworkImage(
                                    widget.user.avatar!,
                                  ) as ImageProvider,
                          ),
                          InkWell(
                            onTap: _pickAndCropImage,
                            child: const CircleAvatar(
                              radius: 16,
                              backgroundColor: CommonColors.primaryBlue,
                              child: Icon(
                                Icons.add,
                                color: CommonColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildField('Name', _nameCtrl),
                    _buildField('Email', _emailCtrl,
                        keyboardType: TextInputType.emailAddress),
                    _buildField('Phone', _phoneCtrl,
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor:
                                CommonColors.primaryBlue.withOpacity(0.6),
                          ),
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: state.maybeWhen(
                              loading: () => null, orElse: () => _onSave),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CommonColors.primaryBlue,
                            foregroundColor: CommonColors.white,
                            minimumSize: const Size(120, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: state.maybeWhen(
                            loading: () => const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: CommonColors.white,
                              ),
                            ),
                            orElse: () => const Text('Save'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController ctrl, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: CommonColors.fieldBackground,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (v) => v == null || v.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }
}
