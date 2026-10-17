import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page opened after typing a barcode number. Placeholder for the
/// product / allergen lookup.
class BarcodeResultPage extends StatelessWidget {
  final String barcode;

  const BarcodeResultPage({super.key, required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Center(child: Text('Barcode: $barcode')),
    );
  }
}