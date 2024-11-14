// main.dart
import 'package:flutter/material.dart';
import 'BasicCalc/BasicCalculatorUI.dart';
import 'ProgrammerCalc/ProgrammerCalculatorUI.dart';
import 'CurrencyCalc/CurrencyCalculatorUI.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  int _selectedIndex = 0; // Index for selected calculator type

  // Function to switch calculator type based on drawer selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close the drawer after selection
  }

  // Function to build each calculator UI based on selected index
  Widget _buildCalculatorUI() {
    switch (_selectedIndex) {
      case 0:
        return BasicCalculatorUI();
      case 1:
        return ProgrammerCalculatorUI();
      case 2:
        return CurrencyCalculatorUI();
      default:
        return BasicCalculatorUI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator App'),
      ),
      body: _buildCalculatorUI(), // Display the selected calculator UI
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text(
                'Choose Calculator Type',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.calculate),
              title: Text('Basic Calculator'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Programmer Calculator'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text('Currency Calculator'),
              onTap: () => _onItemTapped(2),
            ),
          ],
        ),
      ),
    );
  }
}
