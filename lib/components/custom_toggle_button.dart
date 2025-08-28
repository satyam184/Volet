import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  const CustomToggleButton({
    super.key,
    required this.onTabSelected,
    required this.tabs,
    required this.grayContainerRadius,
    required this.activeTabColor,
    required this.activeTextColor,
    required this.borderRadius,
    required this.backgroundColor,
    required this.selectedIndex,
  }) : assert(tabs.length >= 2, 'At least 2 tabs are required');

  final void Function(int) onTabSelected;
  final List<String> tabs;
  final Color activeTabColor;
  final Color activeTextColor;
  final double borderRadius;
  final Color backgroundColor;
  final double grayContainerRadius;
  final int selectedIndex;

  @override
  State<CustomToggleButton> createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / widget.tabs.length;

          return Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.grayContainerRadius),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: _selectedIndex * tabWidth,
                  child: Container(
                    width: tabWidth,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.activeTabColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                  ),
                ),

                Row(
                  children: List.generate(
                    widget.tabs.length,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedIndex = index;
                          });
                          widget.onTabSelected(index);
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          child: Text(
                            widget.tabs[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: _selectedIndex == index
                                  ? widget.activeTextColor
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
