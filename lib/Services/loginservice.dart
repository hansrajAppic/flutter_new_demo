// ignore_for_file: unnecessary_brace_in_string_interps, non_constant_identifier_names

import 'dart:convert';

import 'package:demo/Globale_class/shardPreferance.dart';
import 'package:demo/Services/iloginservice.dart';
import 'package:demo/globale_class.dart';
import 'package:demo/splesh_screen.dart';

class LoginService implements ILoginService {
  @override
  Future<String> Login(String mobile, String password) async {
    String requestBody =
        '{"MethodName":"getlogindetails","UserID":"${mobile}"," password":"${password}", "AppType": " Apps"  }';

    String? deviceID = await MyGlobalFunctions.getId();

    String? Response = await MyGlobalFunctions.PostCall(requestBody, deviceID);
    var data = jsonDecode(Response.toString());
    if (data["statuscode"] == "TXN") {
      SharedPreferenceUtils.setValue("mob", mobile);
      SharedPreferenceUtils.setValue("pass", password);
      SharedPreferenceUtils.setBool( SpleshScrrenState.KEYLOGIN, true);
    } else {
      if (data["status"].toString() == "UnAuthorized Person") {
        SharedPreferenceUtils.setValue("mob", mobile);
        SharedPreferenceUtils.setValue("pass", password);
       SharedPreferenceUtils.setBool(SpleshScrrenState.KEYLOGIN, true);
      } else {}
    }
     return Response.toString();
  }
}
