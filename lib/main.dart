import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyTabsWidget(title: 'Test MyTabsWidget'),
    );
  }
}

class MyTabsWidget extends StatefulWidget {
  MyTabsWidget({Key key, this.title}) : super(key: key);

  final String title;

  static const String routeName = "/myTabsWidget";

  @override
  _MyTabsWidgetState createState() => new _MyTabsWidgetState();
}

enum MyWidgetTabs { tab1, tab2 }

class _MyTabsWidgetState extends State<MyTabsWidget>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  MyWidgetTabs _selectedTab;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _tabController = new TabController(
        vsync: this, initialIndex: 0, length: MyWidgetTabs.values.length);
    _tabController.addListener(_handleTabSelection);

    _selectedTab = MyWidgetTabs.tab1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
      _selectedTab = MyWidgetTabs.values[_tabController.index];
      print(
          "Changed tab to: ${_selectedTab.toString().split('.').last} , index: ${_tabController.index}");
    });
  }

  Widget _buildTopTab(BuildContext context, MyWidgetTabs tab) {
    print("Build tab - ${tab.toString()}");

    switch (tab) {
      case MyWidgetTabs.tab1:
        break;

      case MyWidgetTabs.tab2:
        break;
    }

    return new AnimatedBuilder(
        key: new ValueKey<MyWidgetTabs>(tab),
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  'Tab ${tab.toString().split('.').last}',
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("Build - main");

    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        bottom: new TabBar(
          controller: _tabController,
          labelColor: Colors.lightGreenAccent,
          tabs: <Widget>[
            new Tab(
                key: new ValueKey<MyWidgetTabs>(MyWidgetTabs.tab1),
                text: MyWidgetTabs.tab1.toString().split('.').last,
                icon: const Icon(Icons.favorite_border)),
            new Tab(
                key: new ValueKey<MyWidgetTabs>(MyWidgetTabs.tab2),
                text: MyWidgetTabs.tab2.toString().split('.').last,
                icon: const Icon(Icons.favorite)),
          ],
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Padding(
              key: new ValueKey<String>('x' + _selectedTab.toString()),
              padding: new EdgeInsets.symmetric(vertical: 20.0),
              child: new Text(
                "Selected tab: ${_selectedTab.toString().split('.').last}",
                style:
                new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              )),
          new Expanded(
            child:
            new TabBarView(controller: _tabController, children: <Widget>[
              _buildTopTab(context, MyWidgetTabs.tab1),
              _buildTopTab(context, MyWidgetTabs.tab2),
            ]),
          )
        ],
      ),
    );
  }
}