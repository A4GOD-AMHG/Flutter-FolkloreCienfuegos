import 'package:cienfuegos_folklore/widgets/info_modal.dart';
import 'package:flutter/material.dart';

/// "?" button shown in the top-right corner of every screen.
class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
            color: Color(0xFFDAB589), borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => showCustomModal(context),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              Icons.question_mark,
              color: Colors.black,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
