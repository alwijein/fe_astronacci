import 'package:flutter/material.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';
import 'package:fe_astronacci/feature/home/presentation/widgets/circle_avatar_with_active_indicator.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.name,
    required this.email,
    required this.image,
    required this.isActive,
    required this.press,
    required this.heroTag,
  });

  final String name, email, image;
  final bool isActive;
  final VoidCallback press;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: heroTag,
        child: CircleAvatarWithActiveIndicator(
          image: image,
          isActive: isActive,
          radius: 28,
        ),
      ),
      title: Text(name, style: const TextStyle(color: CommonColors.black)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          email,
          style: const TextStyle(
            color: CommonColors.grayText,
          ),
        ),
      ),
    );
  }
}
