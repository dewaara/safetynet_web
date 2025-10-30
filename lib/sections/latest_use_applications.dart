import 'package:digi_calendar/data/mock_data.dart';
import 'package:digi_calendar/responsive.dart';
import 'package:digi_calendar/styles/styles.dart';
import 'package:digi_calendar/widgets/category_box.dart';
import 'package:flutter/material.dart';
import 'package:digi_calendar/models/enums/application_type.dart';
import 'package:intl/intl.dart' as intl;

class LatestUseApplications extends StatefulWidget {
  const LatestUseApplications({Key? key}) : super(key: key);

  @override
  _LatestUseApplicationsState createState() => _LatestUseApplicationsState();
}

class _LatestUseApplicationsState extends State<LatestUseApplications> {
  final ScrollController _scrollController = ScrollController();
  final List<bool> _isSwitched =
      List.filled(MockData.transactions.length, false);

  @override
  Widget build(BuildContext context) {
    return CategoryBox(
      title: "Active Apps",
      suffix: TextButton(
        child: Text(
          "See all",
          style: TextStyle(
            color: Styles.defaultRedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        onPressed: () {},
      ),
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: MockData.transactions.length,
            itemBuilder: (context, index) {
              var data = MockData.transactions[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(data.profileImage),
                              ),
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  ApplicationTypeExtensions(
                                    data.transactionType,
                                  ).icon,
                                  size: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Text(
                              data.transactionName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        intl.DateFormat.MMMd().add_jm().format(data.datetime),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Visibility(
                      visible: !Responsive.isMobile(context),
                      child: Expanded(
                        child: Text(
                          data.id,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: _isSwitched[index],
                          onChanged: (value) {
                            setState(() {
                              _isSwitched[index] = value;
                            });
                            print(value
                                ? 'Switch ON for ${data.transactionName}'
                                : 'Switch OFF for ${data.transactionName}');
                          },
                          activeColor:
                              Colors.blue, // Optional: set the active color
                          inactiveThumbColor: Colors
                              .grey, // Optional: set the inactive thumb color
                          inactiveTrackColor: Colors.grey[
                              300], // Optional: set the inactive track color
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
