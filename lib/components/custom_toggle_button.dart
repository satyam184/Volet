import 'package:flutter/material.dart';

class CustomToggleButton extends StatelessWidget {
  CustomToggleButton({
    required this.onTabSelected,
    required this.tabs,
    required this.grayContainerRadius,
    required this.activeTabColor,
    required this.activeTextColor,
    required this.borderRadius,
    required this.backgroundColor,

    super.key,
    required this.selectedIndex,
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  final void Function(int) onTabSelected;
  final List<String> tabs;
  final Color activeTabColor;
  final Color activeTextColor;
  final double borderRadius;
  final Color backgroundColor;
  final double grayContainerRadius;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(grayContainerRadius),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: selectedIndex * tabWidth,
                  child: Container(
                    width: tabWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: activeTabColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ),

                // Row of tabs
                Row(
                  children: List.generate(
                    tabs.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          selectedIndex = index;
                          onTabSelected(index);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: selectedIndex == index
                                  ? activeTextColor
                                  : const Color(0xFF7D7D91),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
