import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  String displayGivenName = 'null';

  String displayDepartment = 'null';

  String displayOrgDescription = 'null';

  String displayFamilyName = 'localFamilyName';

  /// Get which step error occured.
  String errorCall = '0';

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (rfidUserList)] action in HomePage widget.
  ApiCallResponse? resultRFIDList;
  // Stores action output result for [Backend Call - API (googleUserList)] action in HomePage widget.
  ApiCallResponse? resultGoogleList;
  // State field(s) for fieldUserRFID widget.
  FocusNode? fieldUserRFIDFocusNode;
  TextEditingController? fieldUserRFIDTextController;
  String? Function(BuildContext, String?)? fieldUserRFIDTextControllerValidator;
  // Stores action output result for [Backend Call - API (rfidUser)] action in fieldUserRFID widget.
  ApiCallResponse? gotRfidUser;
  // Stores action output result for [Backend Call - API (googleUser)] action in fieldUserRFID widget.
  ApiCallResponse? gotGoogleUser;
  // Stores action output result for [Backend Call - API (attendanceLog)] action in fieldUserRFID widget.
  ApiCallResponse? userAttendanceLog;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    fieldUserRFIDFocusNode?.dispose();
    fieldUserRFIDTextController?.dispose();
  }
}
