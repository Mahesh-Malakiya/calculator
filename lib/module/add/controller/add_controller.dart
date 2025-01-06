import 'dart:developer';

import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/add/model/add_model.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';

class AddController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  final DatabaseHelper dbHelper = DatabaseHelper();
  RxList<Map<String, String>> uniqueFamilyEventsWithRelationships =
      <Map<String, String>>[].obs;
  Rx<TransactionType> transactionType = Rx(TransactionType.RECIVED_MONEY);
  RxList<String> filterItems = RxList([
    '받은 돈',
    '나간 돈',
  ]);
  RxList<TransactionEntry> transactionsList = RxList();
  RxList<TransactionEntry> transaction = RxList();
  RxList<String> relationshipSelect = RxList(['직장', '가족', '친구']);
  RxList<String> eventSelect = RxList(['피파온라인', '돌잔치', '결혼식']);
  RxBool isEditable = RxBool(false);
  final RxBool showErrorMessageName = RxBool(false);
  final RxBool showErrorMessageAmount = RxBool(false);
  final RxBool showErrorMessagePhone = RxBool(false);
  final RxBool showErrorMessagerelation = RxBool(false);
  final RxBool showErrorMessageevent = RxBool(false);

  RxInt editIndexedData = RxInt(-1);
  RxInt isSelected = RxInt(0);
  RxInt isSelectedFamily = RxInt(-1);
  RxInt isSelectedRelation = RxInt(-1);
  RxBool isSelectedFamilyCard = RxBool(false);
  final noteController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  Rx<TextEditingController> relationShipSelectController =
      TextEditingController().obs;
  Rx<TextEditingController> familyEventSelectController =
      TextEditingController().obs;
  final BuildContext context = Get.context!;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    upDateData();
    fetchFamilyEventsWithRelationships();
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  Future<void> fetchTransactions() async {
    List<TransactionEntry> transactions = await dbHelper.getTransactions();
    transactionsList.value = transactions;
  }

  Future<void> fetchFamilyEventsWithRelationships() async {
    try {
      // Fetch unique familyEvent and relationship pairs from the database
      final results = await dbHelper.getUniqueFamilyEventsWithRelationships();

      // Clear the existing lists before adding new data

      // Iterate over the results and add familyEvent and relationship to the lists
      for (var item in results) {
        final event =
            item['familyEvent'] ?? ''; // Default to empty string if null
        final relationship =
            item['relationship'] ?? ''; // Default to empty string if null

        // Only add to the lists if the pair of event and relationship doesn't already exist
        if (!relationshipSelect.contains(relationship) &&
            !eventSelect.contains(event)) {
          relationshipSelect.add(relationship);
          eventSelect.add(event);
        }
      }

      // Log the results to check the values
      log('Fetched family events and relationships: $results');
      log('Event Select List: $eventSelect');
      log('Relationship Select List: $relationshipSelect');
    } catch (e) {
      log('Error fetching family events and relationships: $e');
    }
  }

  // Future<void> fetchFamilyEventsWithRelationships() async {
  //   try {
  //     // Fetch unique familyEvent and relationship pairs from the database
  //     final results = await dbHelper.getUniqueFamilyEventsWithRelationships();

  //     // Clear the existing lists before adding new data

  //     // Iterate over the results and add familyEvent and relationship to the lists
  //     for (var item in results) {
  //       eventSelect
  //           .add(item['familyEvent'] ?? ''); // Default to empty string if null
  //       relationshipSelect
  //           .add(item['relationship'] ?? ''); // Default to empty string if null
  //     }

  //     // Log the results to check the values
  //     log('Fetched family events and relationships: $results');
  //     log('Event Select List: $eventSelect');
  //     log('Relationship Select List: $relationshipSelect');
  //   } catch (e) {
  //     log('Error fetching family events and relationships: $e');
  //   }
  // }

  void validateForm() {
    showErrorMessageName.value = nameController.text.isEmpty;
    showErrorMessageAmount.value = amountController.text.isEmpty;
    showErrorMessagePhone.value = phoneNumberController.text.isEmpty;
    showErrorMessageevent.value =
        familyEventSelectController.value.text.isEmpty;
    showErrorMessagerelation.value =
        relationShipSelectController.value.text.isEmpty;

    if (showErrorMessageName.isFalse &&
        showErrorMessageAmount.isFalse &&
        showErrorMessagePhone.isFalse &&
        showErrorMessageevent.isFalse &&
        showErrorMessagerelation.isFalse) {
      if (isEditable.value) {
        onEdit();
      } else {
        onSave();
      }
    }
  }

  void clearErrorStates(String fieldName) {
    switch (fieldName) {
      case 'name':
        showErrorMessageName.value = false;
        break;
      case 'amount':
        showErrorMessageAmount.value = false;
        break;
      case 'phone':
        showErrorMessagePhone.value = false;
        break;
      case 'event':
        showErrorMessageevent.value = false;
        break;
      case 'relation':
        showErrorMessagerelation.value = false;

        break;
    }
  }

  void upDateData() {
    updateTransactionType(index: 0);
    update();
  }

  void updateTransaction(TransactionEntry transaction) async {
    await dbHelper.updateTransaction(transaction);
  }

  void updateTransactionType({required int index}) {
    transactionType.value = filterItems[index] == '받은 돈'
        ? TransactionType.RECIVED_MONEY
        : TransactionType.SPENT_MONEY;
  }

  void onSave() async {
    if (nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        amountController.text.isEmpty) {
      return;
    }

    final newTransaction = TransactionEntry(
      type: transactionType.value,
      date: selectedDay.value,
      name: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      phoneNumber: phoneNumberController.text,
      familyEvent: familyEventSelectController.value.text,
      relationship: relationShipSelectController.value.text,
      note: noteController.text.isNotEmpty ? noteController.text : null,
      memo: null,
      createdAt: DateTime.now(),
      updatedAt: null,
    );

    await dbHelper.insertTransaction(newTransaction);
    nameController.clear();
    amountController.clear();
    phoneNumberController.clear();
    noteController.clear();
    familyEventSelectController.value.clear();
    relationShipSelectController.value.clear();
    isSelectedFamilyCard.value = false;
    fetchFamilyEventsWithRelationships();
  }

  Future<void> refreshTransactions() async {
    transaction.value = await dbHelper.getTransactions();
  }

  bool validateInputs() {
    if (nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        amountController.text.isEmpty) {
      return false;
    }
    return true;
  }

  RxInt isTappedEditSave = RxInt(0);

  void onEdit() async {
    if (!validateInputs()) return;

    final editTransaction = TransactionEntry(
      id: editIndexedData.value,
      type: transactionType.value,
      date: selectedDay.value,
      name: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      phoneNumber: phoneNumberController.text,
      familyEvent: familyEventSelectController.value.text,
      relationship: relationShipSelectController.value.text,
      note: noteController.text,
      memo: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await dbHelper.updateTransaction(editTransaction);
    if (isTappedEditSave.value == 0) {
      isTappedEditSave.value = 1;
      fetchFamilyEventsWithRelationships();
    }

    await refreshTransactions();
  }

  void clearForm() {
    nameController.clear();
    amountController.clear();
    phoneNumberController.clear();
    noteController.clear();
    familyEventSelectController.value.clear();
    relationShipSelectController.value.clear();
  }

  void populateData({
    required int id,
    required String name,
    required double amount,
    required String phoneNumber,
    required String familyEvent,
    required String relationship,
    required String note,
    required TransactionType transactionTyp,
  }) {
    transactionType.value = transactionTyp;
    nameController.text = name;
    noteController.text = note;
    amountController.text = amount.toString();
    phoneNumberController.text = phoneNumber;
    familyEventSelectController.value.text = familyEvent;
    relationShipSelectController.value.text = relationship;

    // Store the id for reference
    editIndexedData.value = id;
  }

  Future<void> fetchAndPopulateTransaction(int id) async {
    final selectedTransaction = await dbHelper.getTransactionById(id);
    if (selectedTransaction != null) {
      populateData(
          id: selectedTransaction.id!,
          name: selectedTransaction.name,
          amount: selectedTransaction.amount,
          phoneNumber: selectedTransaction.phoneNumber,
          familyEvent: selectedTransaction.familyEvent,
          relationship: selectedTransaction.relationship,
          transactionTyp: selectedTransaction.type,
          note: selectedTransaction.note ?? '');
    }
  }
}
