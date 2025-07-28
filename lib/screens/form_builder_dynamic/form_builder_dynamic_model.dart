import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/account.dart';

class FormBuilderDynamicModel extends ChangeNotifier {
  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode? autovalidateMode;
  bool _canPop = true;
  List<Account> accountsList = [];
  List credentialsItemIds = [];
  int credentialsCounter = 0;
  List<String> emailsList = []; // To avoid repeated credentials

  FormBuilderDynamicModel() {
    accountsList = [Account(email: 'test@test.com')];
  }

  bool get canPop => _canPop;
  set canPop(bool v) {
    _canPop = v;
    notifyListeners();
  }

  void addPasswordController() {
    credentialsItemIds.add(credentialsCounter);
    credentialsCounter++;
    notifyListeners();
  }

  void removePasswordController({required int index}) {
    credentialsItemIds.removeAt(index);
    notifyListeners();
  }

  List<Account> getAllEmails() {
    Map<String, dynamic> formValues = formKey.currentState!.value;
    final allEmails = [...accountsList];
    for(final id in credentialsItemIds) {
      allEmails.add(Account(email: formValues['login-email$id']));
    }
    return allEmails;
  }
}

class FormBuilderDynamicInheritedNotifier extends InheritedNotifier<FormBuilderDynamicModel> {
  const FormBuilderDynamicInheritedNotifier({
    required super.notifier,
    required super.child,
    super.key,
  });

  static FormBuilderDynamicModel of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<FormBuilderDynamicInheritedNotifier>();
    assert(inherited != null, 'FormBuilderDynamicModel not found in the tree');
    return inherited!.notifier!;
  }
}
