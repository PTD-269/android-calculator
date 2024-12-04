import 'package:flutter/material.dart';

class ProgrammerKeyboard extends StatelessWidget {
  final Function(String) onButtonPressed;
  final double scale; // Tham số điều chỉnh kích thước

  ProgrammerKeyboard({
    required this.onButtonPressed,
    this.scale = 1, // Mặc định là kích thước gốc
  });

  final List<String> buttons = [
    "A", "B", "C", "D", "E", "F", // Các ký tự Hexadecimal
    "7", "8", "9", "/",
    "4", "5", "6", 
    "1", "2", "3", "-",
    "0", ".", "+", "=",
    "CE", "x", "÷"
  ];

  Color getButtonColor(String button) {
    final Map<String, Color> buttonColors = {
      "A": Colors.blueAccent,
      "B": Colors.blueAccent,
      "C": Colors.blueAccent,
      "D": Colors.blueAccent,
      "E": Colors.blueAccent,
      "CE": Colors.orange,
      "=": Colors.blue,
      "/": Colors.orange,
      "x": Colors.orange,
      "-": Colors.orange,
      "+": Colors.orange,
      "%": Colors.orange,
      "<<": Colors.grey,
      ">>": Colors.grey,
      "+/-": Colors.grey,
    };

    return buttonColors[button] ?? Colors.blueAccent;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth - 40) / 5 * scale;  
    double buttonHeight = buttonWidth * 0.75;

    double fontSize = 16 * scale;  
    double buttonPadding = buttonWidth * 0.2 * scale; 

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(  
        child: Column(  
          children: [
            GridView.builder(
              shrinkWrap: true, 
              // physics: NeverScrollableScrollPhysics(),  // Tắt cuộn của GridView
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: buttonWidth / buttonHeight,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                String button = buttons[index];
                Color buttonColor = getButtonColor(button);

                return ElevatedButton(
                  onPressed: () => onButtonPressed(button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: buttonPadding),  
                  ),
                  child: Text(
                    button,
                    style: TextStyle(fontSize: fontSize, color: Colors.white),  
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
