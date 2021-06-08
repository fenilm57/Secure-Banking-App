import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final textEditingController;
  final String hintText;
  final keyType;
  final bool secure;

  TextFieldWidget(this.textEditingController, this.hintText, this.keyType,
      {this.secure});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 20, left: 20),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(20),
        child: TextFormField(
          cursorHeight: 20,
          keyboardType: keyType,
          obscureText: secure,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Amount';
            }
            return null;
          },
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}
