import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutProvider extends ChangeNotifier {
  contactUs() {
    final url =
        Uri(scheme: "mailto", path: "sadiqkhan61651@gmail.com?subject=&body=");
    launchUrl(url, mode: LaunchMode.externalApplication);
  }

  fbpage() {
    final url = Uri(scheme: "https", path: "www.facebook.com/betabytetech/");
    launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
// https://play.google.com/store/apps/details?id=com.whatsapp.voicemessages.saver