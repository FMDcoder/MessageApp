import 'package:flutter/material.dart';
import 'header.dart';
import '../page/friendspage.dart';
import '../page/scanpage.dart';
import '../page/profilepage.dart';
import '../page/searchpage.dart';

/// Shell with a bottom navigation bar that switches between 4 pages.
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    ScanPage(),
    SearchPage(),
    FriendsPage(),
    ProfilePage(),
  ];

  static const List<String> _titles = [
    'Scan',
    'Search',
    'Friends',
    'Profile',
  ];

  static const List<_NavItemData> _items = [
    _NavItemData(Icons.qr_code_scanner, Icons.qr_code, 'Scan'),
    _NavItemData(Icons.search, Icons.search, 'Search'),
    _NavItemData(Icons.people_outline, Icons.people, 'Friends'),
    _NavItemData(Icons.person_outline, Icons.person, 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: _titles[_selectedIndex]),
      // IndexedStack keeps each page's state when you switch tabs.
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: _BottomBar(
        items: _items,
        selectedIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const _NavItemData(this.icon, this.selectedIcon, this.label);
}

/// Custom bottom bar: a white highlight with a thin green top line
/// glides to the selected item.
class _BottomBar extends StatelessWidget {
  final List<_NavItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomBar({
    required this.items,
    required this.selectedIndex,
    required this.onTap,
  });

  static const Color _barColor = Color(0xFFEDEDED); // bar background
  static const Color _lineColor = Colors.green; // top line on selected item
  static const Duration _duration = Duration(milliseconds: 100);
  static const Curve _curve = Curves.easeInOut;
  static const double _height = 64;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: _barColor,
      elevation: 8,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _height,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double itemWidth = constraints.maxWidth / items.length;

              return Stack(
                children: [
                  // The sliding highlight.
                  AnimatedPositioned(
                    duration: _duration,
                    curve: _curve,
                    left: selectedIndex * itemWidth,
                    top: 0,
                    width: itemWidth,
                    height: _height,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: _lineColor, width: 2),
                        ),
                      ),
                    ),
                  ),
                  // The items on top of the highlight.
                  Row(
                    children: [
                      for (int i = 0; i < items.length; i++)
                        Expanded(
                          child: _BottomBarItem(
                            data: items[i],
                            selected: i == selectedIndex,
                            onTap: () => onTap(i),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  final _NavItemData data;
  final bool selected;
  final VoidCallback onTap;

  const _BottomBarItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color targetColor =
    selected ? Colors.green.shade800 : Colors.black54;

    return Semantics(
      button: true,
      selected: selected,
      label: data.label,
      child: InkWell(
        onTap: onTap,
        child: TweenAnimationBuilder<Color?>(
          tween: ColorTween(end: targetColor),
          duration: _BottomBar._duration,
          curve: _BottomBar._curve,
          builder: (context, color, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(selected ? data.selectedIcon : data.icon, color: color),
                const SizedBox(height: 2),
                Text(
                  data.label,
                  style: TextStyle(fontSize: 12, color: color),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}