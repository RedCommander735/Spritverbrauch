import 'package:flutter/material.dart';

class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.from([
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: DefaultTextStyle.of(context).style.fontSize! * 17 / 20),
              ),
            ),
          ],
        )
      ])
        ..addAll(children)..add(const Divider(
          height: 0,
        )),
    );
  }
}
