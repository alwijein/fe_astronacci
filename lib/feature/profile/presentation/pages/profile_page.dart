import 'package:cached_network_image/cached_network_image.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/common/utils/local_storage/common_shared_preferences.dart';
import 'package:fe_astronacci/feature/auth/presentation/cubits/login_cubit.dart';
import 'package:fe_astronacci/feature/auth/presentation/pages/login_page.dart';
import 'package:fe_astronacci/feature/profile/di/profile_di.dart';
import 'package:fe_astronacci/feature/profile/presentation/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_astronacci/feature/profile/presentation/cubits/profile_cubit.dart';
import 'package:fe_astronacci/feature/profile/domain/entities/profile_entity.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<ProfileCubit>()..getProfile(),
      child: Scaffold(
        backgroundColor: CommonColors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CommonColors.primaryRed,
          foregroundColor: CommonColors.white,
          title: const Text('Profile'),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (user) => _buildContent(context, user),
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileEntity user) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Profile Picture
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: CommonColors.softRed, width: 2),
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: user.avatar != null && user.avatar!.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: user.avatar!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 120,
                        height: 120,
                        color: CommonColors.softRed,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 120,
                        height: 120,
                        color: Colors.red,
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Container(
                      width: 120,
                      height: 120,
                      color: CommonColors.softRed,
                      child: const Icon(Icons.person,
                          size: 60, color: Colors.white),
                    ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: CommonColors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: CommonColors.grayText,
                ),
          ),
          const Divider(height: 32),
          _InfoRow(
              icon: Icons.person_2_outlined, label: 'Nama', value: user.name),
          _InfoRow(
              icon: Icons.info_outlined,
              label: 'User ID',
              value: '@${user.id}'),
          _InfoRow(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: user.phone ?? '-'),
          _InfoRow(
              icon: Icons.email_outlined, label: 'Email', value: user.email),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: CommonColors.white,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                final profileCubit = context.read<ProfileCubit>();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                      value: profileCubit,
                      child: EditProfilePage(user: user),
                    ),
                  ),
                );
              },
              child: const Text('Edit Profile'),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity, // Membuat tombol full width
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CommonColors.black,
                foregroundColor: CommonColors.white,
                shape: const StadiumBorder(),
                minimumSize: const Size.fromHeight(48), // Tinggi tombol
              ),
              onPressed: () {
                CommonSharedPreferences.shared
                    .removeData(CommonSharedKey.userProfile);
                CommonSharedPreferences.shared
                    .removeData(CommonSharedPreferences.headerTokenKey);

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (ctx) => BlocProvider<LoginCubit>(
                      create: (_) => sl<LoginCubit>(),
                      child: const LoginPage(),
                    ),
                  ),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon, color: CommonColors.primaryRed),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: CommonColors.black.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: CommonColors.grayText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
