import 'package:flutter/material.dart';
import 'package:image_editor/features/editor/utils/filters.dart';
import 'package:image_editor/features/editor/widget/bottom_navigation_filters.dart';

import '../provider/editor_provider.dart';

Widget filterWidget(
    {required BuildContext context,
    required Widget image,
    required EditorProvider editorProvider}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
          height: editorProvider.isFliterFlag ? 600 : 0,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: listOfFilters[editorProvider.fliterIndex],
                    child: SizedBox(height: 500, child: image),
                  )
                ]),
          )),
      bottomNavigationFilters(image, editorProvider)
    ],
  );
}
