import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class StickyHeadersScreen extends StatelessWidget {
  const StickyHeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sticky Headers')),
      body: const SafeArea(
        child: StickyHeadersWidget(),
      ),
    );
  }
}

class StickyHeadersWidget extends StatelessWidget {
  const StickyHeadersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        StickyHeaderList(index: 0),
        StickyHeaderList(index: 1),
        StickyHeaderList(index: 2),
        StickyHeaderList(index: 3),
        StickyHeaderList(index: 4),
        StickyHeaderList(index: 5),
      ],
    );
  }
}

class StickyHeaderList extends StatelessWidget {
  const StickyHeaderList({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader.builder(
      builder: (context, state) => Container(
        height: 70,
        color: Colors.blueAccent.withValues(alpha: 1 - state.scrollPercentage),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 3,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              'Header #$index',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: double.infinity,
                  height: 3,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, i) => ListTile(
            leading: CircleAvatar(
              child: Text('$index'),
            ),
            title: Text('List tile #$i'),
          ),
          childCount: 10,
        ),
      ),
    );
  }
}
