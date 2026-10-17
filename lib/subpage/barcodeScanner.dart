import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Page opened by the big scan button. Placeholder until a camera scanner
/// (for example the `mobile_scanner` package) is added.
class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan barcode')),
      body: const Center(child: Text('Camera scanner goes here')),
    );
  }
}