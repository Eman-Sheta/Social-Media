import 'package:social_media/model/post_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static const _databaseName = "PostDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'post';
  static const columnId = 'id';
  static const columnReacts = 'reacts';
  static const columnViews = 'views';
  static const columnTitle = 'title';
  static const columnSummary = 'summary';
  static const columnBody = 'body';
  static const columnImageURL = 'imageURL';
  static const columnPostTime = 'postTime';
  static const columnAuthorId = 'authorId';

  SqlDb._privateConstructor();
  static final SqlDb instance = SqlDb._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnReacts INTEGER NOT NULL,
        $columnViews INTEGER NOT NULL,
        $columnTitle TEXT NOT NULL,
        $columnSummary TEXT NOT NULL,
        $columnBody TEXT NOT NULL,
        $columnImageURL TEXT NOT NULL,
        $columnPostTime TEXT NOT NULL,
        $columnAuthorId TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await database;
    var id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> query(String id) async {
    Database db = await database;
    var results =
        await db.query(table, where: '$columnId = ?', whereArgs: [id]);
    return results.isNotEmpty ? results.first : null;
  }

  Future<int> insertPost(PostModel post) async {
    Database db = await database;
    return await db.insert(table, {
      columnId: post.id,
      columnReacts: post.reacts,
      columnViews: post.views,
      columnTitle: post.title,
      columnSummary: post.summary,
      columnBody: post.body,
      columnImageURL: post.imageURL,
      columnPostTime: post.postTime.toIso8601String(),
      columnAuthorId: post.author.id,
    });
  }

  Future<List<Map<String, dynamic>>> queryAllPosts() async {
    Database db = await database;
    return await db.query(table);
  }

  Future<void> deleteDatabaseFile() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, SqlDb._databaseName);

    await deleteDatabase(path);
  }
}
