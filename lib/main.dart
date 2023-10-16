import 'dart:js';

import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'HomePage.dart';

void main() {
  runApp(DevicePreview(
      builder: (context){
        return MyApp();
  }
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

