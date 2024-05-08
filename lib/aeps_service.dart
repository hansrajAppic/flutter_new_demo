// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors


import 'package:demo/Globale_class/colors.dart';
import 'package:demo/cash_withdraw.dart';
import 'package:demo/change_device.dart';
import 'package:flutter/material.dart';

class ApesService_Screen extends StatefulWidget {
  const ApesService_Screen({super.key});

  @override
  State<ApesService_Screen> createState() => _ApesService_ScreenState();
}

class _ApesService_ScreenState extends State<ApesService_Screen> {
  List<Map<String, dynamic>> Arraitam = [
    {
      "title": "Cash Withdraw",
      "icon": Icons.account_balance,
      "color": Colors.red
    },
    {
      "title": " Mini Statement",
      "icon": Icons.book_online_outlined,
      "color": Colors.blue
    },
    {
      "title": "Balance enquiry",
      "icon": Icons.account_balance_wallet,
      "color": Colors.pinkAccent
    },
    {
      "title": "Aadhar Pay",
      "icon": Icons.request_quote,
      "color": Colors.orange
    },
    {
      "title": "Change Device",
      "icon": Icons.device_hub_outlined,
      "color": Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 244, 230, 230),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.blackColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image.asset(
          "assets/images/aps_logo_glyph.png",
          height: 25,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.02),
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset("assets/images/Apps.jpg")

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffFFFFFF),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(69, 143, 145, 135),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/bbps.png"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.0029),
                          child: Text(
                            "Transact with over ",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff0b5285)),
                          ),
                        ),
                        Text(
                          " 80+ banks",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff0b5285)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.0037,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(221, 247, 223, 223)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: w * 0.02, vertical: h * 0.005),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Branchless Banking ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Image.asset(
                                  "assets/images/aps_logo_glyph.png",
                                  height: 12,
                                ),
                                SizedBox(
                                  width: w * 0.02,
                                ),
                                Image.asset(
                                  "assets/images/Icics.png",
                                  height: 22,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Selected Device: null",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(69, 143, 145, 135),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: Arraitam.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                if (index == 0) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CashWithdraw()));
                                } else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CashWithdraw()));
                                } else if (index == 2) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CashWithdraw()));
                                } else if (index == 3) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CashWithdraw()));
                                } else if (index == 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangeDevice()));
                                }
                              },
                              child: GridTile(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      child: Icon(
                                        Arraitam[index]['icon'],
                                        size: 20,
                                        color: Arraitam[index]['color'],
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      Arraitam[index]['title'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ]),
            ),
            
          ],
        )),
      ),
    );
  }
}
