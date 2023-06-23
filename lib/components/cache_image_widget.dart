import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../extensions/validation_extensions.dart';

import '../utils/app_colors.dart';

class CachedImageWidget extends StatelessWidget {
  final String url;
  final double height;
  final double? width;
  final BoxFit? fit;
  final Color? color;
  final String? placeHolderImage;
  final AlignmentGeometry? alignment;
  final bool usePlaceholderIfUrlEmpty;
  final bool circle;
  final double? radius;

  CachedImageWidget({
    required this.url,
    required this.height,
    this.width,
    this.fit,
    this.color,
    this.placeHolderImage,
    this.alignment,
    this.radius,
    this.usePlaceholderIfUrlEmpty = true,
    this.circle = false,
  });

  @override
  Widget build(BuildContext context) {
    if (url.validateString().isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? (circle ? (height / 2) : 0)),
        child: Container(
          height: height,
          width: width ?? height,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: color ?? greyColor.withOpacity(0.1),
          alignment: alignment,
          padding: EdgeInsets.all(10),
          child: Image.asset(placeHolderImage ?? placeHolderImage!, height: 30, width: 30, fit: BoxFit.cover),
        ),
      );
    } else if (url.validateString().startsWith('https')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? (circle ? (height / 2) : 0)),
        child: CachedNetworkImage(
          placeholder: (_, __) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                radius ?? (circle ? (height / 2) : 0),
              ),
              child: Image.asset(placeHolderImage!, height: height, width: width, fit: fit ?? BoxFit.fill, alignment: alignment ?? Alignment.center),
            );
          },
          imageUrl: url,
          height: height,
          width: width ?? height,
          fit: fit,
          color: color,
          alignment: alignment as Alignment? ?? Alignment.center,
          errorWidget: (_, s, d) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                radius ?? (circle ? (height / 2) : 0),
              ),
              child: Image.asset(placeHolderImage!, height: height, width: width, fit: fit ?? BoxFit.fill, alignment: alignment ?? Alignment.center),
            );
          },
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? (circle ? (height / 2) : 0)),
        child: Image.asset(
          url,
          height: height,
          width: width ?? height,
          fit: fit,
          color: color,
          alignment: alignment ?? Alignment.center,
          errorBuilder: (_, s, d) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(
                radius ?? (circle ? (height / 2) : 0),
              ),
              child: Image.asset(placeHolderImage!, height: height, width: width, fit: fit ?? BoxFit.fill, alignment: alignment ?? Alignment.center),
            );
          },
        ),
      );
    }
  }
}
