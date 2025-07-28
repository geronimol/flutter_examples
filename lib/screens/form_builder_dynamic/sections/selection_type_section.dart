import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../form_builder_dynamic_model.dart';

class SelectionTypeSection extends StatelessWidget {
  const SelectionTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final formBuilderDynamicModel = FormBuilderDynamicInheritedNotifier.of(context);
    return Column(
      children: [
        FormBuilderDropdown(
          name: 'selectionType',
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text('Selection Type'),
          ),
          onChanged: (v) => formBuilderDynamicModel.onChangedSelectionType(v: v),
          // validator: FormBuilderValidators.compose(
          //   [FormBuilderValidators.required(errorText: 'Selection Type is required')],
          // ),
          items: [1,2,3]
              .map((value) => DropdownMenuItem(
            value: value,
            child: Text(value.toString()),
          ))
              .toList(),
        ),
      ],
    );
  }
}
