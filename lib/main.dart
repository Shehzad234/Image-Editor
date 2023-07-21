// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:image_editor/features/editor/screen/crop_screen.dart';
import 'package:image_editor/features/editor/screen/editor_screen.dart';
import 'package:image_editor/features/permission/screen/permission_screen.dart';
import 'package:provider/provider.dart';

import 'features/editor/provider/editor_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EditorProvider())
      ],
      child: MaterialApp(
        routes: {
          EditorScreen.path: (_) => const EditorScreen(),
          CropScreen.path: (_) => const CropScreen(),
        },
        theme: ThemeData(
            primaryColor: Colors.grey,
            textTheme:
                const TextTheme(bodyMedium: TextStyle(color: Colors.white))),
        title: 'Image Editor',
        home: const PermissionScreen(),
      ),
    );
  }
}
