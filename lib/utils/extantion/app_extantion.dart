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

extension EventSelectExtension on FamilyEvent {
  String get name {
    switch (this) {
      case FamilyEvent.FIFA_ONLINE:
        return 'FIFA Online';
      case FamilyEvent.FIRST_BIRTHDAY_PARTY:
        return 'First Birthday Party';
      case FamilyEvent.WEDDING:
        return 'Wedding';
      default:
        return '';
    }
  }
}

extension EventSelectExtensionString on String {
  FamilyEvent get toEventExtension {
    switch (this) {
      case 'FIFA Online':
        return FamilyEvent.FIFA_ONLINE;
      case 'First Birthday Party':
        return FamilyEvent.FIRST_BIRTHDAY_PARTY;
      case 'Wedding':
        return FamilyEvent.WEDDING;
      default:
        return FamilyEvent
            .FIFA_ONLINE; // Default value if none of the cases match
    }
  }
}

extension AppExtantion on String {
  Relationship toRelationExtension() {
    switch (this) {
      case 'FAMILY':
        return Relationship.FAMILY;
      case 'FRIEND':
        return Relationship.FRIEND;
      case 'WORK':
        return Relationship.WORK;
      default:
        return Relationship.WORK; // Default value if none of the cases match
    }
  }

  String toRelationExtensionApplocalizations(BuildContext context) {
    final localization = AppLocalizations.of(context);
    switch (this) {
      case 'Family':
        return localization!.family;
      case 'Friends':
        return localization!.friends;
      case 'Work':
        return localization!.work;
      default:
        return localization!.work; // Default value if none of the cases match
    }
  }

  String relationshipToLocalizedString(
      String relationship, BuildContext context) {
    final localization = AppLocalizations.of(context);

    switch (relationship) {
      case Relationship.FRIEND:
        return localization!.friends;
      case Relationship.FAMILY:
        return localization!.family;
      case Relationship.WORK:
        return localization!.work;
      default:
        return localization!.work; // Fallback for unknown cases
    }
  }

  String toEventExtensionApplocalizations(BuildContext context) {
    final localization = AppLocalizations.of(context);
    switch (this) {
      case 'FIFA Online':
        return localization!.fifaOnline;
      case 'First birthday party':
        return localization!.firstBirthday;
      case 'Wedding':
        return localization!.wedding;
      default:
        return localization!
            .fifaOnline; // Default value if none of the cases match
    }
  }

  String toFilterItemsAppLocalizations(BuildContext context) {
    final localization = AppLocalizations.of(context);
    switch (this) {
      case 'Received money':
        return localization!.receivedMoney;
      case 'Disbursed money':
        return localization!.disbursedMoney;
      case 'Comparison':
        return localization!.comparison;
      case 'Contact':
        return localization!.contact;
      default:
        return localization!
            .fifaOnline; // Default value if none of the cases match
    }
  }

  String toTransactionTyoeLocalization(BuildContext context) {
    final localization = AppLocalizations.of(context);

    switch (this) {
      case 'Money received':
        return localization!.moneyReceived;
      case 'Money spent':
        return localization!.moneySpent;

      default:
        return localization!
            .moneyReceived; // Default value if none of the cases match
    }
  }
}

extension RelationShipSelectExtension on Relationship {
  String get name {
    switch (this) {
      case Relationship.WORK:
        return 'Work';
      case Relationship.FAMILY:
        return 'Family';
      case Relationship.FRIEND:
        return 'Friend';
      default:
        return '';
    }
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
