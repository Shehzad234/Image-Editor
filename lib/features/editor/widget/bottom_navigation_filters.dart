import 'package:flutter/material.dart';
import 'package:image_editor/features/editor/provider/editor_provider.dart';
import 'package:image_editor/features/editor/utils/filters.dart';

import '../../../common/colors.dart';

Widget bottomNavigationFilters(Widget image, EditorProvider editorProvider) {
  return Container(
      width: double.infinity,
      height: 100,
      color: AppColor.bottomNavigationColor,
      child: ListView.builder(
        itemCount: listOfFilters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => editorProvider.filterIndexChanger(index),
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: 90,
                width: 90,
                child: ColorFiltered(
                    colorFilter: listOfFilters[index], child: image)),
          );
        },
      ));
}
