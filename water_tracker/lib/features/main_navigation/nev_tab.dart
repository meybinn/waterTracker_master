import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:water_tracker/constant/gaps.dart';

class NevTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final Function onTab; // 선택된 index의 값에 따라 icon 선택

  const NevTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.onTab,
    required this.selectedIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTab(),
        child: Container(
          color: Colors.grey.shade300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                size: 34,
                isSelected ? selectedIcon : icon,
                color: isSelected
                    ? Colors.white
                    : const Color.fromRGBO(145, 144, 144, 1),
              ),
              Gaps.v5,
            ],
          ),
        ),
      ),
      //
    );
  }
}
