import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/widgets/name_form_field.dart';
import 'package:flutter_examples/widgets/password_form_field.dart';
import '../constants.dart';

class CommonFormScreen extends StatelessWidget {
  const CommonFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common Form Screen')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const CommonForm(),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonForm extends StatefulWidget {
  const CommonForm({super.key});

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        autovalidateMode: autovalidateMode,
        child: AutofillGroup(
          child: Column(
            children: [
              /// First Name
              NameFormField(
                controller: controllerFirstName,
                label: 'First Name',
                errorMessage: 'Please enter your first name.',
                autofillHints: const [AutofillHints.givenName],
              ),

              const SizedBox(height: kDefaultPadding),

              /// Last Name
              NameFormField(
                controller: controllerLastName,
                label: 'Last Name',
                errorMessage: 'Please enter your last name.',
                autofillHints: const [AutofillHints.familyName],
              ),

              const SizedBox(height: kDefaultPadding),

              /// Email
              TextFormField(
                decoration: InputDecoration(
                  label: const Text('Email'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  hintText: 'Type in an email',
                  fillColor: Colors.white70,
                  prefixIcon: const Icon(Icons.email),
                ),
                controller: controllerEmail,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.disabled,
                autofillHints: const [AutofillHints.email],
                validator: (s) {
                  if (s == null || s.trim().isEmpty || !EmailValidator.validate(s)) {
                    return 'Please enter a valid email.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: kDefaultPadding),

              /// Password
              PasswordFormField(controllerPassword: controllerPassword),

              const SizedBox(height: 15),

              ElevatedButton(onPressed: _onConfirmButtonPressed, child: const Text('CONFIRM')),
            ],
          ),
        ),
      ),
    );
  }

  _onConfirmButtonPressed() {
    bool isFormValid = _formKey.currentState!.validate();
    if (isFormValid) {
      final message = 'Thank you ${controllerFirstName.text} ${controllerLastName.text}.';
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 5)));
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
