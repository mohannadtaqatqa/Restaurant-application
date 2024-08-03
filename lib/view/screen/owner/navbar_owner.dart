import 'package:flutter/material.dart';
import 'package:foodapp/view/screen/owner/home_owner.dart';

import '../../../core/constant/colors.dart';


class NavBarOwner extends StatefulWidget {
  const NavBarOwner({super.key});

  @override
  State<NavBarOwner> createState() => _NavBarOwnerState();
}

class _NavBarOwnerState extends State<NavBarOwner> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePageOwner(),
    Text("orders for me"),
    const Text("Order"),
    Text("Profile"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'السلة'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'الطلبات'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'حسابي'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: grey,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
    );
  }
}
