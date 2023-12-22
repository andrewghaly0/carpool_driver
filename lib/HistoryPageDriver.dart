import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HistoryPageDriver extends StatefulWidget {
  const HistoryPageDriver({Key? key}) : super(key: key);

  @override
  _HistoryPageDriverState createState() => _HistoryPageDriverState();
}

class _HistoryPageDriverState extends State<HistoryPageDriver> with TickerProviderStateMixin {
  late HistoryPageDriverModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HistoryPageDriverModel());
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
        title: Text('History'),
        backgroundColor: Color(0xFF19DB8A),
      ),
      body: FutureBuilder<String>(
        future: _model.getDriverName(FirebaseAuth.instance.currentUser?.uid ?? ''),
        builder: (context, driverNameSnapshot) {
          if (driverNameSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!driverNameSnapshot.hasData) {
            return Center(child: Text('Driver name not available'));
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('trips')
                .where('status', isNotEqualTo: 'pending')
                .where('driverName', isEqualTo: driverNameSnapshot.data)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('empty'),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                  return buildHistoryCard(data, document.reference);
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildHistoryCard(Map<String, dynamic> data, DocumentReference documentReference) {
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
                          'Status: ${data['status']}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text('Passenger: ${data['userName']}'),
                        Text('From: ${data['from']}'),
                        Text('To: ${data['to']}'),
                        Text('Date: ${data['date']}'),
                        Text('Price: ${data['price']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPageDriverModel extends FlutterFlowModel<HistoryPageDriver> {
  final unfocusNode = FocusNode();

  Future<String> getDriverName(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('drivers').doc(uid).get();
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
