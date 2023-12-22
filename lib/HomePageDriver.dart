import 'package:carpool_project_driver/DriverRidesPage.dart';
import 'package:carpool_project_driver/HistoryPageDriver.dart';
import 'package:carpool_project_driver/RidePageHomeDriver.dart';
import 'package:carpool_project_driver/RidePageUniDriver.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'HomeRequestsPageDriver.dart';
import 'UniRequestsPageDriver.dart';
import 'WelcomePageDriver.dart';


class HomePageDriver extends StatefulWidget {
  const HomePageDriver({Key? key}) : super(key: key);

  @override
  _HomePageDriverState createState() => _HomePageDriverState();
}

class _HomePageDriverState extends State<HomePageDriver> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel(); // Initialize the model here
    // Call fetchUserDetails here to ensure data is available
    _model.fetchUserDetails();
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

    return ChangeNotifierProvider(
      create: (context) => _model,
      child: Consumer<HomePageModel>(
        builder: (context, model, _) {
          return GestureDetector(
            onTap: () => model.unfocusNode.canRequestFocus
                ? FocusScope.of(context).requestFocus(model.unfocusNode)
                : FocusScope.of(context).unfocus(),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: Colors.white,
              drawer: Drawer(
                elevation: 16,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 12, 0, 8),
                            child: Text(
                              'Account Options',
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xFF57636C),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(12, 8, 12, 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        model.userName ?? 'noName',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          color: Color(0xFF14181B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 4, 0, 0),
                                        child: Text(
                                          model.userEmail ?? 'noMail',
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF4B39EF),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFE0E3E7),
                          ),
                          MouseRegion(
                            opaque: false,
                            cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered3!
                                    ? Color(0xFFF1F4F8)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => UniRequestsPageDriver()));

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Icon(
                                          Icons.call_received_outlined,
                                          color: Color(0xFF14181B),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Text(
                                            'Requests to Uni',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF14181B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onEnter: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = true);
                            }),
                            onExit: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = false);
                            }),
                          ),
                          MouseRegion(
                            opaque: false,
                            cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered3!
                                    ? Color(0xFFF1F4F8)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeRequestsPageDriver()));

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Icon(
                                          Icons.call_received_outlined,
                                          color: Color(0xFF14181B),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Text(
                                            'Requests to Home',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF14181B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onEnter: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = true);
                            }),
                            onExit: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = false);
                            }),
                          ),
                          MouseRegion(
                            opaque: false,
                            cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered3!
                                    ? Color(0xFFF1F4F8)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DriverRidesPage()));

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Icon(
                                          Icons.directions_car_filled,
                                          color: Color(0xFF14181B),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Text(
                                            'Rides',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF14181B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onEnter: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = true);
                            }),
                            onExit: ((event) async {
                              setState(() => _model.mouseRegionHovered3 = false);
                            }),
                          ),
                          MouseRegion(
                            opaque: false,
                            cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered4!
                                    ? Color(0xFFF1F4F8)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryPageDriver()));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: Icon(
                                          Icons.history,
                                          color: Color(0xFF14181B),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              12, 0, 0, 0),
                                          child: Text(
                                            'History',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF14181B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onEnter: ((event) async {
                              setState(() => _model.mouseRegionHovered4 = true);
                            }),
                            onExit: ((event) async {
                              setState(() => _model.mouseRegionHovered4 = false);
                            }),
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFE0E3E7),
                          ),
                          MouseRegion(
                            opaque: false,
                            cursor: SystemMouseCursors.click ?? MouseCursor.defer,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: _model.mouseRegionHovered5!
                                    ? Color(0xFFF1F4F8)
                                    : Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    // Log out the user
                                    await FirebaseAuth.instance.signOut();

                                    // Navigate to the WelcomePage after logout
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomePageDriver()));
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                          12,
                                          0,
                                          0,
                                          0,
                                        ),
                                        child: Icon(
                                          Icons.login_rounded,
                                          color: Color(0xFF14181B),
                                          size: 20,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                            12,
                                            0,
                                            0,
                                            0,
                                          ),
                                          child: Text(
                                            'Log out',
                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFF14181B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onEnter: ((event) async {
                              setState(() => _model.mouseRegionHovered5 = true);
                            }),
                            onExit: ((event) async {
                              setState(() => _model.mouseRegionHovered5 = false);
                            }),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  backgroundColor: Color(0xFF19DB8A),
                  automaticallyImplyLeading: false,
                  actions: [],
                  elevation: 2,
                ),
              ),
              body: SafeArea(
                top: true,
                child: SingleChildScrollView(
                 child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.00, -1.00),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: Icon(
                          Icons.menu_rounded,
                          color: Color(0xFF080000),
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RidePageUniDriver(driverName: '', carID: '', phoneNumber: '',)));
                        },
                        text: 'To University',
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 40,
                        ),
                        options: FFButtonOptions(
                          width: 1000,
                          height: 70,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF19DB8A),
                          textStyle: FlutterFlowTheme.of(context).headlineLarge,
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RidePageHomeDriver(driverName: '', carID: '', phoneNumber: '',)));
                        },
                        text: 'Back Home',
                        icon: Icon(
                          Icons.arrow_back,
                          size: 40,
                        ),
                        options: FFButtonOptions(
                          width: 1000,
                          height: 70,
                          padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: Color(0xFF19DB8A),
                          textStyle: FlutterFlowTheme.of(context).headlineLarge,
                          elevation: 3,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          );
        },
      ),
    );
  }
}

class HomePageModel with ChangeNotifier {
  late String userName = 'No Name';
  late String userEmail = 'No Email';

  final unfocusNode = FocusNode();

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  bool mouseRegionHovered2 = false;
  bool mouseRegionHovered3 = false;
  bool mouseRegionHovered4 = false;
  bool mouseRegionHovered5 = false;

  HomePageModel() {
    // Fetch user details on initialization
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('drivers')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          userName = userDoc['driverName'];
          userEmail = userDoc['driverEmail'];
        } else {
          // Handle missing document
          print('User document not found for UID: ${user.uid}');
          userName = 'No Name';
          userEmail = 'No Email';
        }

        notifyListeners();
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  void dispose() {
    unfocusNode.dispose();
  }
}
