import 'package:flutter/material.dart';
import 'MoreOptionsMenu.dart';

class CalculatorKeyboard extends StatelessWidget {
  final Function(String) onButtonPressed;

  CalculatorKeyboard({Key? key, required this.onButtonPressed})
      : super(key: key);

  final List<String> buttons = [
    "More",
    "C",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "=",
  ];



  Color getButtonColor(String button) {
    final Map<String, Color> buttonColors = {
      "More": Colors.white38,
      "C": Colors.orange,
      "=": Colors.orange,
      "/": Colors.orange,
      "x": Colors.orange,
      "-": Colors.orange,
      "+": Colors.orange,
      "%": Colors.orange
    };

    return buttonColors[button] ?? Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double buttonWidth = (screenWidth - 40) / 4;
    double buttonHeight = buttonWidth * 0.75;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: buttons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: buttonWidth / buttonHeight,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          String button = buttons[index];
          Color buttonColor = getButtonColor(button);

          //more using PopupMenuButton
          if (button == "More") {
            return MoreOptionsMenu(
              onOptionSelected: (value) {
                // Khi chọn một option trong menu, gọi hàm onButtonPressed
                onButtonPressed(value);
              },
            );
          }

          //style another button
          return ElevatedButton(
            onPressed: () => onButtonPressed(button),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor, // variable contains the color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: buttonWidth * 0.2),
            ),
            child: Text(
              button,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
