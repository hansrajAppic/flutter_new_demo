// // ignore_for_file: body_might_complete_normally_nullable, unused_local_variable

// import 'dart:convert';

// import 'package:demo/Json_model/checknumber_model.dart';
// import 'package:demo/Json_model/sendotp_model.dart';
// import 'package:demo/globale_class.dart';
// import 'package:flutter/material.dart';

// Future<Checknumber_model?> checknumberApi(
//     String mobile, BuildContext context, StateSetter setState,  String otp) async {
//   if (mobile != null) {
//     String? deviceID = "";

//     try {
//       String? result = await MyGlobalFunctions.getId();
//       deviceID = result;
//     } catch (error) {
//       print('Error: $error');
//     }
//     String? checknumber = await MyGlobalFunctions.PostCall(
//       '{"MethodName":"checknumber","Mobile":"$mobile"}',
//       "$deviceID",
//     );

//     final data = json.decode(checknumber!);
//     if (data["statuscode"] == "ERR") {
//       OtpPinApi(context, setState, mobile);

//       return Checknumber_model(data);
//     } else {
//       if (data["status"].toString() == "UnAuthorized Person") {}
//     }
//   }
// }

// //  OtpPinApi >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

// Future<void> OtpPinApi(
//   BuildContext context,
//   StateSetter setState,
//   String mobile,
// ) async {
//   String? otp;

//   try {
//     if (mobile != null) {
//       final deviceID = await MyGlobalFunctions.getId();

//       final getServiceList = await MyGlobalFunctions.PostCall(
//         '{"MethodName":"sendotp","MobileNo":"$mobile"}',
//         "$deviceID",
//       );

//       var data = json.decode(getServiceList!);

//       if (data["statuscode"] == "TXN") {
//         sendotp_model responseModel = sendotp_model.fromJson(data);
//         setState(() {
//           otp = responseModel.data?.oTP;
//           print(">>>>>>>>>>>>>>>>>>>${otp}");
//         });
//       }
//     }
//   } catch (error) {
//     print('Error fetching data: $error');
//   }
// }
