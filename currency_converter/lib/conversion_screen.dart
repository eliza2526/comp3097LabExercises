import 'package:flutter/material.dart';

class ConversionScreen extends StatelessWidget {
  final double usd;
  final double cad;
  final double exchangeRate;

  ConversionScreen({
    required this.usd,
    required this.cad,
    required this.exchangeRate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversion Summary")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${usd.toStringAsFixed(2)} USD = \$${cad.toStringAsFixed(2)} CAD',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Exchange Rate: 1 USD = ${exchangeRate.toStringAsFixed(2)} CAD',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}