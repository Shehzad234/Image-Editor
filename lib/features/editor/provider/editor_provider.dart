import 'dart:developer';
import 'dart:io';

import 'package:easy_image_editor/easy_image_editor.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/common/colors.dart';
import 'package:image_editor/features/editor/res/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/loading_popup.dart';
import '../utils/filters.dart';

class EditorProvider extends ChangeNotifier {
  late EasyImageEditorController editorController;
  bool isCropedflag = false;
  bool isFliterFlag = false;
  int fliterIndex = 0;
  String? image;
  ImagePicker imagePicker = ImagePicker();
  String currentImagePath = "";

  filterIndexChanger(int index) {
    fliterIndex = index;
    notifyListeners();
  }

  isCropFlagChanger() {
    isCropedflag = !isCropedflag;
    notifyListeners();
  }

  isFilterFlagChanger() {
    isFliterFlag = !isFliterFlag;
    notifyListeners();
  }

  doneFilter(Widget image, BuildContext context) {
    isFilterFlagChanger();

    Future.delayed(const Duration(milliseconds: 250)).then((value) {
      editorController.undo();
      editorController.addView(ColorFiltered(
        colorFilter: listOfFilters[fliterIndex],
        child: image,
      ));
    });
  }

  Future<String?> saveImage(BuildContext context) async {
    loadingPopup(context);
    final imageBytes = await editorController.saveEditing();
    final directory = await getExternalStorageDirectory();
    final name = DateTime.now().microsecond.toString();
    final imagePath = '${directory!.path}/$name.png';
    log(imagePath);
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes!);
    Navigator.of(context).pop();
    return imagePath;
  }

  assignPathToImage(String path) {
    image = path;
    notifyListeners();
  }

  currentImagePathSetter(String image) {
    currentImagePath = image;
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
              color: const Color.fromARGB(213, 201, 195, 195),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: textEditController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        fillColor: Colors.black26,
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

  addImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () async {
                  final XFile? image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                    currentImagePath = image.path;
                    editorController.addBackgroundView(Image.file(
                      File(image.path),
                      fit: BoxFit.fill,
                    ));
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Set Background Image",
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
