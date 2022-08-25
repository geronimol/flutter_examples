import 'package:flutter/material.dart';
import 'package:flutter_examples/constants.dart';
import 'package:flutter_examples/screens/common_form_screen.dart';
import 'package:flutter_examples/screens/countdown_to_date_screen.dart';
import 'package:flutter_examples/screens/form_builder_screen.dart';
import 'package:url_launcher/link.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Flutter Examples'),),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Center(
          child: Column(
            children: [
              const Text(
                'This app will contain some things that I made.',
                style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Link(
                uri: Uri.parse(kProjectsUrl),
                target: LinkTarget.blank,
                builder: (_, followLink) => TextButton(
                  onPressed: followLink,
                  child: const Text(
                    'Link to my projects',
                    style: TextStyle(decoration: TextDecoration.underline),),
                ),
              ),
              const SizedBox(height: kDefaultPadding,),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CommonFormScreen())),
                child: const Text('Common Form'),
              ),
              const SizedBox(height: kDefaultPadding,),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FormBuilderScreen())),
                child: const Text('Form Builder'),
              ),
              const SizedBox(height: kDefaultPadding,),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CountdownToDateScreen())),
                child: const Text('Countdown to date'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}