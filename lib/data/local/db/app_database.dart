import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase instance = AppDatabase._();

  Database? _db;

  Database get database => _db!;

  Future<void> init() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'wellbot.db');

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE chat_messages (
            id TEXT PRIMARY KEY,
            conversation_id TEXT NOT NULL,
            coach_id TEXT NOT NULL,
            text TEXT NOT NULL,
            sender TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS chat_messages');
        await db.execute('''
          CREATE TABLE chat_messages (
            id TEXT PRIMARY KEY,
            conversation_id TEXT NOT NULL,
            coach_id TEXT NOT NULL,
            text TEXT NOT NULL,
            sender TEXT NOT NULL,
            created_at TEXT NOT NULL
          )
        ''');
      },
    );
  }
}