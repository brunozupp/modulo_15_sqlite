import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlite {

  Future<Database> openConnection() async {
    
    var databasePath = await getDatabasesPath();

    final databaseFinalPath = join(databasePath, "SQLITE_EXAMPLE");

    final database = await openDatabase(
      databaseFinalPath,
      version: 1,
      onCreate: (Database db, int version) async { // vai ser chamado quando o banco não existir
        
        // o batch acumula um monte de query para no final executar
        final batch = db.batch();

        batch.execute('''
          CREATE TABLE teste(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome VARCHAR(200)
          )
        ''');

        await batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) { // será chamado sempre que houver alteração na versão (subir a versão)

      },
      onDowngrade: (Database db, int oldVersion, int newVersion) { // será chamado sempre que houver alteração na versão (descer a versão)

      },
    );

    return database;
  }
}