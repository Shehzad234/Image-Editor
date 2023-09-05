import 'package:flutter/material.dart';

class MyTest extends StatelessWidget {
  final Widget image;
  const MyTest({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: image,
    );
  }
}
