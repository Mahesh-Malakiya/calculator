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

  RxList<TransactionEntry> transactionsList = RxList();
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
  @override
  void onInit() {
    super.onInit();
    getAddFunction();
  }

  void getAddFunction() async {
    fetchTransactions().then(
      (value) {
        filterSpentMoney();
        filterReaciveMoney();
        calculateTotalAmountSpentMoney();
        calculateTotalAmountReacive();
        fetchCompareList();
        filterEvents();
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

  Future<void> fetchCompareList() async {
    List<FamilyEventModel> transactions =
        await dbHelper.getTransactionsByCompare();
    compareList.value = transactions;
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

  RxList<TransactionEntry> filterFifaOnlineList = RxList();
  void filterFifaOnline() {
    // Clear the spentMoneyList before adding filtered transactions
    filterFifaOnlineList.clear();

    // Loop through all transactions and check if the type is SPENT_MONEY
    for (var transaction in transactionsList) {
      if (transaction.familyEvent == FamilyEvent.FIFA_ONLINE) {
        // Add the transaction to the spentMoneyList
        filterFifaOnlineList.add(transaction);
      }
    }
  }

  RxList<TransactionEntry> filterFirstBirthdayPartylIST = RxList();
  void filterFirstBirthdayParty() {
    // Clear the spentMoneyList before adding filtered transactions
    filterFirstBirthdayPartylIST.clear();

    // Loop through all transactions and check if the type is SPENT_MONEY
    for (var transaction in transactionsList) {
      if (transaction.familyEvent == FamilyEvent.FIRST_BIRTHDAY_PARTY) {
        // Add the transaction to the spentMoneyList
        filterFirstBirthdayPartylIST.add(transaction);
      }
    }
  }

  RxList<TransactionEntry> filterWeddingList = RxList();
  void filterWedding() {
    // Clear the spentMoneyList before adding filtered transactions
    filterWeddingList.clear();

    // Loop through all transactions and check if the type is SPENT_MONEY
    for (var transaction in transactionsList) {
      if (transaction.familyEvent == FamilyEvent.WEDDING) {
        filterWeddingList.add(transaction);
      }
    }
  }

  void filterEvents() {
    filterWedding();
    filterFirstBirthdayParty();
    filterFifaOnline();
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
