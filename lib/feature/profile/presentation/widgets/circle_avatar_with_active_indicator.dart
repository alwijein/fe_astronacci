import 'package:flutter/material.dart';
import 'package:fe_astronacci/common/utils/color/common_colors.dart';

class CircleAvatarWithActiveIndicator extends StatelessWidget {
  const CircleAvatarWithActiveIndicator({
    super.key,
    this.image,
    this.radius = 24,
    this.isActive,
  });

  final String? image;
  final double? radius;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(image!),
        ),
        if (isActive!)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: CommonColors.primaryRed,
                shape: BoxShape.circle,
                border: Border.all(
                  color: CommonColors.white,
                  width: 3,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
