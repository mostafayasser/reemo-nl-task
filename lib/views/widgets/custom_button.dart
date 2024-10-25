import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool iconBefore;
  final bool isTitleBold;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final bool hasElevation;

  const CustomButton({
    super.key,
    required this.title,
    this.icon,
    this.iconBefore = true,
    this.isTitleBold = true,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
    this.hasElevation = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        elevation: hasElevation ? 0.2 : 0,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconBefore && icon != null) icon!,
          if (iconBefore && icon != null) const SizedBox(width: 5),
          Text(
            title,
            style: isTitleBold
                ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: textColor ?? Colors.white,
                    )
                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor ?? Colors.white,
                    ),
          ),
          if (!iconBefore && icon != null) const SizedBox(width: 5),
          if (!iconBefore && icon != null) icon!,
        ],
      ),
    );
  }
}
