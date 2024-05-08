
import 'dart:convert';

import 'package:demo/Globale_class/shardPreferance.dart';
import 'package:demo/Json_model/company_logain_details_model.dart';
import 'package:demo/Json_model/user_logain_details_model.dart';
// import 'package:bype_techno_projects1/Globale_class/shardPreferance.dart';
// import 'package:bype_techno_projects1/Json_model/company_logain_details_model.dart';
// import 'package:bype_techno_projects1/Json_model/user_logain_details_model.dart';

class Global {
  Future<LoginData?> getCustomerData() async {
    String? stringValue = await SharedPreferenceUtils.getValue('LogainData');
    if (stringValue != null) {
      // Decode the JSON string and create a LoginData object
      Map<String, dynamic> jsonMap = jsonDecode(stringValue);
      LoginData user = LoginData.fromJson(jsonMap);
      return user;
    }
    return null;
  }

  Future<CompanyData?> getCompanyData() async {
    String? stringValue = await SharedPreferenceUtils.getValue('GetCompanyDetails');
    if (stringValue != null) {
      // Decode the JSON string and create a CompanyData object
      Map<String, dynamic> jsonMap = jsonDecode(stringValue);
      CompanyData company = CompanyData.fromJson(jsonMap);
      return company;
    }
    return null;
  }
}
