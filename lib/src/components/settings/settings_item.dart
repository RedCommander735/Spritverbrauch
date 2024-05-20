import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.onTap,
  });

  final IconData? icon;
  final String? title;
  final String? subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (onTap == null) ? () {} : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          height: 72,
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(icon),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) Text(title!),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
                        fontSize: DefaultTextStyle.of(context).style.fontSize! * 9 / 10),
                    softWrap: true,
                  ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
