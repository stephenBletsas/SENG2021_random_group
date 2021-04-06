import 'package:flutter/material.dart';
import 'package:plus_one/src/pages/homescreen.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/home/home_page.dart';
import 'package:plus_one/src/pages/chats/chat_list_page.dart';
import 'package:plus_one/src/pages/events/events_page.dart';
import 'package:plus_one/src/pages/history/history_page.dart';
import 'package:plus_one/src/pages/profile/profile_page.dart';

class HomeNavBarPage extends StatefulWidget {
  _HomeNavBarPageState createState() => _HomeNavBarPageState();
}

class _HomeNavBarPageState extends State<HomeNavBarPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    ChatListPage(),
    EventsPage(),
    HistoryPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: sixtyPercOrange,
        title: Center(
            child: Text(
          'PlusOne',
          style: TextStyle(
              color: unselectedGray, fontWeight: FontWeight.bold, fontSize: 25),
        )),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: unselectedGray,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.question_answer_outlined),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined), label: 'Profile'),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
