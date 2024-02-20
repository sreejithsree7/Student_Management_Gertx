import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.nameController,
      required this.text,
      required this.type,
      this.validator})
      : super(key: key);

  final TextEditingController nameController;
  final String text;
  final TextInputType type;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      keyboardType: type,
      decoration: InputDecoration(
        labelText: '$text',
        labelStyle: TextStyle(color: Colors.black), // Change the label color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 1),
        ),
      ),
      style: TextStyle(color: Colors.black), // Change the input text color
      validator: validator,
    );
  }
}
