import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

class TotalCardWidget extends StatelessWidget {
  const TotalCardWidget(
      {super.key, required this.v1, required this.v2, this.color});
  final String v1, v2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 4,
        bottom: 4,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(kBorderRadius),
          bottomRight: Radius.circular(kBorderRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$v1 :",
            style: const TextStyle(
              color: Colors.black,
              fontSize: size12,
            ),
          ),
          Text(
            v2,
            style: const TextStyle(
              color: Colors.black,
              fontSize: size12,
            ),
          )
        ],
      ),
    );
  }
}
