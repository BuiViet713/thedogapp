

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thedogapi/Cofig/colors.dart';
import 'package:thedogapi/pages/favoritePage.dart';
import 'package:thedogapi/pages/home/presenter/home_screen.dart';
import 'package:thedogapi/pages/dogai.dart';



class NavBarRoots extends StatefulWidget {
  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
   HomeScreen(),
   Dogai(),
   FavoriteListView(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black26,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "Home"),
            // BottomNavigationBarItem(
            //     icon: Icon(
            //       CupertinoIcons.person_2_square_stack_fill,),label: "Tác Giả"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: "Scan"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Yêu thích"),
              
          ],
        ),
      ),
    );
  }
}
