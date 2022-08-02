import 'package:flutter/material.dart';
import 'package:flutter_examples/widgets/name_form_field.dart';
import '../constants.dart';

class CommonFormScreen extends StatelessWidget {
  const CommonFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Common Form Screen'),),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          child: const CommonForm(),
        ),
      ),
    );
  }
}

class CommonForm extends StatefulWidget {
  const CommonForm({Key? key}) : super(key: key);

  @override
  State<CommonForm> createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// First Name
            NameFormField(
              controller: controllerFirstName,
              label: 'First Name',
              errorMessage: 'Please enter your first name.',
            ),

            const SizedBox(height: kDefaultPadding,),

            /// Last Name
            NameFormField(
              controller: controllerLastName,
              label: 'Last Name',
              errorMessage: 'Please enter your last name.',
            ),

            const SizedBox(height: 15,),

            ElevatedButton(onPressed: onConfirmButtonPressed, child: const Text('CONFIRM')),
          ],
        ),
      ),
    );
  }

  onConfirmButtonPressed() {
    bool isFormValid = _formKey.currentState!.validate();
    if(isFormValid) {
      final message = 'Thank you ${controllerFirstName.text} ${controllerLastName.text}.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message), duration: const Duration(seconds: 5),));
    }
  }
}

