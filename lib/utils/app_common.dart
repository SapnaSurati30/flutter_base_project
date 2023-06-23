import 'package:flutter/material.dart';
import '../extensions/validation_extensions.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Extensions/text_styles.dart';
import '../components/material_button_widget.dart';
import '../language/language_model.dart';
import '../main.dart';
import 'app_config.dart';
import 'app_constants.dart';
import 'app_images.dart';

ThemeMode get appThemeMode => appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light;

enum HttpResponseType { FULL_RESPONSE, JSON, BODY_BYTES, STRING }

enum HttpMethodType { GET, POST, DELETE, PUT }

Future<void> commonLaunchUrl(String address, {LaunchMode mode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: mode).catchError((e) {
    //toast('Invalid URL: $address');
  });
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

String formatDate(String? dateTime, {String format = DATE_FORMAT_1}) {
  return DateFormat(format).format(DateTime.parse(dateTime.validateString()));
}

List<LanguageDataModel> languageList() => [
      LanguageDataModel(id: 1, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: india_flag),
      LanguageDataModel(id: 2, name: 'Hindi', languageCode: 'hi', fullLanguageCode: 'en-US', flag: india_flag),
    ];

InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? label, double? borderRadius}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: label,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: PRIMARY_COLOR, width: 0.0),
    ),
    filled: true,
    fillColor: Theme.of(context).cardColor,
  );
}

Widget AppButtonCommon(Color color, Function onTap, BuildContext context, String text) {
  return MaterialButtonWidget(
    width: MediaQuery.of(context).size.width,
    color: color,
    child: Text(
      text,
      style: primaryTextStyle(color: Colors.white),
    ),
    onTap: onTap,
  );
}