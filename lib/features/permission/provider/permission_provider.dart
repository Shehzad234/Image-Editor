import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/features/landing/screen/landing_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionViewModel extends ChangeNotifier {
  allowPermission({required BuildContext context}) async {
    final info = await DeviceInfoPlugin().androidInfo;
    final androVersion = info.version.release;
    if (int.parse(androVersion) >= 13) {
      await Permission.photos.request();
      await Permission.videos.request();
    } else {
      await Permission.storage.request();
    }
    if (await Permission.storage.isGranted ||
        await Permission.photos.isGranted) {
      // ignore: use_build_context_synchronously
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LandingScreen()));
    }
  }
}
