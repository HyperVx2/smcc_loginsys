import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
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

  int? pageController = 0;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (rfidUserList)] action in HomePage widget.
  ApiCallResponse? resultRFIDList;
  // Stores action output result for [Backend Call - API (googleUserList)] action in HomePage widget.
  ApiCallResponse? resultGoogleList;
  // Stores action output result for [Backend Call - API (getSiteNewsExt)] action in HomePage widget.
  ApiCallResponse? resulltSiteNewsExt;
  // Stores action output result for [Backend Call - API (getSiteNewsInt)] action in HomePage widget.
  ApiCallResponse? resulltSiteNewsInt;
  InstantTimer? instantTimer;
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
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    instantTimer?.cancel();
    fieldUserRFIDFocusNode?.dispose();
    fieldUserRFIDTextController?.dispose();
  }
}
