import 'package:flutter/material.dart';
import 'package:image_editor/features/image_saver/screen/image_save_screen.dart';
import 'package:image_editor/features/landing/screen/landing_screen.dart';
import '../features/editor/screen/editor_screen.dart';

class AppConsts {
  static Map<String, Widget Function(BuildContext)> routes = {
    EditorScreen.path: (_) => const EditorScreen(),
    SaveScreen.path: (_) => const SaveScreen(),
    LandingScreen.path: (_) => const LandingScreen(),
  };
}
