import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  final Function() onLogoutPressed;

  const AppBarWidget({required this.onLogoutPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 85, 85, 224),
      title: Stack(
        children: [
          Text(
            'Turf Cleaner',
            style: GoogleFonts.playfairDisplay(
              textStyle: Theme.of(context).textTheme.displayLarge,
              color: const Color.fromARGB(255, 255, 255, 255),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: onLogoutPressed,
      ),
      actions: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 0, 201, 85),
                width: 2,
              )),
          child: const Icon(
            Icons.wifi_rounded,
            color: Color.fromARGB(255, 0, 255, 4),
            size: 26,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

 @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);