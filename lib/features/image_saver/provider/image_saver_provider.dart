import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/loading_popup.dart';
import '../../../common/show_message.dart';

class ImageSaverProvider extends ChangeNotifier {
  bool savedAnimationFlag = false;
  String? pdfPath;
  shareImage(String imagePath) => Share.shareXFiles([XFile(imagePath)]);

  saveImage(String imagePath, BuildContext context) async {
    loadingPopup(context);

    await GallerySaver.saveImage(imagePath)
        .then((value) => Navigator.pop(context));
    showMessage(
        message: "Sucessfully Saved", context: context, color: Colors.green);
    // savedAnimationFlagChanger();
    notifyListeners();
  }

  openImage(String imagePath) => OpenFile.open(imagePath);

  savedAnimationFlagChanger() {
    savedAnimationFlag = !savedAnimationFlag;
    notifyListeners();
  }
}
