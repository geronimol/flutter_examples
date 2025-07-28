import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../models/account.dart';

class FormBuilderDynamicModel extends ChangeNotifier {
  bool _loading = false;
  final formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode? autovalidateMode;
  bool _canPop = true;
  List<Account> accountsList = [];
  List credentialsItemIds = [];
  int credentialsCounter = 0;
  List<String> emailsList = []; // To avoid repeated credentials
  int? selectedType;
  String? type2Data;
  bool isLoadingSavedData = false;

  FormBuilderDynamicModel() {
    accountsList = [Account(email: 'test@test.com')];
  }

  bool get canPop => _canPop;
  bool get loading => _loading;
  set canPop(bool v) {
    _canPop = v;
    notifyListeners();
  }
  set loading(bool v) {
    _loading = v;
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

  Future<void> onChangedSelectionType({ int? v}) async {
    log('[LOG] ON CHANGED SELECTION TYPE CALLED!');
    selectedType = v;
    if(selectedType == 2) {
      await loadType2Data();
      if(!isLoadingSavedData) {
        formKey.currentState?.fields['type2Data']?.didChange(type2Data);
      } else {
        isLoadingSavedData = false;
      }
    }
    notifyListeners();
  }

  Future<void> loadType2Data() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    type2Data = 'Option A';
    loading = false;
  }

  Future<void> loadSavedFormData() async {
    loading = true;
    await Future.delayed(Duration(seconds: 2));
    final simulatedSavedData = {
      'type': 2,
      'type2Data': 'Option B',
    };
    isLoadingSavedData = true; // This flag helps to avoid loading default values
    formKey.currentState?.fields['selectionType']?.didChange(simulatedSavedData['type']);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      formKey.currentState?.fields['type2Data']?.didChange(simulatedSavedData['type2Data']);
      loading = false;
    });
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
