import 'dart:developer';

import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/add/model/add_model.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';

class AddController extends GetxController {
  final MainController mainController = Get.find<MainController>();

  final DatabaseHelper dbHelper = DatabaseHelper();
  RxString familyEvent = RxString('');
  RxBool isEditable = RxBool(false);

  ///FATCH DATA FROM DATABSE......
  RxList<TransactionEntry> transaction = RxList();

  RxInt isSelected = RxInt(0);
  RxInt isSelectedFamily = RxInt(0);
  RxInt isSelectedRelation = RxInt(0);
  RxBool isSelectedFamilyCard = RxBool(false);
  // RxBool isExpandedCalander = RxBool(false);
  final noteController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  Rx<TextEditingController> relationShipSelectController =
      TextEditingController().obs;
  Rx<TextEditingController> familyEventSelectController =
      TextEditingController().obs;
  final BuildContext context = Get.context!;
  final RxBool showErrorMessageName = RxBool(false);
  final RxBool showErrorMessageAmount = RxBool(false);
  final RxBool showErrorMessagePhone = RxBool(false);
  final RxBool showErrorMessagerelation = RxBool(false);
  final RxBool showErrorMessageevent = RxBool(false);
  // final RxBool showErrorMessagenote = RxBool(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    upDateData();
    addUniqueFamilyEventsData();
    Future.delayed(Duration.zero, () {
      addUniqueFamilyEvents();
    });
  }

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> selectedDay = DateTime.now().obs;

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
  }

  RxList<TransactionEntry> transactionsList = RxList();
  Future<void> fetchTransactions() async {
    List<TransactionEntry> transactions = await dbHelper.getTransactions();
    transactionsList.value = transactions;
  }

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
    updateFamilyTextField(context);
    updateEvent(0);
    updateRelationTextField();
    updaterelationship(0);
    updateTransactionType(index: 0);
  }

// update
  void updateTransaction(TransactionEntry transaction) async {
    await dbHelper.updateTransaction(transaction);
  }

  /// TRANSACTIONS
  Rx<TransactionType> transactionType = Rx(TransactionType.RECIVED_MONEY);
  RxList<String> filterItems = RxList([
    'Money received',
    'Money spent',
  ]);
  void updateTransactionType({required int index}) {
    transactionType.value = filterItems[index] == 'Money received'
        ? TransactionType.RECIVED_MONEY
        : TransactionType.SPENT_MONEY;
  }

  ///RELATION
  RxString relationship = RxString('');
  RxList<String> relationshipSelect = RxList([
    'Work',
    'Family',
    'Friends',
  ]);

  void updaterelationship(int index) {
    relationship.value = relationshipSelect[index] == 'Work'
        ? 'Work'
        : relationship.value =
            relationshipSelect[index] == 'Family' ? 'Family' : 'Friends';
  }

  void updateRelationTextField() {
    relationShipSelectController.value.clear();
    relationShipSelectController.value.text =
        relationshipSelect[isSelectedRelation.value]
            .toRelationExtensionApplocalizations(context);
  }

  /// EVENT

  RxList<String> eventSelect = RxList([
    'FIFA Online',
    'First birthday party',
    'Wedding',
  ]);

  void addUniqueFamilyEvents() {
    // Assuming getUniqueFamilyEvents() returns a List<String>
    List<String> uniqueEvents = getUniqueFamilyEvents();
    log('*************${uniqueEvents.length}');
    // Add all unique events to relationshipSelect
    eventSelect.addAll(uniqueEvents);
    update();
    update();
    log('message::::${eventSelect.length}');
  }

  List<String> getUniqueFamilyEvents() {
    return transactionsList
        .map((transaction) => transaction.familyEvent)
        .toSet()
        .toList();
  }

  List<String> uniqueEvents = [];
  void addUniqueFamilyEventsData() {
    uniqueEvents = getUniqueFamilyEvents();
  }

  void updateEvent(int index) {
    familyEvent.value = eventSelect[index] == 'FIFA Online'
        ? 'FIFA Online'
        : familyEvent.value = eventSelect[index] == 'Wedding'
            ? 'Wedding'
            : 'First birthday party';
  }

  void updateFamilyTextField(BuildContext context) {
    familyEventSelectController.value.clear();
    familyEventSelectController.value.text = eventSelect[isSelectedFamily.value]
        .toEventExtensionApplocalizations(context);
  }

  /// update on data base...

  void onSave() async {
    // Validate required fields before saving

    if (nameController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        amountController.text.isEmpty) {
      return;
    }

    // Create a new Transaction object
    final newTransaction = TransactionEntry(
      type: transactionType.value,
      date: selectedDay.value ?? DateTime.now(),
      name: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      phoneNumber: phoneNumberController.text,
      familyEvent: familyEvent.value,
      relationship: relationship.value,
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
    isSelectedFamilyCard.value = false;
  }

  RxInt editIndexedData = RxInt(-1);
//ON EDIT

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

  void onEdit() async {
    if (!validateInputs()) return;

    final editTransaction = TransactionEntry(
      id: editIndexedData.value,
      type: transactionType.value,
      date: selectedDay.value ?? DateTime.now(),
      name: nameController.text,
      amount: double.tryParse(amountController.text) ?? 0.0,
      phoneNumber: phoneNumberController.text,
      familyEvent: familyEvent.value,
      relationship: relationship.value,
      note: noteController.text.isNotEmpty ? noteController.text : null,
      memo: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await dbHelper.updateTransaction(editTransaction);

    // Refresh transactions and clear the form
    await refreshTransactions();
  }

  void clearForm() {
    nameController.clear();
    amountController.clear();
    phoneNumberController.clear();
    noteController.clear();
  }

  void populateData({
    required int id,
    required String name,
    required double amount,
    required String phoneNumber,
    required String familyEvent,
    required String relationship,
    required TransactionType transactionTyp,
  }) {
    transactionType.value = transactionTyp;
    nameController.text = name;
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
      );
    }
  }
}
