import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (!FFAppState().startupDone) {
        _model.resultRFIDList = await RfidUserListCall.call();

        if ((_model.resultRFIDList?.succeeded ?? true)) {
          FFAppState().cacheRegistrationJSON =
              (_model.resultRFIDList?.jsonBody ?? '').toString();
          safeSetState(() {});
        } else {
          FFAppState().cacheRegistrationJSON = '0';
          safeSetState(() {});
        }

        _model.resultGoogleList = await GoogleUserListCall.call();

        if ((_model.resultGoogleList?.succeeded ?? true)) {
          FFAppState().cacheRegistrationJSON =
              (_model.resultGoogleList?.jsonBody ?? '').toString();
          safeSetState(() {});
        } else {
          FFAppState().cacheRegistrationJSON = '0';
          safeSetState(() {});
        }

        FFAppState().startupDone = true;
        FFAppState().update(() {});
      } else {
        return;
      }
    });

    _model.fieldUserRFIDTextController ??= TextEditingController();
    _model.fieldUserRFIDFocusNode ??= FocusNode();
    _model.fieldUserRFIDFocusNode!.addListener(
      () async {
        safeSetState(() {
          _model.fieldUserRFIDTextController?.clear();
        });
        safeSetState(() {
          _model.fieldUserRFIDTextController?.text = '';
          _model.fieldUserRFIDFocusNode?.requestFocus();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _model.fieldUserRFIDTextController?.selection =
                TextSelection.collapsed(
              offset: _model.fieldUserRFIDTextController!.text.length,
            );
          });
        });
      },
    );
    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Builder(
            builder: (context) {
              if (!FFAppState().startupDone) {
                return Stack(
                  children: [
                    ClipRect(
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: 3.0,
                          sigmaY: 3.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://picsum.photos/seed/251/600',
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.64,
                          height: MediaQuery.sizeOf(context).height * 0.64,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.account_box,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 128.0,
                              ),
                              Text(
                                'Starting...',
                                style: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelLarge
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(height: 32.0)),
                          ),
                        ).animateOnPageLoad(
                            animationsMap['containerOnPageLoadAnimation']!),
                      ),
                    ),
                  ],
                );
              } else if (FFAppState().startupDone) {
                return Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Stack(
                    children: [
                      ClipRect(
                        child: ImageFiltered(
                          imageFilter: ImageFilter.blur(
                            sigmaX: 1.0,
                            sigmaY: 1.0,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://picsum.photos/seed/251/600',
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.98,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.12,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(24.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-1.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.5,
                                                  height: 100.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(32.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/st-marys-college-of-catbalogan-inc-logo_illustration_x4.png',
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.09,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Hello, Welcome to SMCC!',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .displaySmall
                                                              .override(
                                                                font: GoogleFonts
                                                                    .interTight(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .displaySmall
                                                                      .fontStyle,
                                                                ),
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .displaySmall
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 16.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 0.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.4,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          1.0,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            28.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                32.0,
                                                                16.0,
                                                                32.0,
                                                                16.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Expanded(
                                                          child: Opacity(
                                                            opacity: 0.0,
                                                            child: Container(
                                                              width: 200.0,
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .fieldUserRFIDTextController,
                                                                focusNode: _model
                                                                    .fieldUserRFIDFocusNode,
                                                                onFieldSubmitted:
                                                                    (_) async {
                                                                  var _shouldSetState =
                                                                      false;
                                                                  if (FFAppState()
                                                                      .scanLock) {
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                    return;
                                                                  }

                                                                  FFAppState()
                                                                          .rfidUID =
                                                                      int.parse(_model
                                                                          .fieldUserRFIDTextController
                                                                          .text);
                                                                  safeSetState(
                                                                      () {});
                                                                  if (getCurrentTimestamp
                                                                              .millisecondsSinceEpoch -
                                                                          FFAppState()
                                                                              .lastScanTimestamp!
                                                                              .millisecondsSinceEpoch <
                                                                      2000) {
                                                                    FFAppState()
                                                                        .appStatus = -1;
                                                                    safeSetState(
                                                                        () {});
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                    return;
                                                                  } else {
                                                                    FFAppState()
                                                                            .lastScanTimestamp =
                                                                        getCurrentTimestamp;
                                                                    FFAppState()
                                                                        .appStatus = 1;
                                                                    FFAppState()
                                                                        .update(
                                                                            () {});
                                                                    _model.gotRfidUser =
                                                                        await RfidUserCall
                                                                            .call(
                                                                      rfidUID: int.tryParse(_model
                                                                          .fieldUserRFIDTextController
                                                                          .text),
                                                                    );

                                                                    _shouldSetState =
                                                                        true;
                                                                    if ((_model
                                                                            .gotRfidUser
                                                                            ?.succeeded ??
                                                                        true)) {
                                                                      if (getJsonField(
                                                                            (_model.gotRfidUser?.jsonBody ??
                                                                                ''),
                                                                            r'''$.rfid_uid''',
                                                                          ) !=
                                                                          null) {
                                                                        FFAppState().userID =
                                                                            getJsonField(
                                                                          (_model.gotRfidUser?.jsonBody ??
                                                                              ''),
                                                                          r'''$.user_id''',
                                                                        ).toString();
                                                                        FFAppState().scanLock =
                                                                            true;
                                                                        safeSetState(
                                                                            () {});
                                                                        _model.displayGivenName =
                                                                            'null';
                                                                        _model.displayDepartment =
                                                                            'null';
                                                                        _model.displayOrgDescription =
                                                                            'null';
                                                                        _model.displayFamilyName =
                                                                            'localFamilyName';
                                                                        safeSetState(
                                                                            () {});
                                                                        _model.gotGoogleUser =
                                                                            await GoogleUserCall.call(
                                                                          userKey:
                                                                              FFAppState().userID,
                                                                        );

                                                                        _shouldSetState =
                                                                            true;
                                                                        if ((_model.gotGoogleUser?.succeeded ??
                                                                            true)) {
                                                                          _model.displayGivenName =
                                                                              getJsonField(
                                                                            (_model.gotGoogleUser?.jsonBody ??
                                                                                ''),
                                                                            r'''$.givenName''',
                                                                          ).toString();
                                                                          _model.displayDepartment =
                                                                              getJsonField(
                                                                            (_model.gotGoogleUser?.jsonBody ??
                                                                                ''),
                                                                            r'''$.department''',
                                                                          ).toString();
                                                                          _model.displayOrgDescription =
                                                                              getJsonField(
                                                                            (_model.gotGoogleUser?.jsonBody ??
                                                                                ''),
                                                                            r'''$.orgDescription''',
                                                                          ).toString();
                                                                          _model.displayFamilyName =
                                                                              getJsonField(
                                                                            (_model.gotGoogleUser?.jsonBody ??
                                                                                ''),
                                                                            r'''$.familyName''',
                                                                          ).toString();
                                                                          safeSetState(
                                                                              () {});
                                                                          _model.userAttendanceLog =
                                                                              await AttendanceLogCall.call(
                                                                            userID:
                                                                                FFAppState().userID,
                                                                            primaryEmail:
                                                                                getJsonField(
                                                                              (_model.gotGoogleUser?.jsonBody ?? ''),
                                                                              r'''$.primaryEmail''',
                                                                            ).toString(),
                                                                          );

                                                                          _shouldSetState =
                                                                              true;
                                                                          if ((_model.userAttendanceLog?.succeeded ??
                                                                              true)) {
                                                                            FFAppState().appStatus =
                                                                                2;
                                                                            FFAppState().scanLock =
                                                                                false;
                                                                            FFAppState().update(() {});
                                                                            await Future.delayed(
                                                                              Duration(
                                                                                milliseconds: 4000,
                                                                              ),
                                                                            );
                                                                            FFAppState().appStatus =
                                                                                0;
                                                                            FFAppState().rfidUID =
                                                                                0;
                                                                            FFAppState().userID =
                                                                                'null';
                                                                            safeSetState(() {});
                                                                          } else {
                                                                            FFAppState().appStatus =
                                                                                4;
                                                                            FFAppState().rfidUID =
                                                                                0;
                                                                            FFAppState().userID =
                                                                                'null';
                                                                            FFAppState().scanLock =
                                                                                false;
                                                                            safeSetState(() {});
                                                                            unawaited(
                                                                              () async {
                                                                                await showDialog(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                    return AlertDialog(
                                                                                      title: Text('userAttendanceLog Status'),
                                                                                      content: Text('userAttendanceLog failed'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                          child: Text('Ok'),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  },
                                                                                );
                                                                              }(),
                                                                            );
                                                                          }

                                                                          if (_shouldSetState)
                                                                            safeSetState(() {});
                                                                          return;
                                                                        } else {
                                                                          FFAppState().appStatus =
                                                                              4;
                                                                          FFAppState().rfidUID =
                                                                              0;
                                                                          FFAppState().userID =
                                                                              'null';
                                                                          FFAppState().scanLock =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                          await Future
                                                                              .delayed(
                                                                            Duration(
                                                                              milliseconds: 4000,
                                                                            ),
                                                                          );
                                                                          FFAppState().appStatus =
                                                                              0;
                                                                          FFAppState()
                                                                              .update(() {});
                                                                          if (_shouldSetState)
                                                                            safeSetState(() {});
                                                                          return;
                                                                        }
                                                                      } else {
                                                                        FFAppState()
                                                                            .appStatus = 4;
                                                                        FFAppState()
                                                                            .rfidUID = 0;
                                                                        FFAppState().userID =
                                                                            'null';
                                                                        safeSetState(
                                                                            () {});
                                                                        await Future
                                                                            .delayed(
                                                                          Duration(
                                                                            milliseconds:
                                                                                4000,
                                                                          ),
                                                                        );
                                                                        FFAppState()
                                                                            .appStatus = 0;
                                                                        FFAppState()
                                                                            .update(() {});
                                                                        if (_shouldSetState)
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      }
                                                                    } else {
                                                                      FFAppState()
                                                                          .appStatus = 4;
                                                                      FFAppState()
                                                                          .rfidUID = 0;
                                                                      safeSetState(
                                                                          () {});
                                                                      await Future
                                                                          .delayed(
                                                                        Duration(
                                                                          milliseconds:
                                                                              4000,
                                                                        ),
                                                                      );
                                                                      FFAppState()
                                                                          .appStatus = 0;
                                                                      FFAppState()
                                                                          .update(
                                                                              () {});
                                                                      if (_shouldSetState)
                                                                        safeSetState(
                                                                            () {});
                                                                      return;
                                                                    }
                                                                  }

                                                                  if (_shouldSetState)
                                                                    safeSetState(
                                                                        () {});
                                                                },
                                                                autofocus: true,
                                                                enabled: true,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  isDense: true,
                                                                  labelText:
                                                                      'rfid_uid',
                                                                  hintText:
                                                                      '0000000000',
                                                                  hintStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodySmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .fontStyle,
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                maxLength: 10,
                                                                maxLengthEnforcement:
                                                                    MaxLengthEnforcement
                                                                        .enforced,
                                                                buildCounter: (context,
                                                                        {required currentLength,
                                                                        required isFocused,
                                                                        maxLength}) =>
                                                                    null,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                cursorColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                enableInteractiveSelection:
                                                                    true,
                                                                validator: _model
                                                                    .fieldUserRFIDTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                                inputFormatters: [
                                                                  FilteringTextInputFormatter
                                                                      .allow(RegExp(
                                                                          '[0-9]'))
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              '${dateTimeFormat("yMMMd", getCurrentTimestamp)} ${dateTimeFormat("Hm", getCurrentTimestamp)}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .headlineMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidClock,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 32.0,
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 16.0)),
                                                        ),
                                                      ].divide(SizedBox(
                                                          width: 18.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.8,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        if (FFAppState().appStatus == 0) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Opacity(
                                                opacity: 0.0,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: custom_widgets
                                                      .CircularPercentWidget(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.03,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.03,
                                                    percent: 100,
                                                    milliseconds: 4000,
                                                    sliderWidth: 8.0,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                    inactiveColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent4,
                                                    fontSize: 1.0,
                                                    fontColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.assignment_ind,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 254.0,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Ready to Scan',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .displayMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Approach the Scanner',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 22.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ].divide(SizedBox(height: 64.0)),
                                          );
                                        } else if (FFAppState().appStatus ==
                                            1) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Opacity(
                                                opacity: 0.0,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          1.0, -1.0),
                                                  child: custom_widgets
                                                      .CircularPercentWidget(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.03,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.03,
                                                    percent: 100,
                                                    milliseconds: 4000,
                                                    sliderWidth: 8.0,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                    inactiveColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent4,
                                                    fontSize: 1.0,
                                                    fontColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/system-solid-42-search-hover-pinch.gif',
                                                  height: 200.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    'Searching...',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .displayMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ].divide(SizedBox(height: 64.0)),
                                          );
                                        } else if (FFAppState().appStatus ==
                                            2) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 16.0, 0.0),
                                                  child: custom_widgets
                                                      .CircularPercentWidget(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.03,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.03,
                                                    percent: 100,
                                                    milliseconds: 4000,
                                                    sliderWidth: 8.0,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                    inactiveColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent4,
                                                    fontSize: 1.0,
                                                    fontColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.asset(
                                                  'assets/images/system-solid-31-check-in-reveal.gif',
                                                  width: 200.0,
                                                  height: 200.0,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      'Hello, ${valueOrDefault<String>(
                                                        _model.displayGivenName,
                                                        'MissingNo',
                                                      )}!',
                                                      'Hello!',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .displayMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${_model.displayGivenName} ${_model.displayFamilyName}',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 22.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    '${_model.displayOrgDescription} • ${_model.displayDepartment}',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 22.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 32.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      'Your attendance has been logged.',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelLarge
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelLarge
                                                                      .fontStyle,
                                                                ),
                                                                fontSize: 22.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                              ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ].divide(SizedBox(height: 64.0)),
                                          );
                                        } else if (FFAppState().appStatus ==
                                            4) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, -1.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 16.0, 16.0, 0.0),
                                                  child: custom_widgets
                                                      .CircularPercentWidget(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.03,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.03,
                                                    percent: 100,
                                                    milliseconds: 4000,
                                                    sliderWidth: 8.0,
                                                    activeColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .success,
                                                    inactiveColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .accent4,
                                                    fontSize: 1.0,
                                                    fontColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                ),
                                              ),
                                              Icon(
                                                Icons.close,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .error,
                                                size: 254.0,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Text(
                                                    '404: ID Not Found',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .displayMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .interTight(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .displayMedium
                                                                    .fontStyle,
                                                          ),
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .displayMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                  Text(
                                                    'Please ask the IT In-Charge for assistance.',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .labelLarge
                                                        .override(
                                                          font:
                                                              GoogleFonts.inter(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelLarge
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 22.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ].divide(SizedBox(height: 8.0)),
                                              ),
                                            ].divide(SizedBox(height: 64.0)),
                                          );
                                        } else {
                                          return Icon(
                                            Icons.question_mark,
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            size: 128.0,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 8.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.66,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.8,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(24.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.globe,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 254.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ].divide(SizedBox(width: 32.0)),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ],
                  ),
                );
              } else {
                return Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Icon(
                    Icons.code_off,
                    color: FlutterFlowTheme.of(context).error,
                    size: 64.0,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
