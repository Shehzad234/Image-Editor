import 'dart:io';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import '../../../common/colors.dart';
import 'editor_screen.dart';

//
class CropScreen extends StatefulWidget {
  static const path = "/crop-screen";
  const CropScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CropScreenState createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final controller = CropController(
    aspectRatio: 1,
    defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
  );

  @override
  Widget build(BuildContext context) {
    String imagePath = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: CropImage(
        controller: controller,
        image: Image.file(File(imagePath)),
        paddingSize: 25.0,
        alwaysMove: true,
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 50,
        color: AppColor.bottomNavigationColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColor.fgColor),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
                onPressed: () async {
                  Image image = await controller.croppedImage();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditorScreen(cropedImage: image)));
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColor.fgColor),
                child: const Text("Done")),
          ],
        ),
      ),
    );
  }
}

Widget cropWidget(
    {required BuildContext context,
    required String imagePath,
    required EditorProvider editorProvider}) {
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
            image: Image.file(File(imagePath)),
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
                onPressed: () => Navigator.of(context).pop(),
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
