import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../constants.dart';
import '../../../widgets/animated_eye_icon.dart';
import '../form_builder_dynamic_model.dart';

class AccountsSection extends StatelessWidget {
  const AccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
    return ListenableBuilder(
        listenable: formBuilderDynamicModel,
        builder: (context, __) {
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: Text('Accounts', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...formBuilderDynamicModel.accountsList.map(
                          (e) => Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.account_box),
                              const SizedBox(width: 5),
                              Text(e.email, style: const TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (formBuilderDynamicModel.credentialsItemIds.isNotEmpty) const SizedBox(height: 12),
                  ...formBuilderDynamicModel.credentialsItemIds.asMap().entries.map((entry) {
                    final index = entry.key;
                    final id = entry.value;
                    return Padding(
                      key: ValueKey('credentialsItem$id'),
                      padding: const EdgeInsets.only(bottom: kFieldsPadding),
                      child: CredentialsFormField(index: index, id: id),
                    );
                  }),
                  Center(
                    child: TextButton.icon(
                      onPressed: () => formBuilderDynamicModel.addPasswordController(),
                      label: const Text('Add Account'),
                      icon: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CredentialsFormField extends StatefulWidget {
  const CredentialsFormField({super.key, required this.index, required this.id});

  final int index;
  final int id;

  @override
  State<CredentialsFormField> createState() => _CredentialsFormFieldState();
}

class _CredentialsFormFieldState extends State<CredentialsFormField> {
  bool obscurePasswordText = false;
  bool enableFields = true;
  bool isExpanded = true;
  String headerText = '';
  String? currentEmail;

  @override
  void initState() {
    super.initState();
    headerText = 'Account ${widget.index + 1}';
  }

  @override
  void didUpdateWidget(covariant CredentialsFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      setState(() => headerText = 'Account ${widget.index + 1}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
    return FormBuilderField(
      name: 'credentials-field${widget.id}',
      initialValue: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        if (v == false) return 'You have unsaved changes';
        return null;
      },
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            errorText: field.errorText,
            border: InputBorder.none,
            fillColor: Colors.transparent,
          ),
          child: Row(
            children: [
              Expanded(
                child: ExpansionPanelList(
                  elevation: 3,
                  // expandedHeaderPadding: const EdgeInsets.all(8),
                  expansionCallback: (i, isOpen) {
                    setState(() => isExpanded = isOpen);
                  },
                  children: [
                    ExpansionPanel(
                      isExpanded: isExpanded,
                      canTapOnHeader: true,
                      headerBuilder: (context, isOpen) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              Text(headerText, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            /// Email
                            FormBuilderTextField(
                              name: 'login-email${widget.id}',
                              enabled: enableFields,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text('Email*'),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(errorText: 'Login email is required.'),
                                  FormBuilderValidators.email(errorText: 'Valid email is required.'),
                                  (v) {
                                    if (formBuilderDynamicModel.emailsList.contains(v) && currentEmail != v) {
                                      return 'This email was already added to the list.';
                                    }
                                    return null;
                                  }
                                ],
                              ),
                            ),
                            const SizedBox(height: kFieldsPadding),

                            /// Password
                            FormBuilderTextField(
                              name: 'password${widget.id}',
                              enabled: enableFields,
                              obscureText: obscurePasswordText,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text('Password*'),
                                errorMaxLines: 3,
                                suffixIcon: AnimatedEyeIcon(
                                  obscureText: obscurePasswordText,
                                  onPressed: () {
                                    setState(() {
                                      obscurePasswordText = !obscurePasswordText;
                                    });
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (s) {
                                if (s == null || s.trim().isEmpty || s.length < 8 || s.length > 36 || !RegExp(r"^(?=\D*\d)(?=.*?[a-zA-Z]).*[\W_]").hasMatch(s)) {
                                  return 'Your password must be 8-36 characters and contain at least one letter, one number, and one special character.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: kFieldsPadding),

                            /// Retype Password
                            FormBuilderTextField(
                              name: 'retype-password${widget.id}',
                              enabled: enableFields,
                              obscureText: obscurePasswordText,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text('Retype Password*'),
                                errorMaxLines: 3,
                                suffixIcon: AnimatedEyeIcon(
                                  obscureText: obscurePasswordText,
                                  onPressed: () {
                                    setState(() {
                                      obscurePasswordText = !obscurePasswordText;
                                    });
                                  },
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              validator: (s) {
                                final passwordField = formBuilderDynamicModel.formKey.currentState?.fields['password${widget.id}'];
                                if (s == null || (passwordField?.value != s) || s.trim().isEmpty || s.length < 8 || s.length > 36 || !RegExp(r"^(?=\D*\d)(?=.*?[a-zA-Z]).*[\W_]").hasMatch(s)) {
                                  return 'Passwords do not match.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
                                final fields = formBuilderDynamicModel.formKey.currentState?.fields;
                                final emailField = fields?['login-email${widget.id}'];
                                final isEmailValid = emailField?.validate(autoScrollWhenFocusOnInvalid: true, focusOnInvalid: false) ?? false;
                                final isPasswordValid = fields?['password${widget.id}']?.validate(autoScrollWhenFocusOnInvalid: true, focusOnInvalid: false) ?? false;
                                final isRetypePasswordValid = fields?['retype-password${widget.id}']?.validate(autoScrollWhenFocusOnInvalid: true, focusOnInvalid: false) ?? false;
                                if (isEmailValid && isPasswordValid && isRetypePasswordValid) {
                                  setState(() {
                                    obscurePasswordText = true;
                                    if (enableFields) {
                                      isExpanded = false;
                                    }
                                    enableFields = !enableFields;
                                    field.didChange(!enableFields);
                                    final email = emailField!.value as String;
                                    headerText = email;
                                    if (!formBuilderDynamicModel.emailsList.contains(email)) {
                                      currentEmail = email;
                                      formBuilderDynamicModel.emailsList.add(email);
                                    }
                                  });
                                }
                              },
                              child: Text(enableFields ? 'DONE' : 'EDIT'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Remove',
                onPressed: () {
                  final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
                  final fields = formBuilderDynamicModel.formKey.currentState?.fields;
                  final emailField = fields?['login-email${widget.id}'];
                  final email = emailField?.value as String?;
                  if (formBuilderDynamicModel.emailsList.contains(email)) {
                    formBuilderDynamicModel.emailsList.remove(email);
                  }
                  emailField?.reset();
                  fields?['password${widget.id}']?.reset();
                  fields?['retype-password${widget.id}']?.reset();
                  formBuilderDynamicModel.removePasswordController(index: widget.index);
                },
                icon: const Icon(Icons.remove_circle),
              ),
            ],
          ),
        );
      },
    );
  }
}
