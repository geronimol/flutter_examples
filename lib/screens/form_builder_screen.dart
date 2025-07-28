import 'package:flutter/material.dart';

import 'form_builder_dynamic/form_builder_dynamic_screen.dart';
import 'form_builder_simple_screen.dart';

class FormBuilderScreen extends StatelessWidget {
  const FormBuilderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Builder')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormBuilderSimpleScreen())),
                      label: Text('Simple'),
                      icon: Icon(Icons.description),
                    ),
                    SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FormBuilderDynamicScreen())),
                      label: Text('Dynamic'),
                      icon: Icon(Icons.dynamic_form),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
