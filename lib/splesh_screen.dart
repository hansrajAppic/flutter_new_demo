// // ignore_for_file: constant_identifier_names, annotate_overrides, depend_on_referenced_packages, camel_case_types

// import 'dart:async';

// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:bype_techno_projects1/Globale_class/colors.dart';
// import 'package:bype_techno_projects1/Globale_class/shardPreferance.dart';
// import 'package:bype_techno_projects1/homnave_scree.dart';
// import 'package:bype_techno_projects1/onbording_spleshscree.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';

// class Splesh_screen extends StatefulWidget {
//   const Splesh_screen({Key? key}) : super(key: key);

//   @override
//   State<Splesh_screen> createState() => SpleshScrrenState();
// }

// class SpleshScrrenState extends State<Splesh_screen> {
//   static const String KEYLOGIN = "Login";
//   // static const String Mobaile = "UserSaveData";
//   // static const String Password = "UserPassword";
//   static const String LoginData = "UserLogaindetails";

//   @override
//   void initState() {
//     super.initState();
//   _sharedPreferenceData();
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.skyblue,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Image.asset(
//             "assets/images/rsz_1sonitecno.png",
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }

//    Future<void> _sharedPreferenceData() async {
//     // Using the corrected shared preferences utility class
//     bool? isLoggedIn = await SharedPreferenceUtils.getBool(KEYLOGIN);

//     // Scheduling a callback for the end of this frame to ensure BuildContext is valid.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Timer(const Duration(seconds: 1), () {
//         if (isLoggedIn !=null) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>  HomeNaveScreens(
//                   index: 0), // Assuming the corrected name and constructor
//             ),
//           );
//         } else {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) =>
//                   OnBoarding(), // Assuming the corrected name and constructor
//             ),
//           );
//         }
//       });
//     });
//   }
// }

// void main() {
//   runApp(App());
// }

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AnimatedSplashScreen(
//         duration: 3000,
//         splash: 'assets/logo.png', // Make sure you have this asset
//         nextScreen: const Splesh_screen(), // Corrected class name
//         splashTransition: SplashTransition.scaleTransition,
//         pageTransitionType: PageTransitionType.fade,
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }
// }

// ignore_for_file: avoid_print, depend_on_referenced_packages, camel_case_types, constant_identifier_names, annotate_overrides, non_constant_identifier_names, prefer_const_constructors

import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:demo/Globale_class/colors.dart';
import 'package:demo/Globale_class/shardPreferance.dart';
import 'package:demo/homnave_scree.dart';
import 'package:demo/onbording_spleshscree.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Splesh_screen extends StatefulWidget {
  const Splesh_screen({Key? key}) : super(key: key);

  @override
  State<Splesh_screen> createState() => SpleshScrrenState();
}

class SpleshScrrenState extends State<Splesh_screen> {
  static const String KEYLOGIN = "Login";

  @override
  void initState() {
    super.initState();
    shareedpreprancedata();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.skyblue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            "assets/images/rsz_1sonitecno.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void shareedpreprancedata() async {
    var isLoggedIn = await SharedPreferenceUtils.getBool(KEYLOGIN);
    print({isLoggedIn});
    Timer(const Duration(seconds: 1), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeNaveScreens(
                index: 0,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnBoarding(),
            ),
          );
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoarding(),
          ),
        );
      }
    });
  }
}

void Animations() {
  runApp(MaterialApp(
    home: AnimatedSplashScreen(
      duration: 3000,
      splash: 'assets/logo.png', // Your splash image path
      nextScreen:
          Splesh_screen(), // The screen to navigate to after the splash screen
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: Colors.blueAccent,
    ),
  ));
}
