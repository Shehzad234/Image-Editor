import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(255, 27, 80, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: Text(
            "About",
            style: GoogleFonts.montserratAlternates(fontSize: 30),
          ),
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
