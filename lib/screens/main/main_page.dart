import 'package:exam/screens/account/account.dart';
import 'package:exam/screens/home/home_page.dart';
import 'package:exam/screens/notifications/notifications.dart';
import 'package:exam/screens/tasks/tasks_page.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List pages = [HomePage(), Tasks(), Account(), Notifications()];

    return Scaffold(
      body: Scaffold(
        body: pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        unselectedItemColor: Color(0xffDBE9F7),
        selectedLabelStyle: TextStyle(
          fontSize: 12.0,
          color: kSecondaryColor,
        ),
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: ImageIcon(AssetImage("assets/icons/Home.png")),
          ),
          BottomNavigationBarItem(
            label: 'Tasks',
            icon: ImageIcon(AssetImage("assets/icons/Paper.png")),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: ImageIcon(AssetImage("assets/icons/Profile.png")),
          ),
          BottomNavigationBarItem(
            label: 'Notifications',
            icon: ImageIcon(AssetImage("assets/icons/Notification.png")),
          ),
        ],
      ),
    );
  }

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
