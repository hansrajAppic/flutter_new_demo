// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:demo/globale_class.dart';
import 'package:flutter/material.dart';

class PasswordForm extends StatefulWidget {
  final String otp;
  final String mobile;

  PasswordForm({required this.otp, required this.mobile});
  @override
  _PasswordConfirmationScreenState createState() =>
      _PasswordConfirmationScreenState();
}

class _PasswordConfirmationScreenState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool isLoading = false;

  Future<void> changedpasswordnewApi(String otp, String Mobile) async {
    setState(() {
      isLoading = true;
    });

    try {
      if (Mobile != null) {
        String? deviceID = "";

        try {
          String? result = await MyGlobalFunctions.getId();
          deviceID = result;
        } catch (error) {
          print('Error: $error');
        }

        String? changedpasswordnew = await MyGlobalFunctions.PostCall(
          '{"MethodName": "changedpasswordnew","UserID":"$Mobile", "NewPassword": " ${_newPasswordController.text}" ,"OTP":" $otp" }',
          "$deviceID",
        );
        print('changedpasswordnew>>>>>>>>>>>>>>${changedpasswordnew}');

        final data = json.decode(changedpasswordnew!);
        if (data["statuscode"] == "TXN") {
          Navigator.of(context).pop();
          MyGlobalFunctions.errorMessage(context, data["status"].toString());
        } else {
          MyGlobalFunctions.errorMessage(context, data["status"].toString());
        }
      }
    } catch (e) {
      print('Error: $e');
      // Handle error
      MyGlobalFunctions.errorMessage(context, 'An error occurred');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Confirmation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // TextFormField(
              //   controller: _newPasswordController,
              //   decoration: InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Please enter your password';
              //     }
              //     return null;
              //   },
              // ),

              TextFormField(
                controller: _newPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 164, 146, 152)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 140, 124, 130)),
                    ),
                    labelText: 'New Password',
                    hintText: 'Enter New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    )),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                    // suffixIcon: const Icon(
                    //   Icons.phone_callback,
                    //   color: Colors.blue,
                    // ),

                    isCollapsed: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 164, 146, 152)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 140, 124, 130)),
                    ),
                    labelText: 'Confirm Password',
                    hintText: 'Enter Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    )),
              ),

              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String oldPassword = _confirmPasswordController.text;
                  String newPassword = _newPasswordController.text;

                  if (newPassword == oldPassword) {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      changedpasswordnewApi(
                        widget.otp,
                        widget.mobile,
                      ).then((_) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                  } else {
                    // Show an error message if passwords do not match
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')),
                    );
                  }
                },
                child: isLoading ? CircularProgressIndicator() : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
