import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/common/colors.dart';

class FunctionButton extends StatelessWidget {
  final IconData icon;
  final String name;
  final VoidCallback onTap;
  const FunctionButton(
      {super.key, required this.icon, required this.name, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.fgColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () => onTap(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(icon),
            )),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.montserratAlternates(),
        )
      ],
    );
  }
}
