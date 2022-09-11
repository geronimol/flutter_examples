import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_examples/constants.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'carousel_slider_screen.dart';
import 'common_form_screen.dart';
import 'countdown_to_date_screen.dart';
import 'datatable_screen.dart';
import 'fetch_json_data_screen.dart';
import 'form_builder_screen.dart';
import 'tabbar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Flutter Examples'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Center(
              child: Column(
                children: [
                  const SelectableText(
                    'This app will contain some things that I made.',
                    style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text.rich(
                    textAlign: TextAlign.left,
                    TextSpan(
                        style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
                        children: [
                          const TextSpan(
                            text: 'You can check my projects ',
                          ),
                          /// Link
                          TextSpan(
                            text: 'here',
                            style: const TextStyle(decoration: TextDecoration.underline, color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () { launchUrl(Uri.parse(kProjectsUrl));
                              },
                          ),
                        ]
                    ),
                  ),
                  /// Link
                  Link(
                    uri: Uri.parse(kMyWebsiteUrl),
                    target: LinkTarget.blank,
                    builder: (_, followLink) => TextButton(
                      onPressed: followLink,
                      child: const Text(
                        'Link to my website',
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
                  const SizedBox(height: kDefaultPadding,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TabBarScreen())),
                    child: const Text('TabBar'),
                  ),
                  const SizedBox(height: kDefaultPadding,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CarouselSliderScreen())),
                    child: const Text('Carousel Slider'),
                  ),
                  const SizedBox(height: kDefaultPadding,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DataTableScreen())),
                    child: const Text('Data Table'),
                  ),
                  const SizedBox(height: kDefaultPadding,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const FetchJsonDataScreen())),
                    child: const Text('Fetch Json Data'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}