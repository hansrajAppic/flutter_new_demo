// ignore_for_file: prefer_final_fields, non_constant_identifier_names, unused_field, prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'dart:developer';
import 'dart:io';


import 'package:demo/Globale_class/colors.dart';
import 'package:demo/serach_bankName.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CashWithdraw extends StatefulWidget {
  const CashWithdraw({Key? key}) : super(key: key);

  @override
  State<CashWithdraw> createState() => _CashWithdrawState();
}

class _CashWithdrawState extends State<CashWithdraw> {
  TextEditingController _controller = TextEditingController();
  TextEditingController Adharcontroller = TextEditingController();
  TextEditingController mobcontroller = TextEditingController();
  List<String> arrayValues = ["10000", "5000", "1000", "500"];
  List<Map<String, dynamic>> Listicon = [
    {"icon": "assets/images/hfdc.png"},
    {"icon": "assets/images/icic.png"},
    {"icon": "assets/images/pungab.png"},
    {"icon": "assets/images/icic.png"},
    {"icon": "assets/images/icic.png"},
    {"icon": "assets/images/bank.png"},
  ];

  double _imageHeight = 100.0;
  int selectedIndex =
      -1; // Initialize selectedIndex to -1 to indicate no selection

  final List<String> banks = ['Bank 1', 'Bank 2', 'Bank 3', 'Bank 4'];

  final List<String> SlectvalueArray = [
    'Pending',
    'Pending',
    'Pending',
    'Pending'
  ];

  @override
  void initState() {
    super.initState();
    _controller.text = '10,000';
  }

  int _selectedBankIndex = -1; // Initially no bank selected

  List<String> bankss = ['Bank 1', 'Bank 2', 'Bank 3'];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Cash Withdraw",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your AEPS balance is ",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
              ),
              SizedBox(height: h * 0.001),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "₹",
                    style: TextStyle(
                      fontSize: 39,
                      fontWeight: FontWeight.w400,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "0.0",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.fact_check,
                    color: Colors.pinkAccent,
                    size: 40,
                  ),
                ],
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w * 0.15,
                      child: Divider(
                        thickness: 4,
                      ),
                    ),
                    SizedBox(height: h * 0.033),
                    Image.asset(
                      "assets/images/rsz_1sonitecno.png",
                      height: 50,
                    ),
                    SizedBox(height: h * 0.033),
                    Container(
                      width: w * 0.52, // Set desired width here
                      child: TextFormField(
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: Colors.black54,
                        ),
                        controller: _controller,
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          prefix: SizedBox(
                            width: w * 0.1200,
                            child: Text(
                              '₹',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.pinkAccent,
                              ),
                            ),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.03),
                    SizedBox(
                      height: h * 0.05,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: arrayValues.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.text = arrayValues[index];
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(4),
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54),
                              ),
                              child: Text(
                                arrayValues[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: w * 0.57, // Set desired width here
                      child: TextFormField(
                        controller: Adharcontroller,

                        //  initialValue: "Aadhar Number",

                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        // controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Aadhar Number",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                // Navigate to QR code scanner screen
                                final result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => QrcodScreen(),
                                ));

                                // Handle the result returned from QR code scanner screen
                                if (result != null) {
                                  setState(() {
                                    Adharcontroller.text = result.code
                                        .toString()
                                        .replaceAll("upi://pay?pa=", "")
                                        .split("&")[0]
                                        .toString();
                                    ''; // Update UPI ID field with scanned result
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.qr_code_scanner,
                                size: 30,
                              )),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: w * 0.57, // Set desired width here
                      child: TextFormField(
                        // initialValue: "Mobile Number",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                        // controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Mobile Number",
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          // prefixIcon: CountryFlag.fromCountryCode(
                          //   'IN',
                          //   height: 0.1,
                          //   width: 0.1,
                          //   borderRadius: 8,
                          // ),
                          prefixIcon: Icon(
                            Icons.phone_iphone_outlined,
                            size: 26,
                            color: Colors.blue,
                          ),
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: h * 0.05),
                    Text(
                      "Select Your Bank",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: Listicon.length,
                        itemBuilder: (context, index) {
                          // Calculate maxRadius based on available space
                          double maxRadius =
                              MediaQuery.of(context).size.shortestSide / 2;

                          return GestureDetector(
                            onTap: () {
                              if (index == 5) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SerchBankName()));
                              }
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: w * 0.03),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black12,
                                  maxRadius: 16,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        maxRadius), // Clip with circular border radius
                                    child: Image.asset(
                                      Listicon[index]["icon"],
                                      height: maxRadius * 0.14,

                                      width: maxRadius * 0.14,

                                      fit: BoxFit
                                          .cover, // Use BoxFit.cover to fill the CircleAvatar
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Text(
                      "Active Bank",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    SizedBox(
                      height: h * 0.08,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bankss.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedBankIndex =
                                      index; // Update selectedIndex when a ListTile is tapped
                                });
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            ?  AppColors.whiteColor
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
                                  ]));
                        },
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        
                        style: TextButton.styleFrom(
                          minimumSize: Size(w * 0.5, 50),
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                       

                        child: Text(
                          "Authenticte",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:  AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.03,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CashWithdraw(),
  ));
}

class QrcodScreen extends StatefulWidget {
  const QrcodScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QrcodScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

        ///MyGlobalFunctions.showAlertDialog(context, result as String);
        // Navigator.of(context)
        //     .pop(result);
        Navigator.of(context)
            .maybePop(result); // Pass scanned data back to previous screen
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
