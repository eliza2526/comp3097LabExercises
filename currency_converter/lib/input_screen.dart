import 'package:flutter/material.dart';
import 'conversion_screen.dart';

class InputScreen extends StatefulWidget {
    @override
    _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
    final TextEditingController _usdController = TextEditingController();
    final TextEditingController _cadController = TextEditingController();
    final double exchangeRate = 1.35;

    void updateUSD(String value) {
        double usd = double.tryParse(value) ?? 0.0;
        setState(() {
            _cadController.text = (usd * exchangeRate).toStringAsFixed(2);
        });
    }

    void updateCAD(String value){
        double cad = double.tryParse(value) ?? 0.0;
        setState(() {
            _usdController.text = (cad / exchangeRate).toStringAsFixed(2);
        });
    }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Currency Input")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usdController,
              decoration: InputDecoration(
                labelText: 'USD',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: updateUSD,
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _cadController,
              decoration: InputDecoration(
                labelText: 'CAD',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: updateCAD,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversionScreen(
                      usd: double.tryParse(_usdController.text) ?? 0.0,
                      cad: double.tryParse(_cadController.text) ?? 0.0,
                      exchangeRate: exchangeRate,
                    ),
                  ),
                );
              },
              child: Text('View Conversion Summary'),
            ),
          ],
        ),
      ),
    );
  }
}