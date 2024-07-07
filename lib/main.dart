import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import 'features/adhkar/Adhkar.dart';
import 'features/categories/Categories.dart';
import 'features/favorites/Favorites.dart';
import 'features/sebha/Sebha.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  static const List<Widget> _pages = <Widget>[
    Adhkar(),
    Categories(),
    Sebha(),
    Favorites(),
  ];

  static const List<String> _titles = <String>[
    'Adhkar',
    'Categories',
    'Sebha',
    'Favorites',
  ];

  static const List<Color> _appBarColors = <Color>[
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.green,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appBarColors[_selectedIndex],
        centerTitle: true,
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown[200],
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
        ),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FlutterIslamicIcons.prayer),
            label: 'الأذكار',
          ),
          BottomNavigationBarItem(
            icon: Icon(FlutterIslamicIcons.solidTasbih2),
            label: 'المسبحة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'المفضلة',
          ),
        ],
      ),
    );
  }
}
