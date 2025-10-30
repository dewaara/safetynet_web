import 'package:digi_calendar/layout/dashboard_page.dart';
import 'package:digi_calendar/wlhwc/UploadPage.dart';
import 'package:digi_calendar/wlhwc/digi_dashbaord.dart';
import 'package:flutter/material.dart';

class CardDetailsWidget extends StatelessWidget {
  final void Function() onLock;
  final void Function() onPause;
  final void Function() onAddTime;

  const CardDetailsWidget({
    Key? key,
    required this.onLock,
    required this.onPause,
    required this.onAddTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.blue,
          width: 2.0, // Border width
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/imageupload-page');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UploadPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
            child: Text('ImageUpload'),
          ),
          ElevatedButton(
            onPressed: () {
              // DashboardPage
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashboardPage(
                          complaintId: '680a17dc7afb1b33e21da8ae',
                        )),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            child: Text('DigiCalender'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DigiDashboard()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text('Calender'),
          ),
        ],
      ),
    );
  }
}
