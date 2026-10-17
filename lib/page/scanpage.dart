import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../subpage/barcodeResult.dart';
import '../subpage/barcodeScanner.dart';

/// Main scan tab: a large scan button in the centre and a field below it
/// for typing a barcode number by hand. Each leads to its own page.
class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openScanner() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BarcodeScannerPage()),
    );
  }

  void _submitBarcode() {
    final String code = _controller.text.trim();

    // Common barcode lengths: EAN-8, UPC-A (12), EAN-13, ITF-14.
    const validLengths = {8, 12, 13, 14};
    if (!validLengths.contains(code.length)) {
      setState(() => _error = 'Enter 8, 12, 13 or 14 digits');
      return;
    }

    setState(() => _error = null);
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BarcodeResultPage(barcode: code)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Large centre scan button.
            ElevatedButton(
              onPressed: _openScanner,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                fixedSize: const Size(200, 200),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                elevation: 6,
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, size: 80),
                  SizedBox(height: 8),
                  Text(
                    'Scan barcode',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Manual barcode entry.
            const Text(
              'Or type the barcode number',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.search,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(14),
              ],
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
              onSubmitted: (_) => _submitBarcode(),
              decoration: InputDecoration(
                hintText: 'e.g. 7310865004703',
                errorText: _error,
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  color: Colors.green.shade800,
                  onPressed: _submitBarcode,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}