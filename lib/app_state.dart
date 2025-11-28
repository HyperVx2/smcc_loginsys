import 'package:flutter/material.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  int _appStatus = 0;
  int get appStatus => _appStatus;
  set appStatus(int value) {
    _appStatus = value;
  }

  bool _scanLock = false;
  bool get scanLock => _scanLock;
  set scanLock(bool value) {
    _scanLock = value;
  }

  int _rfidUID = 0;
  int get rfidUID => _rfidUID;
  set rfidUID(int value) {
    _rfidUID = value;
  }

  String _userID = 'null';
  String get userID => _userID;
  set userID(String value) {
    _userID = value;
  }

  DateTime? _lastScanTimestamp =
      DateTime.fromMillisecondsSinceEpoch(788924700000);
  DateTime? get lastScanTimestamp => _lastScanTimestamp;
  set lastScanTimestamp(DateTime? value) {
    _lastScanTimestamp = value;
  }

  String _cacheRegistrationJSON = '';
  String get cacheRegistrationJSON => _cacheRegistrationJSON;
  set cacheRegistrationJSON(String value) {
    _cacheRegistrationJSON = value;
  }

  String _cacheDirectoryJSON = '';
  String get cacheDirectoryJSON => _cacheDirectoryJSON;
  set cacheDirectoryJSON(String value) {
    _cacheDirectoryJSON = value;
  }

  bool _startupDone = false;
  bool get startupDone => _startupDone;
  set startupDone(bool value) {
    _startupDone = value;
  }
}
