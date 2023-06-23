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


//
//
// Map<String, String> buildHeaderTokens() {
//   Map<String, String> header = {
//     HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
//     HttpHeaders.cacheControlHeader: 'no-cache',
//     HttpHeaders.acceptHeader: 'application/json; charset=utf-8',
//     'Access-Control-Allow-Headers': '*',
//     'Access-Control-Allow-Origin': '*',
//   };
//
//   print(jsonEncode(header));
//   return header;
// }
//
// Uri buildBaseUrl(String endPoint) {
//   Uri url = Uri.parse(endPoint);
//   if (!endPoint.startsWith('http')) url = Uri.parse('$BASE_URL$endPoint');
//
//   print('URL: ${url.toString()}');
//
//   return url;
// }
//
// Future<Response> buildHttpResponse(String endPoint, {HttpMethod method = HttpMethod.GET, Map? request}) async {
//   if (await isNetworkAvailable()) {
//     var headers = buildHeaderTokens();
//     Uri url = buildBaseUrl(endPoint);
//
//     Response response;
//
//     if (method == HttpMethod.POST) {
//       print('Request: $request');
//       response = await http.post(url, body: jsonEncode(request), headers: headers);
//     } else if (method == HttpMethod.DELETE) {
//       response = await delete(url, headers: headers);
//     } else if (method == HttpMethod.PUT) {
//       response = await put(url, body: jsonEncode(request), headers: headers);
//     } else {
//       response = await get(url, headers: headers);
//     }
//
//     print('Response ($method): ${response.statusCode} ${response.body}');
//
//     return response;
//   } else {
//     throw "errorInternetNotAvailable";
//   }
// }
//
// @deprecated
// Future<Response> getRequest(String endPoint) async => buildHttpResponse(endPoint);
//
// @deprecated
// Future<Response> postRequest(String endPoint, Map request) async => buildHttpResponse(endPoint, request: request, method: HttpMethod.POST);
//
// Future handleResponse(Response response) async {
//   if (!await isNetworkAvailable()) {
//     throw "Internet not available";
//   }
//
//   if (response.statusCode.isSuccessful()) {
//     return jsonDecode(response.body);
//   } else {
//     var string = await (isJsonValid(response.body));
//     if (string!.isNotEmpty) {
//       throw string;
//     } else {
//       throw 'Please try again later.';
//     }
//   }
// }
//
// //region Common
// enum HttpMethod { GET, POST, DELETE, PUT }
//
// class TokenException implements Exception {
//   final String message;
//
//   const TokenException([this.message = ""]);
//
//   String toString() => "FormatException: $message";
// }
// //endregion
//
// Future<String?> isJsonValid(json) async {
//   try {
//     var f = jsonDecode(json) as Map<String, dynamic>;
//     return f["msg"];
//   } catch (e) {
//     print(e.toString());
//     return "";
//   }
// }

