import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../editor/screen/editor_screen.dart';
import '../../../common/widget/my_drawer.dart';

class LandingScreen extends StatefulWidget {
  static const path = "landing-screen";
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    File? profilePicture;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: const Color.fromRGBO(56, 56, 56, 1),
      ),
      backgroundColor: const Color.fromRGBO(56, 56, 56, 1),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Image.asset(
            "assets/icon/icon.png",
            height: screenSize.height * 0.3,
          ),
          SizedBox(height: screenSize.height * 0.08),
          Container(
            height: screenSize.height * 0.05,
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(220, 29, 79, 1),
                borderRadius: BorderRadius.circular(6)),
            child: Center(
              child: Text(
                "Import Your File",
                style: GoogleFonts.montserratAlternates(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: screenSize.height * 0.15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (selectedImage != null) {
                      setState(() {
                        File convertedFile = File(selectedImage.path);
                        profilePicture = convertedFile;
                        Navigator.of(context).pushNamed(EditorScreen.path,
                            arguments: profilePicture);
                      });
                    } else {}
                  },
                  child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 55,
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.03,
                          ),
                          const Icon(
                            Icons.camera,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            "Gallery",
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    XFile? selectedImage = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (selectedImage != null) {
                      setState(() {
                        File convertedFile = File(selectedImage.path);
                        profilePicture = convertedFile;
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamed(EditorScreen.path,
                          arguments: profilePicture);
                    } else {}
                  },
                  child: CircleAvatar(
                    radius: 57,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 55,
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * 0.03,
                          ),
                          const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            "Camera",
                            style: GoogleFonts.montserratAlternates(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      drawer: const AppDrawer(),
    );
  }
}
