
// run cmd to generate file: dart run build_runner build
import 'package:isar/isar.dart';

part "app_settings.g.dart";

@Collection()
class AppSettings{
  Id id = Isar.autoIncrement;
  DateTime? firstLaunchDate;
}