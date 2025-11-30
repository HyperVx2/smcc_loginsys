import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import 'dart:async';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_widget/barcode_widget.dart';
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

        _model.resulltSiteNewsExt = await GetSiteNewsExtCall.call();

        _model.resulltSiteNewsInt = await GetSiteNewsIntCall.call();

        FFAppState().startupDone = true;
        FFAppState().update(() {});
      } else {
        return;
      }

      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 15000),
        callback: (timer) async {
          if (_model.pageViewCurrentIndex > 2) {
            unawaited(
              () async {
                await _model.pageViewController?.animateToPage(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }(),
            );
          } else {
            unawaited(
              () async {
                await _model.pageViewController?.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }(),
            );
          }
        },
        startImmediately: true,
      );
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
                          sigmaX: 1.0,
                          sigmaY: 1.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1720908675577-76d6a4113a56?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxtb3VudGFpbi1nMzBQMXpjT3pYb3xlbnwwfHx8fDE3NjQ0NjI4ODh8MA&ixlib=rb-4.1.0&q=80&w=1080',
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
                              'https://images.unsplash.com/photo-1720908675577-76d6a4113a56?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxtb3VudGFpbi1nMzBQMXpjT3pYb3xlbnwwfHx8fDE3NjQ0NjI4ODh8MA&ixlib=rb-4.1.0&q=80&w=1080',
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
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Welcome to SMCC',
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
                                                            Text(
                                                              'Entrance Gate',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelLarge
                                                                  .override(
                                                                    font: GoogleFonts
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
                                                          ],
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
                                                                    if (_shouldSetState)
                                                                      safeSetState(
                                                                          () {});
                                                                    return;
                                                                  }

                                                                  FFAppState()
                                                                          .lastScanTimestamp =
                                                                      getCurrentTimestamp;
                                                                  FFAppState()
                                                                      .appStatus = 1;
                                                                  FFAppState()
                                                                      .update(
                                                                          () {});
                                                                  _model.errorCall =
                                                                      '0';
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.gotRfidUser =
                                                                      await RfidUserCall
                                                                          .call(
                                                                    rfidUID: int
                                                                        .tryParse(_model
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
                                                                      FFAppState()
                                                                              .userID =
                                                                          getJsonField(
                                                                        (_model.gotRfidUser?.jsonBody ??
                                                                            ''),
                                                                        r'''$.user_id''',
                                                                      ).toString();
                                                                      FFAppState()
                                                                              .scanLock =
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
                                                                          await GoogleUserCall
                                                                              .call(
                                                                        userKey:
                                                                            FFAppState().userID,
                                                                      );

                                                                      _shouldSetState =
                                                                          true;
                                                                      if ((_model
                                                                              .gotGoogleUser
                                                                              ?.succeeded ??
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
                                                                            (_model.gotGoogleUser?.jsonBody ??
                                                                                ''),
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
                                                                          FFAppState()
                                                                              .update(() {});
                                                                          await Future
                                                                              .delayed(
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
                                                                          safeSetState(
                                                                              () {});
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
                                                                          safeSetState(
                                                                              () {});
                                                                        return;
                                                                      } else {
                                                                        FFAppState()
                                                                            .appStatus = 4;
                                                                        FFAppState()
                                                                            .rfidUID = 0;
                                                                        FFAppState().userID =
                                                                            'null';
                                                                        FFAppState().scanLock =
                                                                            false;
                                                                        safeSetState(
                                                                            () {});
                                                                        _model.errorCall =
                                                                            'errNoGoogleUser';
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
                                                                      FFAppState()
                                                                              .userID =
                                                                          'null';
                                                                      safeSetState(
                                                                          () {});
                                                                      _model.errorCall =
                                                                          'errNoUserId_2';
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
                                                                  } else {
                                                                    FFAppState()
                                                                        .appStatus = 4;
                                                                    FFAppState()
                                                                        .rfidUID = 0;
                                                                    safeSetState(
                                                                        () {});
                                                                    _model.errorCall =
                                                                        'errNoUserId';
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
                                                                  .headlineSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .interTight(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                            FaIcon(
                                                              FontAwesomeIcons
                                                                  .solidClock,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 24.0,
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
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 32.0,
                                                                0.0, 0.0),
                                                    child: Text(
                                                      _model.errorCall,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .robotoMono(
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
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
                                    child: Builder(
                                      builder: (context) {
                                        if ((_model.resulltSiteNewsExt
                                                ?.succeeded ??
                                            true)) {
                                          return Container(
                                            width: double.infinity,
                                            height: 500.0,
                                            child: Stack(
                                              children: [
                                                PageView(
                                                  controller: _model
                                                          .pageViewController ??=
                                                      PageController(
                                                          initialPage: 0),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 415.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    (_model.resulltSiteNewsInt
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$[1].jetpack_featured_media_url''',
                                                                  )?.toString(),
                                                                  'https://smcc.edu.ph/wp-content/uploads/2025/07/IMG_0011_800x533.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0x4D000000),
                                                                  Color(
                                                                      0xCC1A84B8),
                                                                  Color(
                                                                      0xE61A84B8),
                                                                  Color(
                                                                      0xFF1A84B8)
                                                                ],
                                                                stops: [
                                                                  0.4,
                                                                  0.6,
                                                                  0.7,
                                                                  1.0
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                end:
                                                                    AlignmentDirectional(
                                                                        0, 1.0),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                      child:
                                                                          BackdropFilter(
                                                                        filter:
                                                                            ImageFilter.blur(
                                                                          sigmaX:
                                                                              10.0,
                                                                          sigmaY:
                                                                              20.0,
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                              r'''$.items[1].categories''',
                                                                            )?.toString(),
                                                                            'News',
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.category,
                                                                            size:
                                                                                14.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                10.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                Color(0x36FFFFFF),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                10.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x4DFFFFFF),
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              1.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                    r'''$.items[1].title
''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  minFontSize: 14.0,
                                                                                  style: FlutterFlowTheme.of(context).displayMedium.override(
                                                                                        font: GoogleFonts.interTight(
                                                                                          fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.person,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[1].author
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.fade,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.date_range,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[1].pubDate
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.visible,
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: AutoSizeText(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[1].description
''',
                                                                                    ).toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    maxLines: 3,
                                                                                    minFontSize: 20.0,
                                                                                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                          font: GoogleFonts.interTight(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFFE0E3E7),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 3.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                10.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 150.0,
                                                                              height: 150.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xCCFFFFFF),
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                border: Border.all(
                                                                                  color: Color(0x4DFFFFFF),
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(10.0),
                                                                                child: BarcodeWidget(
                                                                                  data: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[1].guid''',
                                                                                    )?.toString(),
                                                                                    'https://smcc.edu.ph/',
                                                                                  ),
                                                                                  barcode: Barcode.qrCode(),
                                                                                  width: 100.0,
                                                                                  height: 100.0,
                                                                                  color: Color(0xFF14181B),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  errorBuilder: (_context, _error) => SizedBox(
                                                                                    width: 100.0,
                                                                                    height: 100.0,
                                                                                  ),
                                                                                  drawText: true,
                                                                                ),
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
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 415.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    (_model.resulltSiteNewsInt
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$[2].jetpack_featured_media_url''',
                                                                  )?.toString(),
                                                                  'https://smcc.edu.ph/wp-content/uploads/2025/07/IMG_0011_800x533.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0x4D000000),
                                                                  Color(
                                                                      0xCC1A84B8),
                                                                  Color(
                                                                      0xE61A84B8),
                                                                  Color(
                                                                      0xFF1A84B8)
                                                                ],
                                                                stops: [
                                                                  0.4,
                                                                  0.6,
                                                                  0.7,
                                                                  1.0
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                end:
                                                                    AlignmentDirectional(
                                                                        0, 1.0),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                      child:
                                                                          BackdropFilter(
                                                                        filter:
                                                                            ImageFilter.blur(
                                                                          sigmaX:
                                                                              10.0,
                                                                          sigmaY:
                                                                              20.0,
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                              r'''$.items[2].categories''',
                                                                            )?.toString(),
                                                                            'News',
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.category,
                                                                            size:
                                                                                14.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                10.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                Color(0x36FFFFFF),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                10.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x4DFFFFFF),
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              1.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                    r'''$.items[2].title
''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  minFontSize: 14.0,
                                                                                  style: FlutterFlowTheme.of(context).displayMedium.override(
                                                                                        font: GoogleFonts.interTight(
                                                                                          fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.person,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[2].author
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.fade,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.date_range,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[2].pubDate
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.visible,
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: AutoSizeText(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[2].description
''',
                                                                                    ).toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    maxLines: 3,
                                                                                    minFontSize: 20.0,
                                                                                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                          font: GoogleFonts.interTight(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFFE0E3E7),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 3.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                10.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 150.0,
                                                                              height: 150.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xCCFFFFFF),
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                border: Border.all(
                                                                                  color: Color(0x4DFFFFFF),
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(10.0),
                                                                                child: BarcodeWidget(
                                                                                  data: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[2].guid''',
                                                                                    )?.toString(),
                                                                                    'https://smcc.edu.ph/',
                                                                                  ),
                                                                                  barcode: Barcode.qrCode(),
                                                                                  width: 100.0,
                                                                                  height: 100.0,
                                                                                  color: Color(0xFF14181B),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  errorBuilder: (_context, _error) => SizedBox(
                                                                                    width: 100.0,
                                                                                    height: 100.0,
                                                                                  ),
                                                                                  drawText: true,
                                                                                ),
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
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height: 415.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    (_model.resulltSiteNewsInt
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$[3].jetpack_featured_media_url''',
                                                                  )?.toString(),
                                                                  'https://smcc.edu.ph/wp-content/uploads/2025/07/IMG_0011_800x533.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0x4D000000),
                                                                  Color(
                                                                      0xCC1A84B8),
                                                                  Color(
                                                                      0xE61A84B8),
                                                                  Color(
                                                                      0xFF1A84B8)
                                                                ],
                                                                stops: [
                                                                  0.4,
                                                                  0.6,
                                                                  0.7,
                                                                  1.0
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                end:
                                                                    AlignmentDirectional(
                                                                        0, 1.0),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                      child:
                                                                          BackdropFilter(
                                                                        filter:
                                                                            ImageFilter.blur(
                                                                          sigmaX:
                                                                              10.0,
                                                                          sigmaY:
                                                                              20.0,
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                              r'''$.items[3].categories''',
                                                                            )?.toString(),
                                                                            'News',
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.category,
                                                                            size:
                                                                                14.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                10.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                Color(0x36FFFFFF),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                10.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x4DFFFFFF),
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              1.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                    r'''$.items[3].title
''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  minFontSize: 14.0,
                                                                                  style: FlutterFlowTheme.of(context).displayMedium.override(
                                                                                        font: GoogleFonts.interTight(
                                                                                          fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.person,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[3].author
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.fade,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.date_range,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[3].pubDate
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.visible,
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: AutoSizeText(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[3].description
''',
                                                                                    ).toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    maxLines: 3,
                                                                                    minFontSize: 20.0,
                                                                                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                          font: GoogleFonts.interTight(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFFE0E3E7),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 3.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                10.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 150.0,
                                                                              height: 150.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xCCFFFFFF),
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                border: Border.all(
                                                                                  color: Color(0x4DFFFFFF),
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(10.0),
                                                                                child: BarcodeWidget(
                                                                                  data: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[3].guid''',
                                                                                    )?.toString(),
                                                                                    'https://smcc.edu.ph/',
                                                                                  ),
                                                                                  barcode: Barcode.qrCode(),
                                                                                  width: 100.0,
                                                                                  height: 100.0,
                                                                                  color: Color(0xFF14181B),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  errorBuilder: (_context, _error) => SizedBox(
                                                                                    width: 100.0,
                                                                                    height: 100.0,
                                                                                  ),
                                                                                  drawText: true,
                                                                                ),
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
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 5.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.0),
                                                        ),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  1.0,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  1.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            image:
                                                                DecorationImage(
                                                              fit: BoxFit.cover,
                                                              image:
                                                                  Image.network(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    (_model.resulltSiteNewsInt
                                                                            ?.jsonBody ??
                                                                        ''),
                                                                    r'''$[0].jetpack_featured_media_url''',
                                                                  )?.toString(),
                                                                  'https://smcc.edu.ph/wp-content/uploads/2025/07/IMG_0011_800x533.jpg',
                                                                ),
                                                              ).image,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              gradient:
                                                                  LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0x4D000000),
                                                                  Color(
                                                                      0xCC1A84B8),
                                                                  Color(
                                                                      0xE61A84B8),
                                                                  Color(
                                                                      0xFF1A84B8)
                                                                ],
                                                                stops: [
                                                                  0.4,
                                                                  0.6,
                                                                  0.7,
                                                                  1.0
                                                                ],
                                                                begin:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                end:
                                                                    AlignmentDirectional(
                                                                        0, 1.0),
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          20.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              24.0),
                                                                      child:
                                                                          BackdropFilter(
                                                                        filter:
                                                                            ImageFilter.blur(
                                                                          sigmaX:
                                                                              10.0,
                                                                          sigmaY:
                                                                              20.0,
                                                                        ),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () {
                                                                            print('Button pressed ...');
                                                                          },
                                                                          text:
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                              r'''$.items[0].categories''',
                                                                            )?.toString(),
                                                                            'News',
                                                                          ),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.category,
                                                                            size:
                                                                                14.0,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                40.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                10.0,
                                                                                0.0,
                                                                                10.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                Color(0x36FFFFFF),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.montserrat(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                10.0,
                                                                            borderSide:
                                                                                BorderSide(
                                                                              color: Color(0x4DFFFFFF),
                                                                              width: 1.0,
                                                                            ),
                                                                            borderRadius:
                                                                                BorderRadius.circular(20.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              1.0),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: AutoSizeText(
                                                                                  getJsonField(
                                                                                    (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                    r'''$.items[0].title
''',
                                                                                  ).toString(),
                                                                                  maxLines: 2,
                                                                                  minFontSize: 14.0,
                                                                                  style: FlutterFlowTheme.of(context).displayMedium.override(
                                                                                        font: GoogleFonts.interTight(
                                                                                          fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).info,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).displayMedium.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).displayMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.person,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[0].author
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.fade,
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.date_range,
                                                                                    color: Color(0xCCFFFFFF),
                                                                                    size: 22.0,
                                                                                  ),
                                                                                  Text(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[0].pubDate
''',
                                                                                    ).toString(),
                                                                                    maxLines: 1,
                                                                                    style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                          font: GoogleFonts.montserrat(
                                                                                            fontWeight: FontWeight.w200,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).info,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w200,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.visible,
                                                                                  ),
                                                                                ].divide(SizedBox(width: 8.0)),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: AutoSizeText(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[0].description
''',
                                                                                    ).toString(),
                                                                                    textAlign: TextAlign.start,
                                                                                    maxLines: 3,
                                                                                    minFontSize: 20.0,
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                          font: GoogleFonts.inter(
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFFDFDFDF),
                                                                                          letterSpacing: 1.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                        ),
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 10.0)).around(SizedBox(height: 10.0)),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              1.0,
                                                                              1.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                10.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(20.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 150.0,
                                                                              height: 150.0,
                                                                              decoration: BoxDecoration(
                                                                                color: Color(0xCCFFFFFF),
                                                                                borderRadius: BorderRadius.circular(20.0),
                                                                                border: Border.all(
                                                                                  color: Color(0x4DFFFFFF),
                                                                                  width: 1.0,
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsets.all(10.0),
                                                                                child: BarcodeWidget(
                                                                                  data: valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      (_model.resulltSiteNewsExt?.jsonBody ?? ''),
                                                                                      r'''$.items[0].guid''',
                                                                                    )?.toString(),
                                                                                    'https://smcc.edu.ph/',
                                                                                  ),
                                                                                  barcode: Barcode.qrCode(),
                                                                                  width: 100.0,
                                                                                  height: 100.0,
                                                                                  color: Color(0xFF14181B),
                                                                                  backgroundColor: Colors.transparent,
                                                                                  errorBuilder: (_context, _error) => SizedBox(
                                                                                    width: 100.0,
                                                                                    height: 100.0,
                                                                                  ),
                                                                                  drawText: true,
                                                                                ),
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
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 1.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 16.0),
                                                    child: smooth_page_indicator
                                                        .SmoothPageIndicator(
                                                      controller: _model
                                                              .pageViewController ??=
                                                          PageController(
                                                              initialPage: 0),
                                                      count: 4,
                                                      axisDirection:
                                                          Axis.horizontal,
                                                      onDotClicked: (i) async {
                                                        await _model
                                                            .pageViewController!
                                                            .animateToPage(
                                                          i,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.ease,
                                                        );
                                                        safeSetState(() {});
                                                      },
                                                      effect:
                                                          smooth_page_indicator
                                                              .SlideEffect(
                                                        spacing: 8.0,
                                                        radius: 8.0,
                                                        dotWidth: 8.0,
                                                        dotHeight: 8.0,
                                                        dotColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        activeDotColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .info,
                                                        paintStyle:
                                                            PaintingStyle.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Icon(
                                            Icons.wifi_off_sharp,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 320.0,
                                          );
                                        }
                                      },
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
