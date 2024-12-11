// import 'package:flutter/material.dart';
// class MoreOptionsMenu extends StatelessWidget {
//   final Function(String) onOptionSelected;

//   MoreOptionsMenu({required this.onOptionSelected});

//   final List<String> moreOptions = [
//     "Sin","Cos","Tan","Cosin"
//   ]; 

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       onSelected: onOptionSelected,
//       itemBuilder: (BuildContext context) {
//         return moreOptions.map((String option) {
//           return PopupMenuItem<String>(
//             value: option,
//             child: Container(
//               width: 150,
//               padding: EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: Colors.blueAccent, // Chỉnh màu nền
//                 borderRadius: BorderRadius.circular(8),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 5,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   option,
                  
//                   style: TextStyle(
                    

//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }).toList();
//       },
//     );
//   }
// }
//ver 2



import 'package:flutter/material.dart';

class MoreOptionsMenu extends StatelessWidget {
  final Function(String) onOptionSelected;

  MoreOptionsMenu({required this.onOptionSelected});

  final List<String> moreOptions = [
    "Sin", "Cos", "Tan", "Cosin"
  ];

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình từ MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Tính toán padding và chiều rộng hộp dựa trên kích thước màn hình
    double horizontalPadding = screenWidth * 0.05; // 5% chiều rộng màn hình
    double verticalPadding = screenHeight * 0.03;  // 3% chiều cao màn hình

    return PopupMenuButton<String>(
      onSelected: onOptionSelected,
      itemBuilder: (BuildContext context) {
        return moreOptions.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Container(
              // Chiều rộng hộp tự động điều chỉnh theo màn hình
              width: screenWidth * 0.4, // Chiếm 40% chiều rộng màn hình
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, // Padding ngang tự tính
                vertical: verticalPadding,    // Padding dọc tự tính
              ),
              decoration: BoxDecoration(
                color: Colors.blueAccent, // Màu nền của hộp
                borderRadius: BorderRadius.circular(8), // Bo tròn góc
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0, 2), // Hiệu ứng bóng
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
