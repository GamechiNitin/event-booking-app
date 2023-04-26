import 'package:adda/utils/color.dart';
import 'package:adda/utils/dimens.dart';
import 'package:adda/view/widget/total_card_widget.dart';
import 'package:flutter/material.dart';

class BookingCardComponent extends StatelessWidget {
  const BookingCardComponent(
      {super.key,
      this.date,
      this.uuid,
      this.t1,
      this.t2,
      this.timeDifference,
      this.total,
      this.activities,
      this.desc});
  final String? uuid;
  final String? date;
  final String? t1, t2;
  final int? total, timeDifference;
  final String? activities;
  final String? desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: kBlueColor.withOpacity(0.2),
        border: Border.all(width: kBorderWidth, color: kLightGreenColor),
      ),
      child: Column(
        children: [
          TotalCardWidget(
            v1: "Id",
            v2: uuid ?? "",
          ),
          Divider(
            height: 0,
            color: kLightGreenColor,
            thickness: kBorderWidth,
          ),
          TotalCardWidget(
            v1: "Status",
            v2: "Not Approved",
            textColor: kRedColor,
          ),
          Divider(
            height: 0,
            color: kLightGreenColor,
            thickness: kBorderWidth,
          ),
          TotalCardWidget(
            v1: "Activities",
            v2: activities ?? "",
          ),
          Divider(
            height: 0,
            color: kLightGreenColor,
            thickness: kBorderWidth,
          ),
          if (desc != "")
            TotalCardWidget(
              v1: "Description",
              v2: desc ?? "",
            ),
          Divider(
            height: 0,
            color: kLightGreenColor,
            thickness: kBorderWidth,
          ),
          TotalCardWidget(
            v1: "Date",
            v2: date ?? "",
          ),
          Divider(
            height: 0,
            color: kLightGreenColor,
            thickness: kBorderWidth,
          ),
          TotalCardWidget(
            v1: "Time",
            v2: "$t1 - $t2 ($timeDifference hr)",
          ),
          if (timeDifference != null && total != null)
            TotalCardWidget(
              color: kBlueColor,
              v1: "Total",
              v2: "$timeDifference hr x ${total! / timeDifference!} = $total Rs",
            ),
        ],
      ),
    );
  }
}
