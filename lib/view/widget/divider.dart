import 'package:flutter/material.dart';

class DividerSection extends StatelessWidget {
  final String title;
  final TextStyle sectionTitleStyle;

  const DividerSection(
      {super.key, required this.title, required this.sectionTitleStyle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider(thickness: 2)),
          Text(
            " $title ",
            style: sectionTitleStyle,
          ),
          const Expanded(child: Divider(thickness: 2)),
        ],
      ),
    );
  }
}

