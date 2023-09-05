import 'dart:developer';
import 'dart:io';

import 'package:easy_image_editor/easy_image_editor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor/common/loading_popup.dart';
import 'package:image_editor/common/widget/my_drawer.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import 'package:image_editor/features/editor/screen/filter_screen.dart';
import 'package:image_editor/features/editor/widget/app_bottom_navigation_bar.dart';
import 'package:image_editor/features/editor/screen/crop_screen.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';

class EditorScreen extends StatefulWidget {
  static const path = "/editor-screen";
  const EditorScreen({Key? key, this.cropedImage}) : super(key: key);

  final Image? cropedImage;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  int? currentWidgetIndex;
  bool? flag;
  Widget? image;
  @override
  void initState() {
    flag = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EditorProvider editorProvider = Provider.of<EditorProvider>(context);
    if (flag != null) {
      log("triggered");
      Future.delayed(const Duration(milliseconds: 200))
          .then((value) => loadingPopup(context));
      Future.delayed(const Duration(seconds: 2)).then((value) {
        final temp = ModalRoute.of(context)!.settings.arguments as File;
        editorProvider.assignPathToImage(temp.path);
        editorProvider.editorController.addView(Image.file(temp));
        Future.delayed(const Duration(milliseconds: 200))
            .then((value) => editorProvider.editorController.hideViewControl());
        Navigator.of(context).pop();
      });
      flag = null;
    }
    return WillPopScope(
      onWillPop: () async {
        if (editorProvider.isCropedflag || editorProvider.isFliterFlag) {
          editorProvider.isFilterFlagChanger();

          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColor.bgColor,
        appBar: editorProvider.isFliterFlag
            ? AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                    onPressed: () {
                      editorProvider.isFilterFlagChanger();
                    },
                    icon: const Icon(Icons.arrow_back)),
                actions: [
                  IconButton(
                      onPressed: () => editorProvider.doneFilter(
                          image ?? const SizedBox(), context),
                      icon: const Icon(Icons.done))
                ],
              )
            : editorProvider.isCropedflag
                ? AppBar(
                    backgroundColor: Colors.transparent,
                  )
                : AppBar(
                    backgroundColor: Colors.transparent,
                    title: Text(
                      "Image Editor",
                      style: GoogleFonts.montserratAlternates(),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () =>
                            editorProvider.editorController.saveEditing(),
                        icon: const Icon(Icons.done),
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
                ? cropWidget(context: context, editorProvider: editorProvider)
                : const SizedBox(),
            Center(
              child: SizedBox(
                height:
                    editorProvider.isCropedflag || editorProvider.isFliterFlag
                        ? 0
                        : 550,
                width: double.infinity,
                child: EditorView(
                  clickToFocusAndMove: false,
                  onClick: (p0, p1, p2) {
                    currentWidgetIndex = p0;
                    image = p1;
                    setState(() {});
                    log(currentWidgetIndex.toString());
                  },
                  onViewTouch: (p0, p1, p2) {
                    currentWidgetIndex = p0;
                    image = p1;
                    setState(() {});
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
            if (editorProvider.isFliterFlag && image != null) ...{
              filterWidget(
                  context: context,
                  image: image!,
                  editorProvider: editorProvider)
            }
          ]),
        ),
        bottomNavigationBar: editorProvider.isFliterFlag
            ? const SizedBox()
            : editorProvider.isCropedflag
                ? const SizedBox()
                : appBottomNavigationBar(
                    image: image,
                    context: context,
                    editorProvider: editorProvider,
                    currentWidgetIndex: currentWidgetIndex),
        drawer: const AppDrawer(),
      ),
    );
  }
}
