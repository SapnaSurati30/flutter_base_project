import 'package:flutter/material.dart';

import '../Extensions/text_styles.dart';
import '../extensions/common_extensions.dart';
import '../utils/app_images.dart';

class NoDataWidget extends StatelessWidget {
  final String? image;
  final String? title;

  NoDataWidget({this.image, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(image ?? no_data_found, fit: BoxFit.cover, height: 200, width: 200),
        ),
        heightSpacer(8),
        Text(title ?? "No Data Found", style: boldTextStyle(), textAlign: TextAlign.center),
      ],
    );
  }
}
