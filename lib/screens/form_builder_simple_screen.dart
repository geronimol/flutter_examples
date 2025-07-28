import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../dialogs/unsaved_changes_dialog.dart';

class FormBuilderSimpleScreen extends StatelessWidget {
  const FormBuilderSimpleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder Simple')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: FormBuilderSimpleExample(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormBuilderSimpleExample extends StatefulWidget {
  const FormBuilderSimpleExample({super.key});

  @override
  State<FormBuilderSimpleExample> createState() => _FormBuilderSimpleExampleState();
}

class _FormBuilderSimpleExampleState extends State<FormBuilderSimpleExample> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool canPop = true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (v, result) async {
        final navigator = Navigator.of(context);
        if(v == false) {
          /// Show Unsaved Changes Dialog
          final result = await UnsavedChangesDialog.show();
          if(result == true) {
            navigator.pop();
          }
        }
      },
      child: FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () {
          if(canPop == true) {
            setState(() => canPop = false);
          }
        },
        child: Column(
          children: [
            /// Name
            FormBuilderTextField(
              name: 'name',
              keyboardType: TextInputType.name,
              // style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                label: const Text('Name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Please enter a name.'),
                FormBuilderValidators.match(RegExp(r'^[a-zA-ZñÑ\s]+$'), errorText: 'Only alphabetic characters are allowed.'),
              ]),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Surname
            FormBuilderTextField(
              name: 'surname',
              keyboardType: TextInputType.name,
              // style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                label: const Text('Surname'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Please enter a surname.'),
                FormBuilderValidators.match(RegExp(r'^[a-zA-ZñÑ\s]+$'), errorText: 'Only alphabetic characters are allowed.'),
              ]),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Email
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              // style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                label: const Text('Email'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Please enter an email.'),
                FormBuilderValidators.email(errorText: 'Please enter a valid email.'),
              ]),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Date
            FormBuilderDateTimePicker(
              name: 'date',
              // style: const TextStyle(fontSize: 18),
              initialEntryMode: DatePickerEntryMode.calendar,
              initialTime: const TimeOfDay(hour: 12, minute: 0),
              inputType: InputType.both,
              decoration: InputDecoration(
                labelText: 'Date & Time',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _formKey.currentState!.fields['date']?.didChange(null),
                ),
              ),
              textInputAction: TextInputAction.next,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: 'Please enter a date & time.'),
              ]),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Dropdown
            FormBuilderDropdown<String>(
              name: 'gender',
              decoration: InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                hintText: 'Select Gender',
              ),
              validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
              items: ['Male', 'Female']
                  .map((gender) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Checkbox
            FormBuilderCheckbox(
              name: 'checkbox',
              initialValue: false,
              title: const Text('My Checkbox'),
            ),

            const SizedBox(height: kDefaultPadding),

            /// Chips
            FormBuilderFilterChips(
              name: 'chip',
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              options: const [
                FormBuilderChipOption(value: 'Chip 1', avatar: CircleAvatar(child: Text('C'))),
                FormBuilderChipOption(value: 'Chip 2', avatar: CircleAvatar(child: Text('C'))),
                FormBuilderChipOption(value: 'Chip 3', avatar: CircleAvatar(child: Text('C'))),
              ],
            ),

            const SizedBox(
              height: 20,
            ),

            /// Submit Button
            ElevatedButton(onPressed: () => _onPressed(context), child: const Text('Done')),
          ],
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    bool isFormValid = _formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      _formKey.currentState!.save();
      Map<String, dynamic> formValues = _formKey.currentState!.value;
      _showDialog(context, formValues);
    }
  }

  dynamic _showDialog(BuildContext context, Map<String, dynamic> formValues) {
    return showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            width: 600,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                const Text('Thanks!', style: TextStyle(color: Colors.black87, fontSize: 25, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${formValues['name']}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
                    Text('Surname: ${formValues['surname']}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
                    Text('Email: ${formValues['email']}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
                    Text('Date & Time: ${DateFormat.yMd().add_jm().format(formValues['date'])}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
                    Text('Gender: ${formValues['gender']}', style: const TextStyle(color: Colors.black54, fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
