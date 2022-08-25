import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({Key? key, required this.controllerPassword}) : super(key: key);

  final TextEditingController controllerPassword;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        label: const Text('Password'),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[500]),
        hintText: 'Type in a password',
        fillColor: Colors.white70,
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          onPressed: () => setState(() => obscureText = !obscureText),
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: obscureText
                ? Icon(Icons.remove_red_eye_outlined, key: UniqueKey(),)
                : Icon(Icons.remove_red_eye, key: UniqueKey(),),
          ),
        ),
      ),
      controller: widget.controllerPassword,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.disabled,
      autofillHints: const [AutofillHints.password],
      validator: (s) {
        if(s == null || s.isEmpty) {
          return 'Please type a password.';
        } else if(s.length < 6) {
          return 'Password must be at least 6 characters.';
        }
        return null;
      },
    );
  }
}
