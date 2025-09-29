import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final List<IconData> icons;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final double height;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry borderRadius;

  const AppBottomNavBar({
    super.key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
    this.backgroundColor = const Color(0xFFF7CAC9),
    this.selectedColor = const Color(0xFFDC143C),
    this.unselectedColor = const Color(0xFFF75270),
    this.height = 70,
    this.margin = const EdgeInsets.only(right: 30, left: 30, bottom: 20),
    this.borderRadius = const BorderRadius.all(Radius.circular(25)),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 20, spreadRadius: 10),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: icons.asMap().entries.map((entry) {
          final index = entry.key;
          final icon = entry.value;
          final isSelected = selectedIndex == index;
          return IconButton(
            onPressed: () => onTap(index),
            icon: Icon(
              icon,
              size: 30,
              color: isSelected ? selectedColor : unselectedColor,
            ),
          );
        }).toList(),
      ),
    );
  }
}
