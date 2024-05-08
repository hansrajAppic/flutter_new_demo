import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Statelist {
  String? statename;
  int? stateId;

  Statelist({this.statename, this.stateId});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AutoCompleteDemo(),
      ),
    );
  }
}

class AutoCompleteDemo extends StatefulWidget {
  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoCompleteDemo> {
  final GlobalKey<AutoCompleteTextFieldState<Statelist>> _autoCompleteKey =
      GlobalKey();
  final TextEditingController _stateController = TextEditingController();
  List<Statelist> slectbankoptions = [
    Statelist(statename: 'State 1', stateId: 1),
    Statelist(statename: 'State 2', stateId: 2),
    Statelist(statename: 'State 3', stateId: 3),
  ];
  Statelist? _selectedOption;
  double _iconSize = 24.0;
  int? selectedStateId;
  FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          AutoCompleteTextField<Statelist>(
            key: _autoCompleteKey,
            clearOnSubmit: false,
            controller: _stateController,
            suggestions: slectbankoptions,
            decoration: InputDecoration(
              labelText: 'Search for a state',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              suffixIcon: PopupMenuButton<Statelist>(
                itemBuilder: (context) => slectbankoptions
                    .map((option) => PopupMenuItem<Statelist>(
                          value: option,
                          child: Text(option.statename!),
                        ))
                    .toList(),
                icon: Icon(Icons.arrow_drop_down,
                    size: _iconSize), // Add arrow icon here
                onSelected: (Statelist value) {
                  setState(() {
                    _selectedOption = value;
                    _stateController.text = value.statename!;
                    _iconSize =
                        24.0; // Reset icon size when an option is selected
                    selectedStateId = value.stateId; // Update selectedStateId
                    _focusNode.unfocus();
                  });
                },
                onCanceled: () {
                  setState(() {
                    _iconSize =
                        24.0; // Reset icon size when dropdown is canceled
                  });
                },
              ),
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
                _stateController.text = item.statename!;
                _selectedOption = item;
                selectedStateId = item.stateId; // Update selectedStateId
                _focusNode.unfocus();
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
              "Selected State: ${_selectedOption != null ? _selectedOption!.statename! : 'None'}"),
        ],
      ),
    );
  }
}
