import 'package:hive/hive.dart';

class HiveDatabase {
  HiveDatabase();
  /// A Hive Box
  late Box<dynamic> hiveBox;

  /// Opens a Hive box by its name
  Future<void> openBox([String boxName = 'NEWS_APP']) async {
    hiveBox = await Hive.openBox<dynamic>(boxName);
  }

  Future<void> remove(String key) async {
    await hiveBox.delete(key);
  }

  dynamic get(String key) {
    return hiveBox.get(key);
  }

  dynamic getAll() {
    return hiveBox.values.toList();
  }

  bool has(String key) {
    return hiveBox.containsKey(key);
  }

  Future<void> set(String? key, dynamic data) async {
    await hiveBox.put(key, data);
  }

  Future<void> clear() async {
    await hiveBox.clear();
  }
}