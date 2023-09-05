import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/features/about/provider/about_provider.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    AboutProvider aboutProvider = Provider.of<AboutProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 27, 80, 1),
        title: Text(
          "About Us",
          style: GoogleFonts.montserratAlternates(),
        ),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text(
                "App Version",
                style: GoogleFonts.montserratAlternates(),
              ),
              subtitle: Text(
                "Application current Version",
                style: GoogleFonts.montserratAlternates(),
              ),
              trailing: Text(
                "1.0.1",
                style: GoogleFonts.montserratAlternates(
                    color: const Color.fromRGBO(255, 27, 80, 1)),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () => aboutProvider.fbpage(),
              title: Text(
                "Facebook Page",
                style: GoogleFonts.montserratAlternates(),
              ),
              subtitle: Text(
                "Follow us on facebook",
                style: GoogleFonts.montserratAlternates(),
              ),
              trailing: const Icon(
                Icons.facebook,
                color: Color.fromRGBO(255, 27, 80, 1),
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () => aboutProvider.contactUs(),
              title: Text(
                "Contact us",
                style: GoogleFonts.montserratAlternates(),
              ),
              subtitle: Text(
                "Contact us on Email",
                style: GoogleFonts.montserratAlternates(),
              ),
              trailing: const Icon(
                Icons.email,
                color: Color.fromRGBO(255, 27, 80, 1),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "File Path",
                style: GoogleFonts.montserratAlternates(),
              ),
              subtitle: Text(
                "Edit your image",
                style: GoogleFonts.montserratAlternates(),
              ),
              trailing: const Icon(
                Icons.attach_file,
                color: Color.fromRGBO(255, 27, 80, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
