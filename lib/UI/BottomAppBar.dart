import 'package:covaccine/UI/size_config.dart';
import 'package:flutter/material.dart';

//this widget is for bottom navigation bar

class BottomAppBar extends StatelessWidget {
  BottomAppBar({this.selectedIndex});
  final selectedIndex;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.pushNamed(context, 'home-page');
      }else if(index == 1){
        Navigator.pushNamed(context, 'district-page');

      } 
      else if (index == 2) {
        Navigator.pushNamed(context, 'land-page');
      }
    }

    SizeConfig().init(context);
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      selectedFontSize: 12,
      backgroundColor: Colors.white,
      iconSize: SizeConfig.safeBlockVertical * 24,
      selectedItemColor: Color(0xffDD584F),
      unselectedItemColor: Color(0xffC6C6C6),
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Districts'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: 'Certificate'),
      ],
      onTap: _onItemTapped,
    );
  }
}
