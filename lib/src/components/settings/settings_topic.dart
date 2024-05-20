import 'package:flutter/material.dart';

class SettingsTopic extends StatelessWidget {
  const SettingsTopic({
    super.key,
    this.icon,
    this.title,
    this.onTap,
  });

  final IconData? icon;
  final String? title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap == null) ? () {} : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 64,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon),
            ),
            Text((title == null) ? '' : title!)
          ]),
        ),
      ),
    );
  }
}
