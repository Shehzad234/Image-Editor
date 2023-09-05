import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/about/screen/about_us.dart';
import '../../features/landing/screen/landing_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white.withOpacity(0.5),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: const EdgeInsets.only(top: 30),
        children: [
          SizedBox(height: 180, child: Image.asset('assets/icon/icon.png')),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Image Editor",
              style: GoogleFonts.montserratAlternates(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          const Divider(),
          Card(
            child: ListTile(
              onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  LandingScreen.path, (route) => false),
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
          Card(
            child: ListTile(
              onTap: () => Share.share(
                  "https://play.google.com/store/apps/details?id=com.betabyte.image.editor"),
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
              onTap: () => launchUrl(
                  Uri.parse(
                      "https://play.google.com/store/apps/details?id=com.betabyte.image.editor"),
                  mode: LaunchMode.externalApplication),
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
