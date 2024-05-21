import 'package:flutter/material.dart';

class CardCharacter extends StatelessWidget {
  final String name;
  final Color bgColor;
  final Color borderColor;
  const CardCharacter({
    super.key,
    required this.name,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 100,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(
              color: borderColor,
              width: 3,
            ),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Center(
              child: Image.asset(
            'assets/images/Main Characters/$name/Jump (32x32).png',
            scale: 0.5,
          )),
        ),
        Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: borderColor, width: 3),
              right: BorderSide(color: borderColor, width: 3),
              bottom: BorderSide(color: borderColor, width: 3),
            ),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Center(
              child: Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          )),
        )
      ],
    );
  }
}
