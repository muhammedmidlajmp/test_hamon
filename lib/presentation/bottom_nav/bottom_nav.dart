import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test_hamon/constants/bottom_nav_item.dart';
import 'package:test_hamon/presentation/classroom_list/classroom_list_screen.dart';
import 'package:test_hamon/presentation/provider/bottom_naprovider/bottom_nav_pro.dart';
import 'package:test_hamon/presentation/student_screen/student_list_screen.dart';
import 'package:test_hamon/presentation/subject_list/subject_list_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your screens
    final List<Widget> screens = [
      const StudentListScreen(),
      const SubjectListScreen(),
      const ClassroomListScreen(),
    ];

    return Scaffold(
      body:
          screens[Provider.of<BottomNavBarProvider>(context).currentItem.index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 87, 2, 59),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(context, BottomNavItem.student, 'Students'),
              buildNavItem(context, BottomNavItem.subject, 'Subjects'),
              buildNavItem(context, BottomNavItem.classRoom, 'Classrooms'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, BottomNavItem item, String label) {
    BottomNavItem currentItem =
        Provider.of<BottomNavBarProvider>(context).currentItem;

    return GestureDetector(
      onTap: () {
        Provider.of<BottomNavBarProvider>(context, listen: false)
            .setCurrentItem(item);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: currentItem == item
              ? const Color.fromARGB(255, 158, 99, 99)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getIcon(item),
              color: currentItem == item ? Colors.black : Colors.white,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: currentItem == item ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcon(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.student:
        return Icons.supervisor_account_sharp;
      case BottomNavItem.subject:
        return Icons.subject;
      case BottomNavItem.classRoom:
        return Icons.format_list_numbered_rounded;
    }
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Text('Favorites Screen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}
