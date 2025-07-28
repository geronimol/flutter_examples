import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../dialogs/unsaved_changes_dialog.dart';
import 'dialogs/confirmation_dialog.dart';
import 'form_builder_dynamic_model.dart';
import 'sections/accounts_section.dart';

class FormBuilderDynamicScreen extends StatefulWidget {
  const FormBuilderDynamicScreen({super.key});

  @override
  State<FormBuilderDynamicScreen> createState() => _FormBuilderDynamicScreenState();
}

class _FormBuilderDynamicScreenState extends State<FormBuilderDynamicScreen> {
  final formBuilderDynamicModel = FormBuilderDynamicModel(); // will handle the state

  @override
  Widget build(BuildContext context) {
    return FormBuilderDynamicInheritedNotifier(
      notifier: formBuilderDynamicModel,
      child: Builder(builder: (context) {
        final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
        return PopScope(
          canPop: formBuilderDynamicModel.canPop,
          onPopInvokedWithResult: (v, result) async {
            final navigator = Navigator.of(context);
            if (v == false) {
              /// Show Unsaved Changes Dialog
              final result = await UnsavedChangesDialog.show();
              if (result == true) {
                navigator.pop();
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Form Builder Dynamic')),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: FormBuilderDynamicExample(),
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(onPressed: () => _onSubmitButtonPressed(context), child: const Text('Done')),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _onSubmitButtonPressed(BuildContext context) {
    final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
    formBuilderDynamicModel.autovalidateMode = AutovalidateMode.onUserInteraction;
    final formKey = formBuilderDynamicModel.formKey;
    bool isFormValid = formKey.currentState?.validate() ?? false;
    if (isFormValid) {
      formKey.currentState!.save();
      ConfirmationDialog.show(context, accountsList: formBuilderDynamicModel.getAllEmails());
    }
  }
}

class FormBuilderDynamicExample extends StatelessWidget {
  const FormBuilderDynamicExample({super.key});

  @override
  Widget build(BuildContext context) {
    final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
    return FormBuilder(
      key: formBuilderDynamicModel.formKey,
      autovalidateMode: formBuilderDynamicModel.autovalidateMode,
      onChanged: () {
        if (formBuilderDynamicModel.canPop == true) {
          formBuilderDynamicModel.canPop = false;
        }
      },
      child: Column(
        children: [
          /// Accounts
          AccountsSection(),
        ],
      ),
    );
  }
}
