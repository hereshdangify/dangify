import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xff2F3645),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Iconsax.arrow_left_2, color: Colors.white, size: 24),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 22)),
            Icon(Icons.more_horiz, color: Colors.white, size: 26),
          ],
        ),
      ),
    );
  }
}
