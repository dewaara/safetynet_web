import 'package:flutter/material.dart';

enum ApplicationType { incoming, outgoing, unknown }

extension ApplicationTypeExtensions on ApplicationType {
  String get sign {
    switch (this) {
      case ApplicationType.incoming:
        return "+";
      case ApplicationType.outgoing:
        return "-";
      default:
        return "";
    }
  }

  IconData get icon {
    switch (this) {
      case ApplicationType.incoming:
        return Icons.download;
      case ApplicationType.outgoing:
        return Icons.upload;
      default:
        return Icons.help;
    }
  }
}
