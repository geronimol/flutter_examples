import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameFormField extends StatelessWidget {
  const NameFormField({super.key, required this.controller, required this.label, required this.errorMessage, required this.autofillHints});

  final TextEditingController controller;
  final List<String> autofillHints;
  final String label, errorMessage;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:  const BorderSide(color: Colors.grey ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        hintText: 'Type in your text',
        fillColor: Colors.white70,
        prefixIcon: const Icon(Icons.account_circle),
      ),
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.disabled,
      autofillHints: autofillHints,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-ZñÑ\s]+$')),
      ],
      validator: (s) {
        final validCharacters = RegExp(r'^[a-zA-ZñÑ\s]+$');
        if(s == null || s.trim().isEmpty || !validCharacters.hasMatch(s) || s.trim().length < 2) {
          return errorMessage;
        }
        return null;
      },
    );
  }
}
