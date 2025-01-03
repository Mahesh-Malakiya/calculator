import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_calculator/common/widget/dialog.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/module/add/model/add_model.dart'; // Adjust the path accordingly
import 'package:flutter_calculator/module/add/model/compare_model.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'transactions';

  // Singleton pattern for creating and accessing the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            type TEXT,
            date TEXT,
            name TEXT,
            amount REAL,
            phoneNumber TEXT,
            familyEvent TEXT,
            relationship TEXT,
            note TEXT,
            memo TEXT,
            createdAt TEXT,
            updatedAt TEXT
          )
        ''');
      },
    );
  }

// Insert transaction into the database
  Future<int> insertTransaction(TransactionEntry transaction) async {
    final db = await database;

    // Insert without replacing existing records
    return await db.insert(
      _tableName,
      transaction.toJson(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  // Get all transactions
  Future<List<TransactionEntry>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return TransactionEntry.fromJson(maps[i]);
    });
  }

  Future<List<FamilyEventModel>> getTransactionsByCompare() async {
    final db = await database;

    // Execute the custom SQL query with aggregation and GROUP BY
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT 
      name, 
      relationship, 
      familyEvent, 
      SUM(CASE WHEN type = 'RECIVED_MONEY' THEN amount ELSE 0 END) AS total_received, 
      SUM(CASE WHEN type = 'SPENT_MONEY' THEN amount ELSE 0 END) AS total_spent
    FROM transactions
    GROUP BY name, relationship, familyEvent
    ORDER BY name, relationship, familyEvent
  ''');

    log("Query Results: $maps");

    // Convert the result into a list of FamilyEvent objects
    return maps.map((map) => FamilyEventModel.fromMap(map)).toList();
  }

  Future<TransactionEntry?> getTransactionById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return TransactionEntry.fromJson(result.first);
    }
    return null;
  }

  // Update a transaction
  Future<int> updateTransaction(TransactionEntry transaction) async {
    final db = await database;
    return await db.update(
      'transactions', // Table name
      transaction.toJson(), // Convert transaction to a JSON map
      where: 'id = ?', // Match the transaction ID
      whereArgs: [transaction.id], // Provide the ID as an argument
    );
  }

  // Delete a transaction
  Future<int> deleteAllTransactions() async {
    final db = await database;
    return await db.delete(_tableName); // Deletes all rows in the table
  }

  Future<void> requestStoragePermission(BuildContext context) async {
    try {
      // Check if permission is granted
      var status = Platform.isIOS
          ? await Permission.photos.request()
          : await Permission.manageExternalStorage.request();

      if (status.isGranted) {
        // If already granted, proceed with the action
        exportData();
      } else {
        // Check if we should show rationale (this is safe and works on all supported Android versions)
        bool shouldShowRationale =
            await Permission.storage.shouldShowRequestRationale;

        if (shouldShowRationale) {
          // If rationale should be shown, display a dialog explaining why permission is needed
          showPermissionRationaleDialog(context);
        } else {
          // Request permission directly
          PermissionStatus newStatus = await Permission.storage.request();

          if (newStatus.isGranted) {
            // If permission granted, proceed with the action
            exportData();
          } else if (newStatus.isPermanentlyDenied) {
            // If permission is permanently denied, prompt user to enable it from settings
            showPermissionRationaleDialog(context);
          } else {
            // Handle permission denial
          }
        }
      }
    } catch (e) {
      // Handle any errors that might occur
    }
  }

  Future<void> exportData() async {
    try {
      // Step 1: Allow user to select a directory
      String? selectedPath = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Select Export Directory',
      );

      if (selectedPath == null) {
        log('No directory selected');
        return; // User canceled the picker
      }

      // Step 2: Fetch the data you want to export
      final transactions = await getTransactions();

      // Step 3: Convert data to JSON
      final transactionJsonData = transactions.map((e) => e.toJson()).toList();
      final transactionJsonString = jsonEncode(transactionJsonData);

      // Step 4: Define the file path in the selected directory
      final transactionFilePath = '$selectedPath/SherryBackUp.json';

      // Step 5: Write the file to the selected directory
      final transactionFile = File(transactionFilePath);
      await transactionFile.writeAsString(transactionJsonString);

      // Step 6: Optionally, show a confirmation to the user
      log("Data exported successfully to $transactionFilePath");
    } catch (e) {
      log('Error exporting data: $e');
      // Optionally show an error message to the user
    }
  }

  Future<void> importData() async {
    try {
      // Pick the JSON files
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
        allowMultiple: true, // Allow multiple file selection
      );

      if (result != null && result.files.isNotEmpty) {
        for (var file in result.files) {
          if (file.path != null) {
            final filePath = file.path!;
            final fileName = file.name.toLowerCase();

            // Read the file content
            final fileContent = await File(filePath).readAsString();

            // Parse the JSON
            final jsonData = jsonDecode(fileContent) as List;

            // Insert data into the appropriate table based on the file name
            final db = await database;
            if (fileName.contains("sherrybackup")) {
              for (var transaction in jsonData) {
                await db.insert(
                    'transactions', Map<String, dynamic>.from(transaction));
              }
            } else if (fileName.contains("sherrybackup")) {
              for (var user in jsonData) {
                await db.insert(
                    'transactions', Map<String, dynamic>.from(user));
              }
            } else {
              log('Unknown file type: $fileName');
            }
          }
        }

        Get.offNamed(Routes.MAIN);
      } else {
        log('File picking cancelled or no files selected');
      }
    } catch (e) {
      log('Error importing data: $e');
    }
  }
}
