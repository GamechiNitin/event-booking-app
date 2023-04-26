import 'package:adda/utils/color.dart';
import 'package:adda/utils/constant.dart';
import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

class TimeSlotsWidget extends StatelessWidget {
  const TimeSlotsWidget(
      {super.key,
      required this.slotsEnum,
      this.isSelected = false,
      required this.onTap});
  final SlotsEnum slotsEnum;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? kLightGreenColor : kBorderColor.withOpacity(0.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.access_time_sharp,
              size: 14,
            ),
            const SizedBox(width: 10),
            Text(
              slotsEnum.data,
              style: const TextStyle(
                color: Colors.black,
                fontSize: size12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
