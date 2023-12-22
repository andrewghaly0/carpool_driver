import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'LoginPageDriver.dart';
import 'RidePageUniDriver.dart';



class SignupPageDriver extends StatefulWidget {
  const SignupPageDriver({Key? key}) : super(key: key);

  @override
  _SignupPageDriverState createState() => _SignupPageDriverState();
}

class _SignupPageDriverState extends State<SignupPageDriver> {
  late SignupPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignupPageModel());

    _model.emailAddressDriverController ??= TextEditingController();
    _model.emailAddressDriverFocusNode ??= FocusNode();

    _model.fullNameDriverController ??= TextEditingController();
    _model.fullNameDriverFocusNode ??= FocusNode();

    _model.phoneNumberDriverController ??= TextEditingController();
    _model.phoneNumberDriverFocusNode ??= FocusNode();

    _model.carIDController ??= TextEditingController();
    _model.carIDFocusNode ??= FocusNode();

    _model.passwordController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    _model.passwordConfirmController ??= TextEditingController();
    _model.passwordConfirmFocusNode ??= FocusNode();
  }

  Future<void> createUserInFirestore(String driverEmail, String driverName, String driverPhone, String carID) async {
    final driver = FirebaseAuth.instance.currentUser;
    if (driver != null) {
      // Create a driver document in Firestore
      await FirebaseFirestore.instance.collection('drivers').doc(driver.uid).set({
        'driverEmail': driverEmail,
        'driverName': driverName,
        'driverPhone': driverPhone,
        'carID': carID,
        // Add other user data fields as needed
      });
    }
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF19DB8A),
        body: SafeArea(
          top: true,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  width: 100,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  alignment: AlignmentDirectional(0.00, -1.00),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 140,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          alignment: AlignmentDirectional(-1.00, 0.00),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.00, 0.00),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(32, 32, 32, 32),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create an account',
                                  style:
                                  FlutterFlowTheme.of(context).displaySmall,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 24),
                                  child: Text(
                                    'Let\'s get started by filling out the form below.',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.emailAddressDriverController,
                                      focusNode: _model.emailAddressDriverFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.email],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: _model
                                          .emailAddressDriverControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.fullNameDriverController,
                                      focusNode: _model.fullNameDriverFocusNode,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                        hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                      validator: _model.fullNameDriverControllerValidator.asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.phoneNumberDriverController,
                                      focusNode: _model.phoneNumberDriverFocusNode,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Phone Number',
                                        labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                        hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                      validator: _model.phoneNumberDriverControllerValidator.asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.carIDController,
                                      focusNode: _model.carIDFocusNode,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Car ID',
                                        labelStyle: FlutterFlowTheme.of(context).labelMedium,
                                        hintStyle: FlutterFlowTheme.of(context).labelMedium,
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).alternate,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).primary,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedErrorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context).error,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                      ),
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                      validator: _model.carIDControllerValidator.asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller: _model.passwordController,
                                      focusNode: _model.passwordFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.password],
                                      obscureText: !_model.passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                                () => _model.passwordVisibility =
                                            !_model.passwordVisibility,
                                          ),
                                          focusNode:
                                          FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                      validator: _model
                                          .passwordControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: Container(
                                    width: 370,
                                    child: TextFormField(
                                      controller:
                                      _model.passwordConfirmController,
                                      focusNode:
                                      _model.passwordConfirmFocusNode,
                                      autofocus: true,
                                      autofillHints: [AutofillHints.password],
                                      obscureText:
                                      !_model.passwordConfirmVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 2,
                                          ),
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                                () => _model
                                                .passwordConfirmVisibility =
                                            !_model
                                                .passwordConfirmVisibility,
                                          ),
                                          focusNode:
                                          FocusNode(skipTraversal: true),
                                          child: Icon(
                                            _model.passwordConfirmVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium,
                                      minLines: 1,
                                      validator: _model
                                          .passwordConfirmControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 16),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.passwordController.text != _model.passwordConfirmController.text) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Passwords don\'t match!'),
                                          ),
                                        );
                                        return;
                                      }

                                      try {
                                        // Create user in Firebase Authentication
                                        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                          email: _model.emailAddressDriverController.text,
                                          password: _model.passwordController.text,

                                        );


                                        // Check if user creation is successful
                                        if (userCredential.user != null) {
                                          // Store additional user data in Firestore
                                          await FirebaseFirestore.instance.collection('drivers').doc(userCredential.user!.uid).set({
                                            'driverEmail': _model.emailAddressDriverController.text,
                                            'driverName': _model.fullNameDriverController.text,
                                            'driverPhone': _model.phoneNumberDriverController.text,
                                            'carID': _model.carIDController.text,
                                            // Add other driver data fields as needed
                                          });
                                         final UserData userData = Provider.of<UserData>(context, listen: false);
                                          // Update user data
                                          userData.setUserData(
                                            _model.fullNameDriverController.text,
                                            _model.carIDController.text,
                                            _model.phoneNumberDriverController.text,
                                          );

                                          // Navigate to the home page or any other page after successful signup
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => RidePageUniDriver(
                                                driverName: _model.fullNameDriverController.text,
                                                carID: _model.carIDController.text,
                                                phoneNumber: _model.phoneNumberDriverController.text,
                                              ),
                                            ),
                                          );
                                          Navigator.of(context).pushReplacementNamed('LoginPageDriver');
                                        }
                                      } catch (error) {
                                        print('Error during user creation: $error');
                                        // Handle error, e.g., show error message to the user
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Error creating user. Please try again.'),
                                          ),
                                        );
                                      }
                                    },


                                    text: 'Create Account',
                                    options: FFButtonOptions(
                                      width: 370,
                                      height: 44,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      iconPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      color:
                                      FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                      ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),

                                // You will have to add an action on this rich text to go to your login page.
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 12, 0, 12),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPageDriver()));

                                    },
                                    child: RichText(
                                      textScaleFactor: MediaQuery.of(context)
                                          .textScaleFactor,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Already have an account? ',
                                            style: TextStyle(),
                                          ),
                                          TextSpan(
                                            text: 'Sign In here',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Readex Pro',
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                        style: FlutterFlowTheme.of(context)
                                            .labelLarge,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                    child: Container(
                      width: 100,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,

                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
class SignupPageModel extends FlutterFlowModel<SignupPageDriver> {
  /// State fields for stateful widgets in this page.
  String? driverName;
  String? carID;
  String? phoneNumber;

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressDriverFocusNode;
  TextEditingController? emailAddressDriverController;
  String? Function(BuildContext, String?)?
  emailAddressDriverControllerValidator;
  // State field(s) for FullName widget.
  FocusNode? fullNameDriverFocusNode;
  TextEditingController? fullNameDriverController;
  String? Function(BuildContext, String?)? fullNameDriverControllerValidator;
  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberDriverFocusNode;
  TextEditingController? phoneNumberDriverController;
  String? Function(BuildContext, String?)?
  phoneNumberDriverControllerValidator;
  // State field(s) for carID widget.
  FocusNode? carIDFocusNode;
  TextEditingController? carIDController;
  String? Function(BuildContext, String?)? carIDControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordControllerValidator;
  // State field(s) for passwordConfirm widget.
  FocusNode? passwordConfirmFocusNode;
  TextEditingController? passwordConfirmController;
  late bool passwordConfirmVisibility;
  String? Function(BuildContext, String?)?
  passwordConfirmControllerValidator;

  /// Method to set driver information from signup data.
  void setDriverInfo(String name, String car, String phone) {
    driverName = name;
    carID = car;
    phoneNumber = phone;
  }

  /// Initialization and disposal methods.
  void initState(BuildContext context) {
    passwordVisibility = false;
    passwordConfirmVisibility = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressDriverFocusNode?.dispose();
    emailAddressDriverController?.dispose();

    fullNameDriverFocusNode?.dispose();
    fullNameDriverController?.dispose();

    phoneNumberDriverFocusNode?.dispose();
    phoneNumberDriverController?.dispose();

    carIDFocusNode?.dispose();
    carIDController?.dispose();

    passwordFocusNode?.dispose();
    passwordController?.dispose();

    passwordConfirmFocusNode?.dispose();
    passwordConfirmController?.dispose();
  }

/// Action blocks are added here.

/// Additional helper methods are added here.
}
