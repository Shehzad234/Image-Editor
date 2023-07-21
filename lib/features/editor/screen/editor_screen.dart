import 'dart:developer';
import 'dart:io';

import 'package:easy_image_editor/easy_image_editor.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:image_editor/features/editor/screen/crop_screen.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../widget/bottom_navigation_items.dart';

class EditorScreen extends StatefulWidget {
  static const path = "/editor-screen";
  const EditorScreen({Key? key, this.cropedImage}) : super(key: key);

  final Image? cropedImage;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int? currentWidgetIndex;
  String imagePath = "";
  @override
  Widget build(BuildContext context) {
    EditorProvider editorProvider = Provider.of<EditorProvider>(context);

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: editorProvider.isCropedflag
          ? AppBar(
              backgroundColor: Colors.transparent,
            )
          : AppBar(
              backgroundColor: Colors.transparent,
              title: const Text("Image Editor"),
              actions: [
                IconButton(
                  onPressed: () => editorProvider.editorController.undo(),
                  icon: const Icon(Icons.undo),
                ),
                IconButton(
                  onPressed: () => editorProvider.editorController.redo(),
                  icon: const Icon(Icons.redo),
                ),
                IconButton(
                  onPressed: () =>
                      editorProvider.editorController.saveEditing(),
                  icon: const Icon(Icons.done_all),
                ),
              ],
            ),
      body: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        onTap: () => editorProvider.editorController.hideViewControl(),
        child: Stack(children: [
          editorProvider.isCropedflag
              ? cropWidget(
                  context: context,
                  imagePath: imagePath,
                  editorProvider: editorProvider)
              : const SizedBox(),
          Center(
            child: SizedBox(
              height: editorProvider.isCropedflag ? 0 : 550,
              width: double.infinity,
              child: EditorView(
                clickToFocusAndMove: false,
                onClick: (p0, p1, p2) {
                  currentWidgetIndex = p0;
                  log(currentWidgetIndex.toString());
                },
                onViewTouch: (p0, p1, p2) {
                  currentWidgetIndex = p0;
                  log(currentWidgetIndex.toString());
                },
                onInitialize: (controller) {
                  setState(() {
                    editorProvider.editorController = controller;
                  });
                },
              ),
            ),
          ),
        ]),
      ),
      bottomNavigationBar: editorProvider.isCropedflag
          ? const SizedBox()
          : Container(
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
                            .getImage(source: ImageSource.gallery) as XFile;
                        imagePath = pickimage.path;
                        editorProvider.assignPathToImage(pickimage.path);
                        editorProvider.editorController.addView(
                            Image.file(
                              File(editorProvider.image!),
                            ),
                            widgetType: "image");
                        Future.delayed(const Duration(milliseconds: 250)).then(
                            (value) =>
                                editorProvider.editorController.saveEditing());
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
                          log(e.toString());
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
                        }
                      }),
                  BottomNavigationItem(
                      title: "Background",
                      icon: Icons.color_lens,
                      onPressed: () => editorProvider.addBg(context: context)),
                  BottomNavigationItem(
                      title: "Add Text",
                      icon: Icons.text_fields,
                      onPressed: () =>
                          editorProvider.addText(null, null, context)),
                  BottomNavigationItem(
                      title: "Filters",
                      icon: Icons.filter,
                      onPressed: () {
                        // Add filters
                      }),
                  BottomNavigationItem(
                      title: "Save",
                      icon: Icons.save,
                      onPressed: () {
                        editorProvider.editorController
                            .saveEditing()
                            .then((value) {
                          if (value != null) {
                            log("Move to Next Page");
                            editorProvider.saveImage(value);
                          }
                        });
                      }),
                ],
              ),
            ),
    );
  }
}
