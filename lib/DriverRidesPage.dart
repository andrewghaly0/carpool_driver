import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DriverRidesPage extends StatefulWidget {
  const DriverRidesPage({Key? key}) : super(key: key);

  @override
  _DriverRidesPageState createState() => _DriverRidesPageState();
}

class _DriverRidesPageState extends State<DriverRidesPage>
    with TickerProviderStateMixin {
  late DriverRidesPageModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DriverRidesPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Rides'),
        backgroundColor: Color(0xFF19DB8A),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('HomePageDriver');
          },
        ),
      ),
      body: FutureBuilder<String>(
        future: _model.getDriverName(
            FirebaseAuth.instance.currentUser?.uid ?? ''),
        builder: (context, driverNameSnapshot) {
          if (driverNameSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!driverNameSnapshot.hasData) {
            return Center(child: Text('Driver name not available'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('trips')
                .where('status', isEqualTo: 'accepted')
                .where('driverName', isEqualTo: driverNameSnapshot.data)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No Rides'),
                );
              }

              return ListView(
                children: snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;

                  return buildRideDetailsCard(
                      data, document.reference);
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildRideDetailsCard(
      Map<String, dynamic> data, DocumentReference documentReference) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Passenger: ${data['userName']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('From: ${data['from']}'),
                        Text('To: ${data['to']}'),
                        Text('Date: ${data['date']}'),
                        Text('Time: ${data['time']}'),
                        Text('Price: ${data['price']}'),
                        Text('Passenger phone: ${data['userPhone']}'),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Handle deletion here
                      removeRideCard(documentReference);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> removeRideCard(DocumentReference documentReference) async {
    try {
      await documentReference.delete();
    } catch (e) {
      print('Error deleting ride card: $e');
    }
  }
}

class DriverRidesPageModel extends FlutterFlowModel<DriverRidesPage> {
  final unfocusNode = FocusNode();

  Future<String> getDriverName(String uid) async {
    DocumentSnapshot snapshot =
    await FirebaseFirestore.instance.collection('drivers').doc(uid).get();
    if (snapshot.exists) {
      return snapshot['driverName'] ?? '';
    } else {
      return ''; // Handle the case where the document doesn't exist
    }
  }

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }
}
