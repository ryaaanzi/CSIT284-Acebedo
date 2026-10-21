import 'package:flutter/material.dart';
import '../models/assessment_question.dart';

class AnswerButton extends StatelessWidget {
  final AnswerOption option;
  final VoidCallback onTap;

  const AnswerButton({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          side: BorderSide(
            color: colors.outlineVariant,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                option.text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}