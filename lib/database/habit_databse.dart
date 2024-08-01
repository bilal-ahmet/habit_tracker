import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /*
  SETUP
  */

  //  INITIALIZE - DATABASE
  static Future<void> initialize() async{
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([HabitSchema, AppSettingsSchema], directory: dir.path);
  }

  //  save first date of app startup (for heatmap)
  Future<void> saveFirstLaunchDate() async{
    final existingSettings = await isar.appSettings.where().findFirst();
    if(existingSettings == null){
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //  get first date of app startup (for heatmap)
  Future<DateTime?> getFirstLaunchDate() async{
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /*
  CRUD X OPERATIONS
  */

  //  List of habits

  //  CREATE - add a new habbits

  //  READ - read saved habbits from db

  //  UPDATE - check habbit on and off

  //  UPDATE - edit habbit name

  //  DELETE - delete habbits
}