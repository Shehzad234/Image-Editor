import 'dart:io';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import '../../../common/colors.dart';

//
Widget cropWidget(
    {required BuildContext context, required EditorProvider editorProvider}) {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );
  return SizedBox(
    height: editorProvider.isCropedflag ? 800 : 0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 500,
          child: CropImage(
            controller: controller,
            image: Image.file(File(editorProvider.image!)),
            paddingSize: 25.0,
            alwaysMove: true,
          ),
        ),
        Container(
          width: double.infinity,
          height: 50,
          color: AppColor.bottomNavigationColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => editorProvider.isCropFlagChanger(),
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.fgColor),
                child: Text(
                  "Cancel",
                  style: GoogleFonts.montserratAlternates(),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Image image = await controller.croppedImage();
                    Future.delayed(const Duration(milliseconds: 500))
                        .then((value) {
                      editorProvider.editorController.undo();
                      editorProvider.editorController
                          .addView(Image(image: image.image));
                    });

                    editorProvider.isCropFlagChanger();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.fgColor),
                  child: Text(
                    "Done",
                    style: GoogleFonts.montserratAlternates(),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}
