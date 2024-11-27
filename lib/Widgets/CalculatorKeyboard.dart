import 'package:flutter/material.dart';

class CalculatorKeyboard extends StatelessWidget {
  final Function(String) onButtonPressed; // Add the callback function as a parameter

  // Constructor to receive the callback function
  CalculatorKeyboard({Key? key, required this.onButtonPressed}) : super(key: key);

  final List<String> buttons = [
    "C", "DEL", "%", "/",
    "9", "8", "7", "x",
    "6", "5", "4", "-",
    "3", "2", "1", "+",
    "0", ".", "ANS", "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: buttons.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 4 columns in GridView
          childAspectRatio: 1.5, // Ratio of button size, makes buttons wider
          crossAxisSpacing: 8,  // Space between columns
          mainAxisSpacing: 8,   // Space between rows
        ),
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () => onButtonPressed(buttons[index]), // Trigger the callback here
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Background color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners for the buttons
              ),
              padding: EdgeInsets.symmetric(vertical: 20), // Button height
            ),
            child: Text(
              buttons[index],
              style: TextStyle(fontSize: 24, color: Colors.white), // Button text style
            ),
          );
        },
      ),
    );
  }
}
