import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutterbasic/screens/design/design_page.dart';

import 'package:flutterbasic/screens/dictionary/dictionary_page.dart';
import 'package:flutterbasic/screens/info/info_page.dart';
import 'package:flutterbasic/screens/response/response_page.dart';

void main() => runApp(const MyApp());

/// main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Sample App';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        MyBottomNavBar.name: (context) => MyBottomNavBar(),
        InfoPage.name: (context) => InfoPage(),
        DesignPage.name: (context) => DesignPage(),
        ResponsePage.name: (context) => ResponsePage(),
        DictionaryPage.name: (context) => ResponsePage(),
   
      },
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ).copyWith(
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      ),
      home: MyBottomNavBar(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyBottomNavBar extends StatefulWidget {
  static const String name = 'MybottomNavBar';
  int? selectedIndex;
  MyBottomNavBar({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

/// This is the private State class that goes with MyBottomNavBar.
class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      widget.selectedIndex = ModalRoute.of(context)!.settings.arguments as int?;
      setState(() {
        if (widget.selectedIndex != null) {
          selectedIndex = widget.selectedIndex!;
        }
      });
    });
  }

  static final List<Widget> _widgetOptions = <Widget>[
    InfoPage(),
   const DesignPage(),
    ResponsePage(),
    DictionaryPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:PageTransitionSwitcher(
        duration: const Duration(seconds:1),
        transitionBuilder: (child,primaryAnimation,secondaryAnimation)=>
      FadeThroughTransition(animation: primaryAnimation, secondaryAnimation: secondaryAnimation,child: child,),
      child:_widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.architecture_outlined,
              color: Colors.blue,
            ),
            label: 'Design',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.feedback_outlined,
              color: Colors.blue,
            ),
            label: 'Response',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_add_outlined,
              color: Colors.blue,
            ),
            label: 'Dictionary',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
