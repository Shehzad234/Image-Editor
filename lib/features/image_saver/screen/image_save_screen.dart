import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/features/image_saver/provider/image_saver_provider.dart';

import 'package:flutter/material.dart';
import 'package:image_editor/features/image_saver/widgets/function_button.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';

class SaveScreen extends StatelessWidget {
  static const path = "/save=screen";
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ImageSaverProvider saverProvider = Provider.of<ImageSaverProvider>(context);
    String imagePath = ModalRoute.of(context)!.settings.arguments as String;
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Sucessfully Saved",
              style: GoogleFonts.montserratAlternates())),
      body: Container(
          margin: EdgeInsets.only(top: screenSize.height * 0.1),
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 500, child: Image.file(File(imagePath))),
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.04),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FunctionButton(
                          icon: Icons.share_outlined,
                          name: "Share",
                          onTap: () => saverProvider.shareImage(imagePath)),
                      FunctionButton(
                          icon: Icons.play_arrow_outlined,
                          name: "Open",
                          onTap: () => saverProvider.openImage(imagePath)),
                      FunctionButton(
                          icon: Icons.download_outlined,
                          name: "Download",
                          onTap: () =>
                              saverProvider.saveImage(imagePath, context)),
                    ]),
              )
            ],
          )),
    );
  }
}
