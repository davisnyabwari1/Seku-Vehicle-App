import 'package:flutter/material.dart';

class BottomNavigator extends StatefulWidget {
  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
      ],
      onTap: (index) {
        currentIndex = index;
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 350,
                color: Colors.white,
              );
            });
      },
    );
  }
}
