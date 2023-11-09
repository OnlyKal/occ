import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import './export.dart';

void main()  {

  runApp(const MaterialApp(
    home: Scaffold(
      body: ImagePickerWidget(),
    ),
  ));
}
