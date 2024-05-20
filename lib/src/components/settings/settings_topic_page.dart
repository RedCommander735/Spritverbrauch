import 'package:flutter/material.dart';

class SettingsTopicPage extends StatelessWidget {
  const SettingsTopicPage({super.key, required this.title, required this.children, this.textSize = 16});

  final double textSize;

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: DefaultTextStyle(
        style: TextStyle(fontSize: textSize, color: Theme.of(context).colorScheme.onBackground),
        child: Column(
          children: children,
        ),
      ),
    );
  }
}
