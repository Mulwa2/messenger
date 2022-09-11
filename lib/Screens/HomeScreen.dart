import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/components/Icon_buttons.dart';
import 'package:messenger/components/RandomPicker.dart';
import 'package:messenger/components/avatar.dart';
import '../Pages/calls.dart';
import '../Pages/contacts.dart';
import '../Pages/messanges.dart';
import '../Pages/notification.dart';
import '../theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> tittle = ValueNotifier("Messages");

  final pages = const [
    messanges(),
    notifications(),
    calls(),
    contacts(),
  ];
  final pageTittles = const [
    "Messages",
    "Notifications",
    "Calls",
    "Contacts",
  ];
  void _ooNavigationItemSelected(index) {
    tittle.value = pageTittles[index];
    pageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ValueListenableBuilder(
          valueListenable: tittle,
          builder: (BuildContext context, value, _) {
            return Text(
              tittle.value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            );
          },
        ),
        leading: Center(
          child: IconBackground(
            icon: Icons.search,
            onTap: () {},
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Avatar.small(
              url: Randoms.randomPictureUrl(),
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (BuildContext context, int value, _) {
          return pages[pageIndex.value];
        },
      ),
      bottomNavigationBar: Bottombar(
        onItemSelacted: _ooNavigationItemSelected,
      ),
    );
  }
}

class Bottombar extends StatefulWidget {
  const Bottombar({super.key, required this.onItemSelacted});

  final ValueChanged<int> onItemSelacted;

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  var selectedIndex = 0;

  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelacted(index);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Card(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      color: (brightness == Brightness.light) ? Colors.transparent : null,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItem(
              isSelected: (selectedIndex == 0),
              onTap: handleItemSelected,
              index: 0,
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              lable: 'Messanges',
            ),
            _NavigationBarItem(
              isSelected: (selectedIndex == 1),
              onTap: handleItemSelected,
              index: 1,
              icon: CupertinoIcons.bell_solid,
              lable: 'Notifications',
            ),
            _NavigationBarItem(
              isSelected: (selectedIndex == 2),
              onTap: handleItemSelected,
              index: 2,
              icon: CupertinoIcons.phone_fill,
              lable: 'Calls',
            ),
            _NavigationBarItem(
              isSelected: (selectedIndex == 3),
              onTap: handleItemSelected,
              index: 3,
              icon: CupertinoIcons.person_2_fill,
              lable: 'Contacts',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem(
      {
      // ignore: unused_element
      Key? key,
      required this.lable,
      required this.icon,
      this.isSelected = false,
      required this.index,
      required this.onTap});

  final ValueChanged<int> onTap;

  final String lable;
  final IconData icon;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTap(index);
      },
      child: SizedBox(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.secondary : null,
            ),
            const SizedBox(height: 8),
            Text(
              lable,
              style: isSelected
                  ? const TextStyle(
                      fontSize: 11,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold)
                  : const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
