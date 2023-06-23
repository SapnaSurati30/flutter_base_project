import '../extensions/pattern.dart';
import 'common_extensions.dart';
import 'dart:convert';

extension BooleanExtensions on bool? {
  /// Validate given bool is not null and returns given value if null.
  bool validateBool({bool value = false}) => this ?? value;
}

extension DoubleExtensions on double? {
  /// Validate given bool is not null and returns given value if null.
  double validateDouble({double value = 0.0}) => this ?? value;
}

RegExp alphaRegExp = RegExp(r'^[a-zA-Z]+$');

extension StringValidateExtension on String? {
  /// Check email validation
  bool validateEmail() => hasMatch(this, Patterns.email);

  /// Check phone validation
  bool validatePhone() => hasMatch(this, Patterns.phone);

  /// Check URL validation
  bool validateURL() => hasMatch(this, Patterns.url);

  /// Returns true if given String is null or isEmpty
  bool get isEmptyOrNull => this == null || (this != null && this!.isEmpty) || (this != null && this! == 'null');

  // Check null string, return given value if null
  String validateString({String value = ''}) {
    if (this.isEmptyOrNull) {
      return value;
    } else {
      return this!;
    }
  }

  bool isJson() {
    try {
      json.decode(this.validateString());
    } catch (e) {
      return false;
    }
    return true;
  }
}

extension IntValidateExtensions on int? {
  /// Validate given int is not null and returns given value if null.
  int validateInt({int value = 0}) {
    return this ?? value;
  }
  bool isSuccessful() => this! >= 200 && this! <= 206;
}
