import 'package:flutter/material.dart';

enum CompoundIconClipShape {
  rect,
  circle
}

class CompoundIcon extends StatelessWidget {
  CompoundIcon({
    super.key,
    required this.firstIcon,
    required this.secondIcon,
    this.size = 24,
    this.scalar = 1, this.shape = CompoundIconClipShape.rect,
  }) {
    switch (shape) {
      case CompoundIconClipShape.rect:
        clipper = CompoundIconRectClipper();
        break;
      case CompoundIconClipShape.circle:
        clipper = CompoundIconRoundClipper();
        break;
      default:
        clipper = CompoundIconRectClipper();
    }
  }

  final IconData firstIcon;
  final IconData secondIcon;
  final double size;
  final double scalar;
  final CompoundIconClipShape shape;
  late final CustomClipper<Path> clipper;

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
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: ClipPath(
                clipper: clipper,
                child: Icon(
                  firstIcon,
                  size: size,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              secondIcon,
              size: size * .55,
            ),
          ),
        ],
      ),
    );
  }
}

class CompoundIconRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path pathMain = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    Path clip = Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.48, size.height * 0.48, size.width * 0.6, size.height * 0.6), Radius.circular(size.width * 0.08)));
    return Path.combine(PathOperation.difference, pathMain, clip);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
class CompoundIconRoundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path pathMain = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    Path clip = Path()..addOval(Rect.fromLTWH(size.width * 0.45, size.height * 0.43, size.width * 0.63, size.height * 0.63));
    return Path.combine(PathOperation.difference, pathMain, clip);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
