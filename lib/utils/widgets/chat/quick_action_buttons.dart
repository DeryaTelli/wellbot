import 'package:flutter/material.dart';
import 'package:wellbot/utils/theme/custom_text_style.dart';

class QuickActionButtons extends StatelessWidget {
  final List<String> actions;
  final ValueChanged<String> onTap;

  const QuickActionButtons({
    super.key,
    required this.actions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: actions.map((action) {
        return InkWell(
          onTap: () => onTap(action),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0x33FFFFFF)),
              ),
            ),
            child: Text(
              action,
              textAlign: TextAlign.center,
              style: CustomTextStyles.semiBold16DarkGreyDense,
            ),
          ),
        );
      }).toList(),
    );
  }
}