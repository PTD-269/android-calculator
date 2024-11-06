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
      home: DefaultTabController(
        length: 3, // Updated to 3 for the new tab
        child: Scaffold(
          appBar: AppBar(
            title: Text('Calculator App'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Basic Calculator'),
                Tab(text: 'Programmer Calculator'),
                Tab(text: 'Currency Calculator'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BasicCalculatorUI(),
              ProgrammerCalculatorUI(),
              CurrencyCalculatorUI(), // New currency calculator UI
            ],
          ),
        ),
      ),
    );
  }
}
