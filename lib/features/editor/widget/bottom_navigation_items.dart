// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common/colors.dart';

class BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const BottomNavigationItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => onPressed(),
        child: SizedBox(
          height: 0,
          width: 100,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              color: AppColor.fgColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    icon,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.montserratAlternates(),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
