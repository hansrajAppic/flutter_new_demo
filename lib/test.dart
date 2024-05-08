import 'dart:convert';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:demo/Json_model/getstate_model2.dart';
import 'package:demo/globale_class.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(kkkkkk());
}

class kkkkkk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dropdown with Search Example',
      home: DropdownWithSearchExample(),
    );
  }
}

class DropdownWithSearchExample extends StatefulWidget {
  @override
  _DropdownWithSearchExampleState createState() =>
      _DropdownWithSearchExampleState();
}

class _DropdownWithSearchExampleState extends State<DropdownWithSearchExample> {
  TextEditingController _searchController = TextEditingController();
  List<Statelist> slectbankoptions = [];
  Statelist? _selectedOption;
  double _iconSize = 24.0;

  @override
  void initState() {
    super.initState();
    getstateApi(); // Fetch state data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dropdown with Search Example'),
       
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AutoCompleteTextField<Statelist>(
              key: GlobalKey(),
              clearOnSubmit: false,
              controller: _searchController,
              suggestions: slectbankoptions,
              decoration: InputDecoration(
                labelText: 'Search for a state',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              itemFilter: (item, query) {
                return item.statename!
                    .toLowerCase()
                    .contains(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.statename!.compareTo(b.statename!);
              },
              itemSubmitted: (item) {
                setState(() {
                  _searchController.text = item.statename!;
                  _selectedOption = item;
                });
              },
              itemBuilder: (context, item) {
                return ListTile(
                  title: Text(item.statename!),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              _selectedOption == null
                  ? 'No state selected'
                  : 'Selected State: ${_selectedOption!.statename}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void showDropdownMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.builder(
            itemCount: slectbankoptions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(slectbankoptions[index].statename!),
                onTap: () {
                  setState(() {
                    _selectedOption = slectbankoptions[index];
                    _iconSize =
                        24.0; // Reset icon size when an option is selected
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> getstateApi() async {
    try {
      final deviceID = await MyGlobalFunctions.getId();
      final getServiceList = await MyGlobalFunctions.PostCall(
        '{"MethodName":"getstate"}',
        "$deviceID",
      );
      final Map<String, dynamic> data = json.decode(getServiceList!);
      if (data["status"] == true) {
        final List<dynamic> jsonList = data['banklist'];
        setState(() {
          slectbankoptions =
              jsonList.map((json) => Statelist.fromJson(json)).toList();
        });
      } else if (data["status"].toString() == "UnAuthorized Person") {
        MyGlobalFunctions.showAlertDialog(context, "UnAuthorized Person!");
      }
    } catch (error) {
      print('Error fetching data: $error');
      throw error;
    }
  }
}
