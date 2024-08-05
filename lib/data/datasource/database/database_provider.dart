
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'hive_database.dart';

part 'database_provider.g.dart';

@riverpod
HiveDatabase hiveDatabase(HiveDatabaseRef ref) => HiveDatabase();