import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';
import 'package:dotenv/dotenv.dart';
import '/core/services/database.dart';
import '/domain/repositories/category_repository.dart';
import '/domain/repositories/category_action_repository.dart';
import '/domain/repositories/record_repository.dart';
import '/domain/services/category_service.dart';
import '/domain/services/record_service.dart';

final getIt = GetIt.instance;

void dependencyInjectionSetup() {
  var env = DotEnv()..load();

  // Database
  if (env['ENVIRONMENT'] == 'dev') {
    getIt.registerSingleton<AppDatabase>(AppDatabase(NativeDatabase.memory()));
  } else {
    getIt.registerSingleton<AppDatabase>(AppDatabase(null));
  }

  // Repositories
  getIt.registerSingleton<CategoryRepository>(
    CategoryRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<CategoryActionRepository>(
    CategoryActionRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<RecordRepository>(
    RecordRepository(getIt<AppDatabase>()),
  );

  // Services
  getIt.registerSingleton<CategoryService>(
    CategoryService(
      db: getIt<AppDatabase>(),
      categoryRepository: getIt<CategoryRepository>(),
      categoryActionRepository: getIt<CategoryActionRepository>(),
    ),
  );

  getIt.registerSingleton<RecordService>(
    RecordService(
      db: getIt<AppDatabase>(),
      repository: getIt<RecordRepository>(),
    ),
  );
}
