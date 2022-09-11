import 'package:flutter/material.dart';
import 'package:flutter_examples/widgets/countdown_ticker_card.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../utils/masked_date_formatter.dart';

class CountdownToDateScreen extends StatefulWidget {
  const CountdownToDateScreen({Key? key}) : super(key: key);

  @override
  State<CountdownToDateScreen> createState() => _CountdownToDateScreenState();
}

class _CountdownToDateScreenState extends State<CountdownToDateScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Countdown to date'),),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 10,),

              /// Date form input
              FormBuilder(
                key: _formKey,
                autovalidateMode: _autovalidateMode,
                child: SizedBox(
                  width: 220,
                  child: FormBuilderTextField(
                    name: 'date',
                    keyboardType: TextInputType.number,
                    inputFormatters: [MaskFormatter.getDateMaskFormatter()],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Future Date mm/dd/yyyy'),
                    ),
                    textInputAction: TextInputAction.done,
                    valueTransformer: (s) {
                      /// Transform to ISO String Y-M-D
                      if(s != null && s.length == 10) {
                        final splittedDate = s.split('/');
                        final dateString = '${splittedDate[2]}-${splittedDate[0]}-${splittedDate[1]}';
                        return DateTime.parse(dateString).toIso8601String();
                      }
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(errorText: 'Please enter a date.'),
                          (s) {
                        if(s?.length == 10) {
                          final splittedDate = s!.split('/');
                          final dateString = '${splittedDate[2]}-${splittedDate[0]}-${splittedDate[1]}';
                          if(DateTime.tryParse(dateString) != null) {
                            DateTime selectedDate = DateTime.parse(dateString);
                            final day = selectedDate.day.toString().padLeft(2, '0');
                            final month = selectedDate.month.toString().padLeft(2, '0');
                            if(selectedDate.year.toString() == splittedDate[2] && day == splittedDate[1] && month == splittedDate[0]) {
                              if(selectedDate.isAfter(DateTime.now())) {
                                return null;
                              } else {
                                return 'Please enter a valid date.';
                              }
                            } else {
                              return 'Please enter a valid date.';
                            }
                          }
                        }
                        return 'Please enter a future date.';
                      }
                    ]),
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              /// Countdown ticker
              _selectedDate == null
                  ? const SizedBox.shrink()
                  :
              Column(
                children: [
                  Text('Countdown to: ${DateFormat.yMd().add_jm().format(_selectedDate!)}'),
                  const SizedBox(height: kDefaultPadding,),
                  CountdownTickerCard(date: _selectedDate!),
                ],
              ),

              const SizedBox(height: 20,),

              /// Start Button
              ElevatedButton(
                onPressed: () {
                  bool isFormValid = _formKey.currentState!.validate();
                  if(isFormValid) {
                    _formKey.currentState!.save();
                    setState(() {
                      _selectedDate = DateTime.parse(_formKey.currentState!.value['date']);
                    });
                  } else {
                    setState(() {
                      _autovalidateMode = AutovalidateMode.onUserInteraction;
                    });
                  }
                },
                child: const Text('START'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
