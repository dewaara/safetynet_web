import 'package:digi_calendar/models/enums/application_type.dart';

class Application {
  final String id;
  final String profileImage;
  final String transactionName;
  final DateTime datetime;
  // final double amount;
  final ApplicationType transactionType;

  Application(
    this.id,
    this.transactionName,
    this.datetime,
    // this.amount,
    this.transactionType,
    this.profileImage,
  );
}
