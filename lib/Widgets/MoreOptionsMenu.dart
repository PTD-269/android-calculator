
import 'package:flutter/material.dart';

class MoreOptionsMenu extends StatelessWidget {
  final Function(String) onOptionSelected;

  MoreOptionsMenu({required this.onOptionSelected});

  final List<String> moreOptions = [
    "sin", "cos", "tan", "cot"
  ];

  @override
  Widget build(BuildContext context) {
    // media query to get size 
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


    double horizontalPadding = screenWidth * 0.05; 
    double verticalPadding = screenHeight * 0.03;  

    return PopupMenuButton<String>(
      onSelected: onOptionSelected,
      itemBuilder: (BuildContext context) {
        return moreOptions.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Container(
             // height adjust depending on device
              width: screenWidth * 0.4, 
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, 
                vertical: verticalPadding,   
              ),
              // box 
              decoration: BoxDecoration(
                color: Colors.blueAccent, 
                borderRadius: BorderRadius.circular(8), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2), 
                  ),
                ],
              ),
              child: Center( // Căn chữ chính giữa
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }).toList();
      },
    );
  }
}