import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/about/screen/about_us.dart';
import '../../features/landing/screen/landing_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(230, 235, 235, 1),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(),
            child: Image.asset('assets/icon/icon.png'),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const LandingScreen();
              }));
            },
            child: Card(
              child: ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Color.fromRGBO(225, 27, 80, 1),
                ),
                title: Text(
                  "Home",
                  style: GoogleFonts.montserratAlternates(),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.share,
                color: Color.fromRGBO(225, 27, 80, 1),
              ),
              title: Text(
                "Share",
                style: GoogleFonts.montserratAlternates(),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.star,
                color: Color.fromRGBO(225, 27, 80, 1),
              ),
              title: Text(
                "Rate us",
                style: GoogleFonts.montserratAlternates(),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const AboutUs();
              }));
            },
            child: Card(
              child: ListTile(
                leading: const Icon(
                  Icons.info,
                  color: Color.fromRGBO(255, 27, 80, 1),
                ),
                title: Text(
                  "About us",
                  style: GoogleFonts.montserratAlternates(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
