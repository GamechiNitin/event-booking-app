import 'package:adda/utils/color.dart';
import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

class DialogBox {
  static Widget dialogSlot() {
    return SimpleDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 20,
      ),
      title: const Text("Pre-TimeSlots"),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("ClubHouse"),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kLightGreenColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.access_time_sharp,
                        size: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "10:00 AM - 4:00 AM",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size12,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "6 hr x 100 = 600 Rs",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kRedColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.access_time_sharp,
                        size: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "4:00 PM - 10:00 PM",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size12,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "6 hr x 500 = 3000 Rs",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text("Tennis"),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: kBlueColor.withOpacity(0.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.access_time_sharp,
                        size: 14,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "10:00 - 4:00 AM",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: size12,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "6 hr x 50 = 300 Rs",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
