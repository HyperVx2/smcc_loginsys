import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class RfidUserListCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'rfidUserList',
      apiUrl: 'http://lonita.duckdns.org:8980/api/attendance_db/rfid/users',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class RfidUserCall {
  static Future<ApiCallResponse> call({
    int? rfidUID,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'rfidUser',
      apiUrl:
          'http://lonita.duckdns.org:8980/api/attendance_db/rfid/${rfidUID}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? userID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.user_id''',
      ));
  static String? rfidUID(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.rfid_uid''',
      ));
}

class GoogleUserListCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'googleUserList',
      apiUrl: 'http://lonita.duckdns.org:8980/api/attendance_db/google/users',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: true,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GoogleUserCall {
  static Future<ApiCallResponse> call({
    String? userKey = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'googleUser',
      apiUrl:
          'http://lonita.duckdns.org:8980/api/attendance_db/google/users/${userKey}',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? department(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.department''',
      ));
  static String? familyName(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.familyName''',
      ));
  static String? givenName(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.givenName''',
      ));
  static String? orgDescription(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.orgDescription''',
      ));
  static String? primaryEmail(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.primaryEmail''',
      ));
}

class GoogleUserPhotoCall {
  static Future<ApiCallResponse> call({
    String? userKey = 'C240076',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'googleUserPhoto',
      apiUrl:
          'http://lonita.duckdns.org:8980/api/attendance_db/google/users/${userKey}/photo',
      callType: ApiCallType.GET,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {
        'source': "live",
        'datauri': false,
        'format': "base64",
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? photoUrl(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.photoUrl''',
      ));
  static String? mimeType(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.mimeType''',
      ));
  static String? photoBase64(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.photoBase64''',
      ));
}

class AttendanceLogCall {
  static Future<ApiCallResponse> call({
    String? userID = '',
    String? primaryEmail = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userID": "${escapeStringForJson(userID)}",
  "primaryEmail": "${escapeStringForJson(primaryEmail)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'attendanceLog',
      apiUrl: 'http://lonita.duckdns.org:8980/api/attendance_db/attendance/log',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Basic bG9naW5zeXM6Zm9vYmFyMTIz',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
