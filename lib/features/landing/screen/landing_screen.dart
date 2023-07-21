import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(
                      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/photo-editor-app-icon-design-template-4422455fe13e1c4e7008958f0b058eb5_screen.jpg?ts=1577021462")),
            ),
          ),
          const Text(
            "Image Editor",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.camera_alt_outlined)),
                ElevatedButton(
                    onPressed: () {}, child: const Icon(Icons.filter))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
