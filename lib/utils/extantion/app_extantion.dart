import 'package:flutter/material.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

extension SearchTypeExtension on SearchType {
  String get name {
    switch (this) {
      case SearchType.RECIVED_MONEY:
        return 'Received Money';
      case SearchType.SPENT_MONEY:
        return 'Spent Money';
      case SearchType.COMPARISON:
        return 'Comparison';
      case SearchType.CONTACT:
        return 'Contact';
      default:
        return '';
    }
  }

  bool get isMoneyRelated {
    return this == SearchType.RECIVED_MONEY || this == SearchType.SPENT_MONEY;
  }
}

extension FormTypeExtension on TransactionType {
  String get name {
    switch (this) {
      case TransactionType.RECIVED_MONEY:
        return 'Received Money';
      case TransactionType.SPENT_MONEY:
        return 'Spent Money';
      default:
        return '';
    }
  }
}

extension NumberFormatting on double {
  String toAmount() {
    final NumberFormat formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}

extension StringToDoubleFormatting on String {
  double? toDoubleOrNull() {
    try {
      return double.parse(this);
    } catch (e) {
      return null; // Return null if the string cannot be parsed to a double
    }
  }
}
