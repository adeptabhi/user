import 'package:flutter/material.dart';
import 'package:user/util/theme/theme_color.dart';

class DataStateWidget extends StatelessWidget {
  final double height;
  final String msg;
  const DataStateWidget(this.msg, {super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: height,
          child: Center(
            child: Text(
              msg,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ThemeColor.textBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
