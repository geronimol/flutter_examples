import 'package:flutter/material.dart';
import '../widgets/card_widget.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab Bar'),),
      body: const SafeArea(
        child: TabBarExample(),
      ),
    );
  }
}

class TabBarExample extends StatefulWidget {

  const TabBarExample({super.key});

  @override
  State<TabBarExample> createState() => _TabBarExampleState();
}

class _TabBarExampleState extends State<TabBarExample> with SingleTickerProviderStateMixin  {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // give the tab bar a height [can change height to preferred height]
        SizedBox(
          height: 45,
          child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.add, color: Colors.blue,),
                ),
              ),
              Expanded(
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.black87,
                  unselectedLabelStyle: const TextStyle(fontSize: 17),
                  labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Tab 1',
                    ),
                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Tab 2',
                    ),
                    Tab(
                      text: 'Tab 3',
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.search, color: Colors.blue,),
                ),
              ),
            ],
          ),
        ),
        // tab bar view here
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              // first tab bar view widget
              TabOne(),
              // second tab bar view widget
              TabTwo(),
              // third tab bar view widget
              TabThree(),
            ],
          ),
        ),
      ],
    );
  }
}

class TabThree extends StatelessWidget {
  const TabThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      crossAxisCount: 2,
      childAspectRatio: (3/4),
      children: const [
        CardWidget(),
        CardWidget(),
        CardWidget(),
        CardWidget(),
        CardWidget(),
        CardWidget(),
        CardWidget(),
        CardWidget(),
      ],
    );
  }
}

class TabTwo extends StatelessWidget {
  const TabTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      crossAxisCount: 2,
      childAspectRatio: (3/4),
      children: const [
        CardWidget(),
        CardWidget(),
        CardWidget(),
      ],
    );
  }
}

class TabOne extends StatelessWidget {
  const TabOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      crossAxisCount: 2,
      childAspectRatio: (3/4),
      children: const [
        CardWidget(),
      ],
    );
  }
}