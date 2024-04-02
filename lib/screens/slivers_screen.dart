import 'package:flutter/material.dart';
import '../constants.dart';

class SliversScreen extends StatelessWidget {
  const SliversScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              stretch: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.blurBackground, StretchMode.fadeTitle, StretchMode.zoomBackground],
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/test_img.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                    )
                  ],
                ),
                title: const Text('Slivers'),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sliver List',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, decoration: TextDecoration.underline),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: kItemsList.length,
                (context, index) {
                  final item = kItemsList[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(kDefaultPadding),
                    title: Text(
                      item,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.all(kDefaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Sliver Grid',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, decoration: TextDecoration.underline),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              delegate: SliverChildBuilderDelegate(
                childCount: kItemsList.length,
                (context, index) {
                  final item = kItemsList[index];
                  return Card(
                    elevation: 2,
                    child: Center(
                      child: Text(item, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
