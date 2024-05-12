import 'package:flutter/material.dart';

class SPButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double width;
  final bool primary;

  const SPButton(this.text,
      {super.key,
      required this.onPressed,
      this.width = 150,
      this.primary = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              primary ? Theme.of(context).colorScheme.primary : null,
          fixedSize: Size.fromWidth(width)),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            color: primary ? Theme.of(context).colorScheme.onPrimary : null),
      ),
    );
  }
}

class SPDynButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final double padding;
  final bool primary;

  const SPDynButton(this.text,
      {super.key,
      required this.onPressed,
      this.padding = 16,
      this.primary = false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor:
              primary ? Theme.of(context).colorScheme.primary : null),
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: Text(
          text,
          style: TextStyle(
              color: primary ? Theme.of(context).colorScheme.onPrimary : null),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class SPButtonGroup extends StatelessWidget {
  final String primartyText;
  final String secondaryText;
  final void Function()? primaryOnPressed;
  final void Function()? secondaryOnPressed;

  const SPButtonGroup(
      {super.key,
      required this.primartyText,
      required this.secondaryText,
      this.primaryOnPressed,
      this.secondaryOnPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SPButton(
          primartyText,
          onPressed: primaryOnPressed,
          primary: true,
        ),
        SPButton(
          secondaryText,
          onPressed: secondaryOnPressed,
        ),
      ],
    );
  }
}
