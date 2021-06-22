import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:another_flushbar/flushbar.dart';
import 'custom_button.dart';

class BarcodeScannerPage extends StatefulWidget {
  @override
  _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Произошла ошибка.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Произошла ошибка.';
    }

    if (!mounted) return;

    if (barcodeScanRes == 'ean13')
      setState(() => _scanBarcode = barcodeScanRes);
    else {
      setState(() => _scanBarcode = "");
      Flushbar(
          message: "Результат не равен ean13",
          duration: Duration(seconds: 3)
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomButton(
                            onTap: () => scanBarcodeNormal(),
                            text: 'Начать сканирование'),
                        SizedBox(height: 10),
                        if (_scanBarcode == 'ean13')
                          Text('Результат : $_scanBarcode\n',
                              style: TextStyle(fontSize: 20)
                          )
                      ]
                  )
              );
            })
        )
    );
  }
}