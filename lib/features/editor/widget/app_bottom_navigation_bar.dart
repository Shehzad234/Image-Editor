import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common/colors.dart';
import '../../../common/show_message.dart';
import '../../image_saver/screen/image_save_screen.dart';
import 'bottom_navigation_items.dart';

@override
Widget appBottomNavigationBar(
    {required BuildContext context,
    required Widget? image,
    required EditorProvider editorProvider,
    required int? currentWidgetIndex}) {
  // log(editorProvider.image!);
  return Container(
    width: double.infinity,
    height: 80,
    color: AppColor.bottomNavigationColor,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        BottomNavigationItem(
            title: "Add Image",
            icon: Icons.add_photo_alternate_outlined,
            onPressed: () async {
              // ignore: invalid_use_of_visible_for_testing_member
              final pickimage = await ImagePicker.platform
                  .getImage(source: ImageSource.gallery);
              if (pickimage != null) {
                editorProvider.assignPathToImage(pickimage.path);
                editorProvider.editorController.addView(
                    Image.file(
                      File(editorProvider.image!),
                    ),
                    widgetType: "image");
                Future.delayed(const Duration(milliseconds: 250)).then(
                    (value) => editorProvider.editorController.saveEditing());
              }
            }),
        BottomNavigationItem(
            title: "Crop",
            icon: Icons.crop,
            onPressed: () => editorProvider.isCropFlagChanger()),
        BottomNavigationItem(
            title: "Left",
            icon: Icons.rotate_left_outlined,
            onPressed: () {
              try {
                editorProvider.editorController
                    .rotateView(currentWidgetIndex ?? 0, -90);
              } catch (e) {
                try {
                  editorProvider.editorController
                      .rotateView(currentWidgetIndex ?? 1, -90);
                } catch (e) {
                  log(e.toString());
                }
              }
            }),
        BottomNavigationItem(
            title: "Rigth",
            icon: Icons.rotate_right_outlined,
            onPressed: () {
              try {
                editorProvider.editorController
                    .rotateView(currentWidgetIndex ?? 0, 90);
              } catch (e) {
                log(e.toString());

                try {
                  editorProvider.editorController
                      .rotateView(currentWidgetIndex ?? 1, -90);
                } catch (e) {
                  log(e.toString());
                }
              }
            }),
        BottomNavigationItem(
            title: "Bg Color",
            icon: Icons.color_lens,
            onPressed: () => editorProvider.addBg(context: context)),
        BottomNavigationItem(
            title: "Bg Image",
            icon: Icons.image_outlined,
            onPressed: () => editorProvider.addImage(context)),
        BottomNavigationItem(
            title: "Add Text",
            icon: Icons.text_fields,
            onPressed: () => editorProvider.addText(null, null, context)),
        BottomNavigationItem(
            title: "Filters",
            icon: Icons.filter,
            onPressed: () {
              if (image != null) {
                editorProvider.isFilterFlagChanger();
              } else {
                showMessage(message: "Select Image", color: Colors.green);
              }
            }),
        BottomNavigationItem(
            title: "Save",
            icon: Icons.save,
            onPressed: () async {
              await editorProvider.saveImage(context).then((value) {
                log(value.toString());
                Navigator.of(context)
                    .pushNamed(SaveScreen.path, arguments: value!);
              });
            }),
      ],
    ),
  );
}
