import 'package:flutter/material.dart';
class MoreOptionsMenu extends StatelessWidget {
  final Function(String) onOptionSelected;

  MoreOptionsMenu({required this.onOptionSelected});

  final List<String> moreOptions = [
    "Nhân", "Lê", "Thành", "Option 4", "Option 5"
  ]; 

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onOptionSelected,
      itemBuilder: (BuildContext context) {
        return moreOptions.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Container(
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blueAccent, // Chỉnh màu nền
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }).toList();
      },
    );
  }
}
