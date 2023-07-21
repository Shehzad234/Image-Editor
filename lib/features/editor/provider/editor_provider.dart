import 'dart:developer';
import 'dart:io';

import 'package:easy_image_editor/easy_image_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor/common/colors.dart';
import 'package:image_editor/features/editor/res/colors.dart';
import 'package:path_provider/path_provider.dart';

class EditorProvider extends ChangeNotifier {
  late EasyImageEditorController editorController;
  bool isCropedflag = false;
  String? image;

  isCropFlagChanger() {
    isCropedflag = !isCropedflag;
    notifyListeners();
  }

  Future<void> saveImage(Uint8List imageBytes) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/my_image.png';
    log(imagePath);
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes);
  }

  assignPathToImage(String path) {
    image = path;
    notifyListeners();
  }

  void addText(int? position, Text? text, BuildContext context) {
    final textEditController = TextEditingController(text: text?.data);
    Color? textColor = Colors.white;

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, stateSetter) {
            return Container(
              color: const Color.fromARGB(215, 161, 144, 144),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: textEditController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        fillColor: Colors.white10,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none)),
                        hintText: "Enter Text",
                      ),
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: colorArray.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            stateSetter(() {
                              textColor = colorArray[index];
                            });
                          },
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            color: colorArray[index],
                          ),
                        );
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (textEditController.text.isNotEmpty) {
                        Navigator.pop(context);

                        if (text == null) {
                          editorController.addView(
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                textEditController.text,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: textColor ?? Colors.white,
                                ),
                              ),
                            ),
                            widgetType: "text",
                          );
                        } else {
                          editorController.updateView(
                            position!,
                            Text(
                              textEditController.text,
                              style: TextStyle(
                                fontSize: 20.0,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 100.0,
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: AppColor.fgColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: const Center(
                        child: Text("Add"),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  addBg({required BuildContext context}) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: colorArray.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    editorController.addBackgroundColor(colorArray[index]);
                  },
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    color: colorArray[index],
                  ),
                );
              },
            ),
          );
        });
  }

  afterCropping() {}
}
