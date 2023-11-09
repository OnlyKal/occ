import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

Color mainColor = const Color.fromARGB(255, 218, 132, 3);
void goTo(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

double fullHeight(context) {
  return MediaQuery.of(context).size.height;
}

double fullWidth(context) {
  return MediaQuery.of(context).size.width;
}

double topHeight(context) {
  return MediaQuery.of(context).padding.top;
}

input(ctx, controller, label, width) {
  return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 5),
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 244, 244, 244)),
      width: width,
      child: TextField(
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
            label: Text(
          label,
          style: const TextStyle(fontSize: 13.6),
        )),
        controller: controller,
      ));
}

inputDescription(ctx, controller, label, width) {
  return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 5),
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration:
          const BoxDecoration(color: Color.fromARGB(255, 244, 244, 244)),
      width: width,
      child: TextField(
        style: const TextStyle(fontSize: 13),
        maxLines: 6,
        decoration: InputDecoration(
            label: Text(
          label,
          style: const TextStyle(fontSize: 13.6),
        )),
        controller: controller,
      ));
}

Future<void> goUrl(url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
