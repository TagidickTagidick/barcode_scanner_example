import 'package:briskly/barcode_scanner_page.dart';
import 'package:flutter/material.dart';
import 'barcode_scanner_page.dart';
import 'custom_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BarcodeScannerPage()
    );
  }
}
