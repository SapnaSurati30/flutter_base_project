import 'dart:convert';
import 'dart:io';
import '../extensions/validation_extensions.dart';
import 'package:http/http.dart';
import '../extensions/common_extensions.dart';
import '../extensions/network_utils.dart';
import '../main.dart';
import '../utils/app_common.dart';
import '../utils/app_config.dart';
import '../utils/app_constants.dart';

Future<Map<String, String>> buildTokenHeader() async {
  Map<String, String> header = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  if (appStore.isLoggedIn) {
    header.putIfAbsent(HttpHeaders.authorizationHeader, () => 'Bearer ${appStore.token}');
  }

  printLog(jsonEncode(header));

  return header;
}

Uri buildBaseUrl(String endPoint) {
  Uri url = Uri.parse(endPoint);
  if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');

  printLog('URL: ${url.toString()}');

  return url;
}

Future<dynamic> buildHttpResponse(
  String endPoint, {
  HttpMethodType method = HttpMethodType.GET,
  dynamic request,
  bool jsonRequest = true,
  HttpResponseType responseType = HttpResponseType.JSON,
}) async {
  if (await isNetworkAvailable()) {
    var headers = await buildTokenHeader();
    Uri url = buildBaseUrl(endPoint);

    Response response;

    if (method == HttpMethodType.POST) {
      printLog('Request: ${jsonEncode(request)}');

      response = await post(url, body: jsonRequest ? jsonEncode(request) : request, headers: headers);
    } else if (method == HttpMethodType.DELETE) {
      response = await delete(url, headers: headers);
    } else if (method == HttpMethodType.PUT) {
      response = await put(url, body: jsonRequest ? jsonEncode(request) : request, headers: headers);
    } else {
      response = await get(url, headers: headers);
    }

    printLog('Response (${method.name}) ${response.statusCode}: ${response.body}');

    return await handleResponse(response, responseType: responseType);
  } else {
    throw yourInternetIsNotWorking;
  }
}

Future handleResponse(Response response, {HttpResponseType responseType = HttpResponseType.JSON}) async {
  if (!await isNetworkAvailable()) {
    throw yourInternetIsNotWorking;
  }

  if (response.statusCode.isSuccessful()) {
    if (response.body.isEmpty) {
      return '';
    } else {
       if (responseType == HttpResponseType.JSON) {
        return jsonDecode(response.body);
      } else if (responseType == HttpResponseType.FULL_RESPONSE) {
        return response;
      } else if (responseType == HttpResponseType.STRING) {
        return response.body;
      } else if (responseType == HttpResponseType.BODY_BYTES) {
        return response.bodyBytes;
      }
    }
  } else {
    if (response.statusCode == 401) {
      throw 'Unauthorized';
    } else if (response.body.isJson()) {
      Map map = jsonDecode(response.body);

      if (map.containsKey(MESSAGE)) {
        throw map[MESSAGE];
      } else {
        throw someThingWentWrong;
      }
    } else {
      throw someThingWentWrong;
    }
  }
}
