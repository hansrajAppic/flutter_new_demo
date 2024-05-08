// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names, prefer_final_fields


import 'package:demo/Globale_class/colors.dart';
import 'package:flutter/material.dart';

class SerchBankName extends StatefulWidget {
  const SerchBankName({Key? key}) : super(key: key);

  @override
  State<SerchBankName> createState() => _SerchBankNameState();
}

class _SerchBankNameState extends State<SerchBankName> {
  List<String> _dataset = [
    'Airtel Payment Bank',
    'Allahabad Bank',
    'Allahabad UP Groamin Bank',
    'Andhra Bank',
    'Andhra Pradesh Grameena Vikash Bank',
    'Andhra Pragathi Grameena Bank',
    'Andhra Bank',
    'AP Mahesh Coop Urban Bank Ltd',
    'Andhra Pragathi Grameena Bank',
  ];
  List<String> _filteredDataset = [];

  @override
  void initState() {
    super.initState();
    // Initialize filtered dataset with the full dataset
    _filteredDataset.addAll(_dataset);
  }

  void _filterDataset(String query) {
    setState(() {
      _filteredDataset = _dataset
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color(0xff36355f),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(69, 143, 145, 135),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: h * 0.027), // Add top padding here
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.whiteColor,
                                      )),
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: AppColors.whiteColor,
                                  ),
                                ))),
                        Text(
                          "Select Your Bank",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Text(
                          "Make sure your Aadhaar is linked with the bank account",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 130, 116, 116),
                          ),
                        ),
                        SizedBox(height: h * 0.02),
                        TextFormField(
                          style: TextStyle(
                              color:
                                  AppColors.whiteColor,), // Change text input color here
                          onChanged: (value) {
                            _filterDataset(value);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.whiteColor,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.whiteColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.whiteColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            hintText: "Search bank name",
                            hintStyle: TextStyle(color: AppColors.whiteColor),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.044,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredDataset.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(31, 148, 119, 119))),
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      title: Text(_filteredDataset[index]),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
