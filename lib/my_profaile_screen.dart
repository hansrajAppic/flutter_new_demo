// ignore_for_file: unused_local_variable, camel_case_types, avoid_print, prefer_const_constructors, non_constant_identifier_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:convert';

// import 'package:bype_techno_projects1/Globale_class/companyinformationdata.dart';
// import 'package:bype_techno_projects1/Globale_class/colors.dart';
// import 'package:bype_techno_projects1/Globale_class/shardPreferance.dart';
// import 'package:bype_techno_projects1/Json_model/company_logain_details_model.dart';
// import 'package:bype_techno_projects1/homnave_scree.dart';
// import 'package:bype_techno_projects1/splesh_screen.dart';
import 'package:demo/Globale_class/colors.dart';

import 'package:demo/Globale_class/shardPreferance.dart';
import 'package:demo/Json_model/company_logain_details_model.dart';

import 'package:demo/homnave_scree.dart';
import 'package:demo/splesh_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Globale_class/companyinformationdata.dart';
import 'Json_model/user_logain_details_model.dart';

class MyProfile_Screen extends StatefulWidget {
  const MyProfile_Screen({super.key});

  @override
  State<MyProfile_Screen> createState() => _MyProfile_ScreenState();
}

class _MyProfile_ScreenState extends State<MyProfile_Screen> {
  List<userData> logainArray = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    performApiCall();
    _assignCustomerData();
    setState(() {});
    super.initState();
    // Call the API when the widget is created
  }

  Global globalInstance = Global();
  CompanyData? companyData;

  void _assignCustomerData() async {
    companyData = await globalInstance.getCompanyData();
    setState(() {
      companyData = companyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.help_outline_outlined,
            color: AppColors.whiteColor,
            size: 22,
          ),
          SizedBox(
            width: w * 0.02,
          )
        ],
        backgroundColor: AppColors.PinkColors,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          // onPressed: () => Navigator.of(context).pop(),o
          onPressed: (){
              Navigator.push(context,
                MaterialPageRoute(builder: (context) =>  HomeNaveScreens(index: 0,)));
          },
        ),
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Image.network(
            "https://sonitechno.info/images/Company/${(companyData != null ? companyData!.data![0].logo : "")}",
            height: 200,
            width: 170,
          ),
        ),
        centerTitle: true,
      ),
      
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h * 0.05),
            Center(
              child: Image.asset(
                "assets/images/rsz_1sonitecno.png",
                height: 40,
              ),
            ),
            const SizedBox(height: 50),
            const Center(
              child: Text(
                "RETAILER",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            buildInfoItem("Mobaile No",
                logainArray.isNotEmpty ? logainArray[0].userid ?? "" : ""),
            buildInfoItem("Email id",
                logainArray.isNotEmpty ? logainArray[0].email ?? "" : ""),
            buildInfoItem("User Name",
                logainArray.isNotEmpty ? logainArray[0].username ?? "" : ""),
            buildInfoItem("User id",
                logainArray.isNotEmpty ? logainArray[0].userid ?? "" : ""),
            buildInfoItem("Pan No",
                logainArray.isNotEmpty ? logainArray[0].pan ?? "" : ""),
            buildInfoItem("Aadhar no",
                logainArray.isNotEmpty ? logainArray[0].aadhar ?? "" : ""),
            buildInfoItem("Joining Date ",
                logainArray.isNotEmpty ? logainArray[0].adddate ?? "" : ""),
            SizedBox(height: h * 0.2),
          ],
        ),
      ),
    );
  }

  Widget buildInfoItem(String label, String value) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.044),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: h * 0.01),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: h * 0.01),
          Container(
            height: h * 0.070,
            width: double.infinity,
            decoration: BoxDecoration(
              border:
                  Border.all(color: const Color.fromARGB(255, 137, 126, 126)),
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performApiCall() async {

    {
     
        String? datf  =
          await SharedPreferenceUtils.getValue(SpleshScrrenState.KEYLOGIN);
      final data = json.decode(datf!);

      if (data["statuscode"] == "TXN") {
        List<dynamic> jsonList = json.decode(datf)['data'];
        List<userData> getlogindetails =
            jsonList.map((json) => userData.fromJson(json)).toList();

        setState(() {
          logainArray = getlogindetails;
          isLoading = false;
        });
      } else {
        if (data["status"].toString() == "UnAuthorized Person") {
          Fluttertoast.showToast(
            msg: "UnAuthorized Person!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor:AppColors.whiteColor,
            fontSize: 16.0,
          );
          // ignore: use_build_context_synchronously
        }
      }
    }
  }
}


