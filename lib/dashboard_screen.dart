// ignore_for_file: file_names, unused_field, avoid_print, unused_local_variable, use_build_context_synchronously, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, camel_case_types, non_constant_identifier_names, unnecessary_new, unused_element, prefer_const_constructors, use_key_in_widget_constructors, avoid_init_to_null

import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:demo/Globale_class/colors.dart';
import 'package:demo/Globale_class/drawer.dart';
import 'package:demo/Globale_class/shardPreferance.dart';
import 'package:demo/Json_model/baner_model.dart';
import 'package:demo/Json_model/company_logain_details_model.dart';
import 'package:demo/Json_model/paytm_home_model.dart';
import 'package:demo/Json_model/user_logain_details_model.dart';
import 'package:demo/aeps_service.dart';
import 'package:demo/bbps_screen.dart';
import 'package:demo/demt_confirempay.dart';
import 'package:demo/dth_screen.dart';
import 'package:demo/fund_trensfer_screen.dart';
import 'package:demo/globale_class.dart';
import 'package:demo/news_screen.dart';
import 'package:demo/search_contactslist_screen.dart';
import 'package:demo/search_paytm.dart';
import 'package:demo/upitransfer_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Globale_class/companyinformationdata.dart';

const double _kSize = 70.0;

class DashBord_Screen extends StatefulWidget {
  @override
  State<DashBord_Screen> createState() => _DashBord_ScreenState();
}

class _DashBord_ScreenState extends State<DashBord_Screen> {
  final List<String> SlectvalueArray = [
    'Pending',
    'Pending',
    'Pending',
    'Pending'
  ];

  int _selectedBankIndex = -1; // Initially no bank selected

  List<String> bankss = ['Bank 1', 'Bank 2', 'Bank 3'];
  bool isLoading = true;
  ScrollController ctrl1 = ScrollController();
  ScrollController ctrl2 = ScrollController();
  final ScrollController _scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  bool isCtrl1Scroll = true;

  // ignore: prefer_typing_uninitialized_variables
  var sp;

  Global globalInstance = Global();
  //  Future<String?> deviceIDs = MyGlobalFunctions.getId();
  List<BannerListData> banners = [];
  List<listData> bannersArray = [];
  // ignore: duplicate_ignore
  // ignore: avoid_init_to_null
  CompanyData? companyData = null;
  LoginData? getCustomerDat = null;

  @override
  void initState() {
    ctrl1.addListener(_ctrl1Listner);
    ctrl2.addListener(_ctrl2Listner);

    super.initState();

    fetchData();
    AssignCustonerData();
  }

  void AssignCustonerData() async {
    companyData = await globalInstance.getCompanyData();
    // LoginData = await globalInstance.getCompanyData();
  }

  void startAutoScroll() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_scrollController.hasClients) {
        final maxScrollExtent = _scrollController.position.maxScrollExtent;
        final currentScrollPosition = _scrollController.position.pixels;
        if (currentScrollPosition >= maxScrollExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.animateTo(
            currentScrollPosition + 100.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  double? _imageWidth;
  double? _imageHeight;
  @override
  void dispose() {
    ctrl1.removeListener(_ctrl1Listner);
    ctrl2.removeListener(_ctrl2Listner);
    ctrl1.dispose();
    ctrl2.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void _ctrl1Listner() {
    if (ctrl1.position.atEdge) {
      bool isTop = ctrl1.position.pixels == 0;
      if (isTop) {
        print('page_At the top');
      } else {
        setState(() {
          isCtrl1Scroll = false;
        });
        print('page_At the bottom');
      }
    }
  }

  void _ctrl2Listner() {
    if (ctrl2.position.atEdge) {
      bool isTop = ctrl2.position.pixels == 0;
      if (isTop) {
        setState(() {
          isCtrl1Scroll = true;
        });
        print('page_At the top::::::::::::ctrl2');
      } else {
        print('page_At the bottom:::::::::::ctrl2');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // Profile_succfuly items = widget.data;

    return Scaffold(
        backgroundColor: const Color(0xff022A72),
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xff022A72),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const CircleAvatar(
                  backgroundColor: AppColors.whiteColor,
                  child: Icon(
                    Icons.person_2,
                    color: Color.fromARGB(255, 158, 183, 204),
                  ),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Image.network(
            "https://sonitechno.info/images/Company/${companyData?.data?[0].logo}",
            height: MediaQuery.of(context).size.height *
                0.04, // 5% of screen height
            width:
                MediaQuery.of(context).size.width * 0.5, // 80% of screen width
          ),
          centerTitle: false,
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchScreen(),
                  ),
                );
              },
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsScreenss(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.messenger_outline,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                // Handle the onTap action for the messenger icon
              },
              child: const Icon(
                Icons.notification_add,
                color: AppColors.whiteColor,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                physics: isCtrl1Scroll
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                controller: ctrl1,
                child: Column(
                  children: [
                    const SizedBox(height: 180),
                    Container(
                      height: MediaQuery.of(context).size.longestSide - 100,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 242, 247, 251),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              height: 5,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: isCtrl1Scroll
                                ? const NeverScrollableScrollPhysics()
                                : const ClampingScrollPhysics(),
                            controller: ctrl2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 18),
                                FutureBuilder(
                                  future:
                                      GetBanner(), // Assuming you have a function named fetchBanners to fetch data
                                  builder: (context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (!snapshot.hasData) {
                                      return LoadingAnimationWidget.hexagonDots(
                                        color: Colors.blue,
                                        size: _kSize,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(child: Text("Loading..."));
                                    } else {
                                      return Column(
                                        children: [
                                          CarouselSlider.builder(
                                            options: CarouselOptions(
                                              enlargeCenterPage: false,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  currentIndex = index;
                                                });
                                              },
                                              viewportFraction: 1.0,
                                              autoPlayInterval:
                                                  const Duration(seconds: 3),
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 800),
                                              autoPlay: true,
                                              autoPlayCurve:
                                                  Curves.fastOutSlowIn,
                                            ),
                                            itemCount:
                                                snapshot.data?.data!.length,
                                            itemBuilder:
                                                (context, index, realIndex) {
                                              var makeFullUrl =
                                                  "https://sonitechno.info/images/Banner/${snapshot.data?.data![index].imagePath}";

                                              return SizedBox(
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: w * 0.01),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6),
                                                    color:
                                                        const Color(0xffFFFFFF),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              137,
                                                              134,
                                                              128,
                                                              128),
                                                    ),
                                                    boxShadow: [
                                                      const BoxShadow(
                                                        color: Color.fromARGB(
                                                            69, 143, 145, 135),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    child: Image.network(
                                                      makeFullUrl,
                                                      width: double.infinity,
                                                      height: 180,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          DotsIndicator(
                                            dotsCount:
                                                snapshot.data?.data!.length,
                                            position: currentIndex,
                                            decorator: DotsDecorator(
                                              color: Color.fromARGB(255, 234,
                                                  72, 72), // Inactive dot color
                                              activeColor: Colors
                                                  .blue, // Active dot color
                                              size: const Size.square(
                                                  8.0), // Dot size
                                              activeSize: const Size(
                                                  20.0, 8.0), // Active dot size
                                              spacing: const EdgeInsets.all(
                                                  4.0), // Spacing between dots
                                              activeShape:
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    10.0), // Change the active dot shape
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                ),
                                buildListView(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void showCustomDialog(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Set border radius here
          ),
          insetPadding: EdgeInsets.all(10),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: h * 0.21,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * 0.03, vertical: h * 0.012),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              ),
                              minimumSize: Size(w * double.infinity, 20),
                              backgroundColor: Colors.redAccent,
                            ),
                            child: Text(
                              "Select Bank",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.002,
                          ),
                          SizedBox(
                            height: h * 0.08,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: bankss.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if (index == 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ApesService_Screen()));
                                    }
                                    setState(() {
                                      _selectedBankIndex =
                                          index; // Update selectedIndex when a ListTile is tapped
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(9),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          color: _selectedBankIndex == index
                                              ? Colors.green
                                              : null,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: 18,
                                          color: _selectedBankIndex == index
                                              ? AppColors.whiteColor
                                              : Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            bankss[index],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            SlectvalueArray[index],
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<BannerHome?> GetBanner() async {
    String? Mobile = await SharedPreferenceUtils.getValue("mob");
    String? Password = await SharedPreferenceUtils.getValue("pass");
    if (Mobile != null) {
      String? deviceID = "";

      try {
        String? result = await MyGlobalFunctions.getId();
        deviceID = result;
      } catch (error) {
        print('Error: $error');
      }

      String? getbanner = await MyGlobalFunctions.PostCall(
        '{"MethodName":"getbanner","UserID":"$Mobile ","Password":"$Password", "AppType": " Apps"  }',
        "$deviceID",
      );

      final data = json.decode(getbanner!);
      if (data["statuscode"] == "TXN") {
        return BannerHome.fromJson(data);
      } else {
        if (data["status"].toString() == "UnAuthorized Person") {
          MyGlobalFunctions.showAlertDialog(context, "UnAuthorized Person!");
        }
      }
    }
  }

  Widget buildListView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildContainer(),
        ],
      ),
    );
  }

  Widget buildContainer() {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildListViewBuilder(),
      ],
    );
  }

  Widget buildListViewBuilder() {
    double h = MediaQuery.of(context).size.height;
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      controller: ScrollController(),
      itemCount: bannersArray.length,
      itemBuilder: (context, index) {
        return buildContainerItem(index, h);
      },
    );
  }

  Widget buildContainerItem(int index, double h) {
    double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.whiteColor,
          boxShadow: [
            const BoxShadow(
              color: Color.fromARGB(69, 143, 145, 135),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                bannersArray[index].name ?? "",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: h * 0.001),
            buildGridView(index),
          ],
        ),
      ),
    );
  }

  Widget buildGridView(int index) {
    return GridView.builder(
      itemCount: jsonDecode(bannersArray[index].serviceData!).length,
      controller: ScrollController(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 14 / 13,
        crossAxisCount: 4,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, gridIndex) {
        return InkWell(
          onTap: () {
            callsingle(context,
                jsonDecode(bannersArray[index].serviceData!)[gridIndex]);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildCircleAvatar(
                index,
                jsonDecode(bannersArray[index].serviceData!)[gridIndex]
                    ["Image"],
              ),
              Text(
                jsonDecode(bannersArray[index].serviceData!)[gridIndex]["Name"],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor),
                textAlign: TextAlign.center,
              )

              // Center text horizontally
            ],
          ),
        );
      },
    );
  }

  Widget buildCircleAvatar(int index, String gridIndex) {
    return CircleAvatar(
      backgroundColor: AppColors.SalmonColorColor.withOpacity(0.5),
      radius: 21,
      child: Image.network(
        "https://sonitechno.info/images/icon/$gridIndex",
        height: 25,
      ),
    );
  }

  void callsingle(BuildContext context, dynamic data) {
    if (data["Onoff"] == true) {
      if (data["ID"].toString() == "1") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Serch_contacts_Screen()),
        );
      } else if (data["ID"].toString() == "3") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dth_Screen()),
        );
      } else if (data["ID"].toString() == "28") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FundTransferScreen()),
        );
      } else if (data["ID"].toString() == "28") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DemtConfrmPay()),
        );
      } else if (data["ID"].toString() == "16") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpiTransferScreen()),
        );
      } else if (data["ID"].toString() == "17") {
        showCustomDialog(context);
      } else if (data["ID"].toString() == "20") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpiTransferScreen()),
        );
      } else if (data["SectionType"].toString() == "2") {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Bbps_screen(ServiceName: data["Name"].toString())),
        );
      }
    } else {
      MyGlobalFunctions.showAlert(context, data["Reason"].toString());
    }
  }

  Future<void> fetchData() async {
    try {
      String? Mobile = await SharedPreferenceUtils.getValue("mob");
      String? Password = await SharedPreferenceUtils.getValue("pass");
      if (Mobile != null) {
        final deviceID = await MyGlobalFunctions.getId();

        final getServiceList = await MyGlobalFunctions.PostCall(
          '{"MethodName":"getservicelist","UserID":"$Mobile ","Password":"$Password", "AppType": " Apps"  }',
          "$deviceID",
        );

        final Map<String, dynamic> data = json.decode(getServiceList!);
        if (data["statuscode"] == "TXN") {
          final List<dynamic> jsonList = data['data'];
          final List<listData> serviceList =
              jsonList.map((json) => listData.fromJson(json)).toList();
          setState(() {
            bannersArray = serviceList;
          });
        } else if (data["status"].toString() == "UnAuthorized Person") {
          MyGlobalFunctions.showAlertDialog(context, "UnAuthorized Person!");
        }
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  void _BbpsItemClickon(BuildContext context, String selectedItem) {
    late String ServiceName = selectedItem;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Bbps_screen(ServiceName: selectedItem),
      ),
    );
  }
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
