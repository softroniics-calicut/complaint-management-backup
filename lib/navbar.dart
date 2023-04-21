import 'package:complaint_management/complaint.dart';
import 'package:complaint_management/review.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({Key? key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Complaint(),
    Home(),
    Review(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outlined),
                label: 'Add',
                backgroundColor:Color.fromARGB(255, 107, 162, 222),),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Color.fromARGB(255, 107, 162, 222),),
            BottomNavigationBarItem(
              icon: Icon(Icons.reviews),
              label: 'Review',
              backgroundColor:Color.fromARGB(255, 107, 162, 222),),
            
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
