import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFild extends StatefulWidget {
  CustomTextFormFild({
    Key? key,
    required this.myController,
    this.myIcon = Icons.verified_user_outlined,
    this.prefixIcon = Icons.person, // Default prefix icon
    this.prefixIconColor = Colors.blueAccent,
    this.borderColor = Colors.deepPurple,
    this.labelText,
    this.hintText,
    this.labelTextColor = Colors.deepPurple,
    this.borderRadius = 10.0,
    this.isPassword = false,
    this.inputFormatters,
    this.focusNode,
    this.validator,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 10.0,
    ),
    this.keyboardType,
    this.onChanged,
    this.maxLines,
  }) : super(key: key);

  final TextEditingController myController;
  final IconData myIcon;
  final IconData prefixIcon;
  final Color prefixIconColor;
  final Color borderColor;
  final String? labelText;
  final String? hintText;
  final Color labelTextColor;
  final EdgeInsets contentPadding;
  final double borderRadius;
  final bool isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final int? maxLines;

  @override
  _CustomTextFormFildState createState() => _CustomTextFormFildState();
}

class _CustomTextFormFildState extends State<CustomTextFormFild> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.myController,
      obscureText: widget.isPassword ? _obscureText : false,
      inputFormatters: widget.inputFormatters,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      maxLines: widget.maxLines,
      validator: widget.validator, // Integrate the validator here
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        labelStyle: TextStyle(color: widget.labelTextColor),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.prefixIconColor,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: widget.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(color: Colors.deepPurple.shade300),
        ),
      ),
    );
  }
}
