import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';

class CompoundIcon extends StatelessWidget {
  final IconData firstIcon;
  final IconData secondIcon;
  final double size;
  final double scalar;

  const CompoundIcon({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    this.size = 24,
    this.scalar = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                firstIcon,
                size: size,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              // decoration: const BoxDecoration(
              //     shape: BoxShape.circle, color: Colors.white),
              child: DecoratedIcon(
                icon: Icon(
                  secondIcon,
                  size: size * .55,
                ),
                decoration: IconDecoration(
                    border: IconBorder(
                        color: Theme.of(context).colorScheme.background,
                        width: size / 8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
