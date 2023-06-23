import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../extensions/shared_pref.dart';
import '../language/app_localizations.dart';
import '../language/language_model.dart';
import '../main.dart';
import '../utils/app_config.dart';
import '../utils/app_constants.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  bool isDarkMode = false;

  @observable
  String? token = '';

  @observable
  String selectedLanguageCode = DEFAULT_LANGUAGE;

  @action
  void setLoading(bool val) => isLoggedIn = val;

  @action
  void setDarkMode(bool val) => isDarkMode = val;

  @action
  void setToken(String? tokenString) {
    token = tokenString;
  }


  @action
  Future<void> setLanguage(String val) async {
    selectedLanguageCode = val;
    selectedLanguageDataModel = getSelectedLanguageModel();

    await setValue(SELECTED_LANGUAGE_CODE, selectedLanguageCode);

    language = await AppLocalizations().load(Locale(selectedLanguageCode));
  }
}
