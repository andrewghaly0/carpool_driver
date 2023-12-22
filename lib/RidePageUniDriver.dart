import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'package:intl/intl.dart';

class RidePageUniDriver extends StatefulWidget {
  final String driverName;
  final String carID;
  final String phoneNumber;

  const RidePageUniDriver({
    Key? key,
    required this.driverName,
    required this.carID,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  _RidePageUniDriverState createState() => _RidePageUniDriverState();
}

class _RidePageUniDriverState extends State<RidePageUniDriver> {
  late RidePageUniDriverModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RidePageUniDriverModel());

    _model.fromController = TextEditingController();
    _model.fromFocusNode1 = FocusNode();

    _model.toController = TextEditingController();
    _model.toFocusNode3 = FocusNode();

    _model.priceController = TextEditingController();
    _model.priceFocusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        if (_model.unfocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_model.unfocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          backgroundColor: Color(0xFF19DB8A),
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
            child: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30,
              buttonSize: 60,
              icon: Icon(
                Icons.arrow_back_sharp,
                color: Color(0xFF57636C),
                size: 30,
              ),
              onPressed: () async {
                Navigator.of(context).pushReplacementNamed('HomePageDriver');
              },
            ),
          ),
          title: Text(
            'Post Rides',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
              fontFamily: 'Inter',
              color: Color(0xFF14181B),
              fontSize: 32,
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: SingleChildScrollView(
              child: Form(
                key: _model.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: FlutterFlowCalendar(
                        color: FlutterFlowTheme.of(context).primary,
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        weekFormat: true,
                        weekStartsMonday: false,
                        rowHeight: 64,
                        onChange: (DateTimeRange? newSelectedDate) {
                          setState(() {
                            _model.calendarSelectedDay = newSelectedDate;
                          });
                        },
                        titleStyle:
                        FlutterFlowTheme.of(context).headlineSmall,
                        dayOfWeekStyle:
                        FlutterFlowTheme.of(context).labelLarge,
                        dateStyle: FlutterFlowTheme.of(context).bodyMedium,
                        selectedDateStyle:
                        FlutterFlowTheme.of(context).titleSmall,
                        inactiveDateStyle:
                        FlutterFlowTheme.of(context).labelMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                      child: TextFormField(
                        controller: _model.fromController,
                        focusNode: _model.fromFocusNode1,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'from',
                          hintText: 'Enter location',
                          hintStyle: FlutterFlowTheme.of(context)
                              .bodyLarge
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF14181B),
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF19DB8A),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                          fontFamily: 'Readex Pro',
                          color: Color(0xFF14181B),
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        validator: _model.validateFrom,
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: TextFormField(
                          controller: _model.toController,
                          focusNode: _model.toFocusNode3,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'To',
                            hintText: 'Enter Location',
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF14181B),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF19DB8A),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          validator: _model.validateTo,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: TextFormField(
                          controller: _model.priceController,
                          focusNode: _model.priceFocusNode2,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            hintText: 'Enter price ',
                            hintStyle: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Color(0xFF14181B),
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF19DB8A),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0x00000000),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                            fontFamily: 'Readex Pro',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                          validator: _model.validatePrice,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 1.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                        child: FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState?.validate() ?? false) {
                              // All validations pass, proceed with posting the ride
                              // Access UserData using Provider
                              UserData userData = Provider.of<UserData>(context, listen: false);

                              // Update additional data in the model
                              _model.setDriverInfo(
                                userData.driverName ?? '',
                                userData.carID ?? '',
                                userData.phoneNumber ?? '',
                                _model.fromController?.text ?? '',
                                _model.toController?.text ?? '',
                                _model.priceController?.text ?? '',
                              );

                              // Call the method to post ride details to Firestore
                              await _model.postRideToFirestore();

                              Navigator.of(context).pushReplacementNamed('HomePageDriver');
                            }
                          },
                          text: 'Post Ride',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: Color(0xFF19DB8A),
                            textStyle: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            elevation: 2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class RidePageUniDriverModel extends FlutterFlowModel<RidePageUniDriver> {
  /// State fields for stateful widgets in this page.
  String? driverName;
  String? carID;
  String? phoneNumber;
  DateTimeRange? calendarSelectedDay;
  static const String time = '7:30 AM';

  final unfocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  // State field(s) for TextField widget.
  FocusNode? fromFocusNode1;
  TextEditingController? fromController;

  // State field(s) for TextField widget.
  FocusNode? priceFocusNode2;
  TextEditingController? priceController;

  // State field(s) for TextField widget.
  FocusNode? toFocusNode3;
  TextEditingController? toController;

  /// Validation function for 'from' field.
  String? validateFrom(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a location';
    }
    return null;
  }

  /// Validation function for 'to' field.
  String? validateTo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a location';
    }
    return null;
  }

  /// Validation function for 'price' field.
  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a price';
    }
    // You can add additional validation logic for the price if needed
    return null;
  }

  /// Method to set driver information from signup data.
  void setDriverInfo(String name, String car, String phone, String from, String to, String price) {
    driverName = name;
    carID = car;
    phoneNumber = phone;
    fromController?.text = from;
    toController?.text = to;
    priceController?.text = price;
  }

  Future<void> postRideToFirestore() async {
    try {
      // Check if required data is available
      if (driverName == null || carID == null || phoneNumber == null) {
        print('Driver name, car ID, or phone number is missing.');
        return;
      }

      // Get a reference to the "trips" collection
      final CollectionReference tripsCollection =
      FirebaseFirestore.instance.collection('trips');

      // Format the date as "dd/MM/yyyy"
      String formattedDate =
      DateFormat('dd/MM/yyyy').format(calendarSelectedDay?.start ?? DateTime.now());

      // Add data to the "trips" collection
      await tripsCollection.add({
        'carID': carID, // Use the updated carID
        'driverName': driverName,
        'phoneNumber': phoneNumber,
        'from': fromController?.text,
        'to': toController?.text,
        'price': priceController?.text,
        'time': time,
        'date': formattedDate,
        // Add other fields as needed
      });

      print('Ride details posted to Firestore!');
    } catch (e) {
      // Handle any errors
      print('Error posting ride to Firestore: $e');
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    fromFocusNode1?.dispose();
    fromController?.dispose();

    toFocusNode3?.dispose();
    toController?.dispose();

    priceFocusNode2?.dispose();
    priceController?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
