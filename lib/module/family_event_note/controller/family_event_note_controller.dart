import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/add/model/add_model.dart';
import 'package:flutter_calculator/module/add/model/compare_model.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';
import 'package:get/get.dart';

class FamilyEventNoteController extends GetxController {
  final RxBool isEditDone = RxBool(false);
  final DatabaseHelper dbHelper = DatabaseHelper();
  RxInt isSelected = RxInt(0);
  RxBool isSelectedFamilyCard = RxBool(false);
  RxString selectedEventName = RxString('');
  final textEditingController = TextEditingController();
  final filterItems = <String>[
    'Received money',
    'Disbursed money',
    'Comparison',
    'Contact'
  ].obs;

  FocusNode textFocusNode = FocusNode();
  RxList<FamilyEventModel> compareList = RxList();
  RxList<TransactionEntry> spentMoneyList = RxList();
  RxList<TransactionEntry> reciveMoneyList = RxList();
  final mainController = Get.find<MainController>();
  late AddController addController;
  // Filter parameters
  Rx<String> filterName = ''.obs;
  Rx<Relationship?> filterRelationship = Rxn<Relationship>();
  Rx<FamilyEvent?> filterFamilyEvent = Rxn<FamilyEvent>();

  ///
  ///
  RxList<TransactionEntry> transactionsList = RxList();
  Map<String, RxList<TransactionEntry>> categorizedTransactions = {};
  List<String> uniqueEvents = [];

  void createCategorizedTransactionLists() {
    // Clear previous data
    categorizedTransactions.clear();

    for (var event in uniqueEvents) {
      // Filter transactions for the current event
      var filteredTransactions = transactionsList
          .where((transaction) => transaction.familyEvent == event)
          .toList();

      // Add to categorized map
      categorizedTransactions[event] =
          RxList<TransactionEntry>.from(filteredTransactions);
    }
  }

  ///
  ///
  @override
  void onInit() {
    super.onInit();
    getAddFunction();
  }

  void getAddFunction() async {
    fetchTransactions().then(
      (value) {
        getUniqueFamilyEvents();
        addUniqueFamilyEvents();
        filterSpentMoney();
        filterReaciveMoney();
        calculateTotalAmountSpentMoney();
        calculateTotalAmountReacive();
        fetchCompareList();
        createCategorizedTransactionLists();
        calculateTotal();
      },
    );
  }

  final RxDouble calculateAmountTotal = RxDouble(0);
  void calculateTotal() {
    calculateAmountTotal.value = totalReceived.value - totalSpent.value;
  }

  RxList<TransactionEntry> filteredTransactions = RxList<TransactionEntry>();
  void searchTransactions(String query) {
    if (query.isEmpty) {
      filteredTransactions.assignAll(transactionsList);
    } else {
      filteredTransactions.assignAll(
        transactionsList.where(
          (transaction) =>
              transaction.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  void tapAmountWidget(
      {required int index, required TransactionEntry transactionEntey}) {
    if (!Get.isRegistered<AddController>()) {
      // Register AddController if it's not registered yet
      Get.put(AddController());
    }

    // Now safely access the AddController
    addController = Get.find<AddController>();
    addController.isEditable.value = true;
    log('message:::${transactionEntey.id!}');
    addController.fetchAndPopulateTransaction(transactionEntey.id!);
    mainController.selectedIndex.value = 1;
    mainController.editIndexedData.value = index;
    mainController.update();
  }

  Future<void> fetchTransactions() async {
    List<TransactionEntry> transactions = await dbHelper.getTransactions();
    transactionsList.value = transactions;
  }

  List<String> getUniqueFamilyEvents() {
    return transactionsList
        .map((transaction) => transaction.familyEvent)
        .toSet()
        .toList();
  }

  void addUniqueFamilyEvents() {
    uniqueEvents = getUniqueFamilyEvents();
  }

  Future<void> fetchCompareList() async {
    List<FamilyEventModel> transactions =
        await dbHelper.getTransactionsByCompare();

    // Create a map to store unique family events (based on name and familyEvent)
    Map<String, FamilyEventModel> uniqueEventsMap = {};

    // Loop through the transactions and aggregate data for the same name and familyEvent
    for (var transaction in transactions) {
      String key = '${transaction.name}_${transaction.familyEvent}';

      if (uniqueEventsMap.containsKey(key)) {
        // If the entry already exists, aggregate the data using updateTotals
        uniqueEventsMap[key]!
            .updateTotals(transaction.totalReceived, transaction.totalSpent);
      } else {
        // If it's a new entry, add it to the map
        uniqueEventsMap[key] = transaction;
      }
    }

    // Convert the map values back to a list
    compareList.value = uniqueEventsMap.values.toList();
  }

  void filterSpentMoney() async {
    spentMoneyList.clear();

    for (var transaction in transactionsList) {
      if (transaction.type == TransactionType.SPENT_MONEY) {
        // Add the transaction to the spentMoneyList
        spentMoneyList.add(transaction);
      }
    }
  }

  Future<void> filterReaciveMoney() async {
    reciveMoneyList.clear();
    for (var transaction in transactionsList) {
      if (transaction.type == TransactionType.RECIVED_MONEY) {
        // Add the transaction to the spentMoneyList
        reciveMoneyList.add(transaction);
      }
    }
  }

  void calculateAmount() {
    // Clear the spentMoneyList before adding filtered transactions
    compareList.clear();

    // Loop through all transactions and check if the type is SPENT_MONEY
    for (var transaction in transactionsList) {
      if (transaction.type == TransactionType.RECIVED_MONEY) {
        // Add the transaction to the spentMoneyList
        reciveMoneyList.add(transaction);
      }
    }
  }

  RxDouble totalSpent = RxDouble(0);
  void calculateTotalAmountSpentMoney() {
    // Sum up the amount for all transactions in spentMoneyList
    for (var transaction in spentMoneyList) {
      totalSpent.value += transaction.amount;
    }
  }

  RxDouble totalReceived = RxDouble(0);
  void calculateTotalAmountReacive() {
    // Sum up the amount for all transactions in reciveMoneyList
    for (var transaction in reciveMoneyList) {
      totalReceived.value += transaction.amount;
    }
  }
}
