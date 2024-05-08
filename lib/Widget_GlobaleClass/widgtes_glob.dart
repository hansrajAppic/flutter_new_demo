// import 'package:flutter/material.dart';
// class GlobalTextField extends StatelessWidget {
//   final Widget fieldIcon;
//   final String fieldText;        
//   final TextEditingController fieldController;
//   final bool
//       isEnabled; // This should be a named parameter with a default value.

//   // Convert `isEnabled` to a named parameter and assign a default value of `true`.
//   const GlobalTextField({
//     required this.fieldIcon,
//     required this.fieldText,
//     required this.fieldController,
//     this.isEnabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: fieldController,
//       enabled:
//           isEnabled, // No need for the null-aware operator (??) since `isEnabled` now has a default value.
//       decoration: InputDecoration(
//         hintText: fieldText,
//         prefixIcon: fieldIcon,
//         hintStyle: TextStyle(color: Colors.grey),
//         filled: true,
//         fillColor: Colors.white70,
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color.fromRGBO(198, 57, 93, 1)),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Color.fromRGBO(198, 57, 93, 1)),
//         ),
//       ),
//       cursorColor: Color.fromRGBO(198, 57, 93, 1),
//     );
//   }
// }
