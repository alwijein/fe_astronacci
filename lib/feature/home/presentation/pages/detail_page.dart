import 'package:flutter/material.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/home/domain/entities/user_entity.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final UserEntity user;

  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: CommonColors.primaryRed,
        foregroundColor: CommonColors.white,
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Gradient Background
            _buildProfileHeader(context),
            const SizedBox(height: 24),

            // Profile Information Card
            _buildInfoCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 32),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CommonColors.primaryRed,
            CommonColors.primaryRed.withOpacity(0.7),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'avatar-${user.id}',
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: CommonColors.white,
                  width: 4.0,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: CommonColors.softRed,
                backgroundImage: NetworkImage(user.avatar ??
                    'https://testing.sulapaeppastudio.com/public/default_avatar.png'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: CommonColors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: CommonColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildInfoItem(
            context,
            icon: Icons.badge_outlined,
            label: 'USER ID',
            value: '@${user.id}',
          ),
          const Divider(height: 32),
          _buildEmailItem(context),
          const Divider(height: 32),
          _buildInfoItem(
            context,
            icon: Icons.person_outline_outlined,
            label: 'Name',
            value: user.name,
          ),
          const Divider(height: 32),
          _buildInfoItem(
            context,
            icon: Icons.person_outline_outlined,
            label: 'Phone',
            value: user.phone ?? 'Not provided',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CommonColors.primaryRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: CommonColors.primaryRed, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: CommonColors.grayText,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: CommonColors.black,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailItem(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CommonColors.primaryRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.email_outlined,
            color: CommonColors.primaryRed,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EMAIL ADDRESS',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: CommonColors.grayText,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                user.email,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: CommonColors.primaryRed,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
