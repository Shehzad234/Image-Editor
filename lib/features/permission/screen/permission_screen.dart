import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/features/editor/screen/editor_screen.dart';
import 'package:image_editor/features/landing/screen/landing_screen.dart';

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const CircleAvatar(
                    maxRadius: 100,
                    minRadius: 100,
                    backgroundImage: AssetImage("assets/icon/icon.png"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Photo/Image\n Editor",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserratAlternates(
                        color: Colors.white, fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      "Unleash the power of your imagination with seamless image editing.",
                      style: GoogleFonts.montserratAlternates(fontSize: 18),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(LandingScreen.path),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color.fromARGB(255, 224, 27, 79)),
                child: Text(
                  "Get Started",
                  style: GoogleFonts.montserratAlternates(),
                ),
              )
            ],
          ),
        ),
        drawer: const Drawer());
  }
}
