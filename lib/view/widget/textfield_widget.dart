import 'package:adda/utils/color.dart';
import 'package:adda/utils/dimens.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.fn,
    required this.hintText,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.keyboardType,
    required this.labelText,
    this.onTap,
    this.iconData,
    this.info,
    this.onInfoTap,
  });
  final TextEditingController controller;
  final FocusNode fn;
  final String hintText;
  final String labelText;
  final int? maxLines;
  final int? minLines;
  final bool? enabled;
  final TextInputType? keyboardType;
  final VoidCallback? onTap;
  final VoidCallback? onInfoTap;
  final IconData? iconData;
  final IconData? info;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6, left: 4, top: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  labelText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: size14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (info != null)
                  GestureDetector(
                    onTap: onInfoTap,
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        info,
                        color: kBlueColor,
                        size: size14 + 1,
                      ),
                    ),
                  )
              ],
            ),
          ),
          TextFormField(
            controller: controller,
            focusNode: fn,
            maxLines: maxLines,
            minLines: minLines,
            enabled: enabled,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: size14,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(
                left: 16,
                top: maxLines != null && maxLines! > 1 ? 16 : 0,
              ),
              border: kBorder,
              enabledBorder: kBorder,
              disabledBorder: kBorder,
              errorBorder: kErrorBorder,
              focusedBorder: kFocusBorder,
              focusedErrorBorder: kErrorBorder,
              suffixIcon: iconData != null
                  ? Icon(
                      iconData,
                      color: kLightGreenColor,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
