import 'package:carpool_project_driver/DriverRidesPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePageDriver.dart';

class HomeRequestsPageDriver extends StatefulWidget {
  const HomeRequestsPageDriver({Key? key}) : super(key: key);

  @override
  _HomeRequestsPageDriverState createState() => _HomeRequestsPageDriverState();
}

class _HomeRequestsPageDriverState extends State<HomeRequestsPageDriver> with TickerProviderStateMixin {
  late HomeRequestsPageDriverModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel();
    _model.initState(context);
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
        title: Text('Requests'),
        backgroundColor: Color(0xFF19DB8A),
        actions: [
          Switch(
            value: _model.isTimeConstraintActive,
            onChanged: (value) {
              setState(() {
                _model.isTimeConstraintActive = value;
              });
            },
          ),
        ],
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
                .where('status', isEqualTo: 'pending')
                .where('time', isEqualTo: '5:30 PM')
                .where('driverName', isEqualTo: driverNameSnapshot.data)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No requests at the moment'),
                );
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                  return buildRequestCard(data, document.reference);
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget buildRequestCard(Map<String, dynamic> data, DocumentReference documentReference) {
    // Extract the date from the document
    String tripDate = data['date'];

    // Check if the current time is within the allowed range for booking
    bool isBookingAllowed = _model.isBookingAllowed(data['date']);

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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: isBookingAllowed
                        ? () async {
                      await documentReference.update({'status': 'accepted'});
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DriverRidesPage()),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF19DB8A),
                      onPrimary: Colors.white,
                    ),
                    child: Text('Accept'),
                  ),
                  ElevatedButton(
                    onPressed: isBookingAllowed
                        ? () async {
                      await documentReference.update({'status': 'cancelled'});
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePageDriver()),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.redAccent,
                      onPrimary: Colors.white,
                    ),
                    child: Text('Cancel'),
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

class HomeRequestsPageDriverModel extends ChangeNotifier {
  final unfocusNode = FocusNode();

  Future<String> getDriverName(String uid) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('drivers').doc(uid).get();
    if (snapshot.exists) {
      return snapshot['driverName'] ?? '';
    } else {
      return ''; // Handle the case where the document doesn't exist
    }
  }
  bool _isTimeConstraintActive = true;

  bool get isTimeConstraintActive => _isTimeConstraintActive;

  set isTimeConstraintActive(bool value) {
    _isTimeConstraintActive = value;
    notifyListeners();
  }

  bool isBookingAllowed(String tripDate) {
    try {
      if (!_isTimeConstraintActive) {
        return true;
      }

      DateTime now = DateTime.now();
      TimeOfDay startTime = TimeOfDay(hour: 16, minute: 30);
      TimeOfDay endTime = TimeOfDay(hour: 17, minute: 30);

      DateTime allowedStartTime = DateTime(now.year, now.month, now.day, startTime.hour, startTime.minute);
      DateTime allowedEndTime = DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

      DateTime parsedTripDate;

      try {
        List<String> dateParts = tripDate.split('-');
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);
        parsedTripDate = DateTime(year, month, day);
      } catch (_) {
        List<String> dateParts = tripDate.split('/');
        int day = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int year = int.parse(dateParts[2]);
        parsedTripDate = DateTime(year, month, day);
      }

      bool isToday = parsedTripDate.year == now.year && parsedTripDate.month == now.month && parsedTripDate.day == now.day;

      if (isToday) {
        return now.isAfter(allowedStartTime) && now.isBefore(allowedEndTime);
      }

      return true;
    } catch (e) {
      print('Error parsing date: $e');
      return false;
    }
  }
  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }
}
HomeRequestsPageDriverModel createModel() => HomeRequestsPageDriverModel();