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

        batch.execute('''
          CREATE TABLE produtos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome VARCHAR(200)
          )
        ''');

        batch.execute('''
          CREATE TABLE categorias(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome VARCHAR(200)
          )
        ''');

        await batch.commit();
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async { // será chamado sempre que houver alteração na versão (subir a versão)

        final batch = db.batch();

        // Assegurando que apenas vai executar esse comando de upgrade caso a versão anterior seja a 1
        // Aqui duplicando código pois o app pode tá na versão 3, mas eu ainda estava na 1 e quando atualizar ele iria pra 3 direto, o que não executaria o segundo if
        if(oldVersion == 1) {

          batch.execute('''
            CREATE TABLE produtos(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome VARCHAR(200)
            )
          ''');

          batch.execute('''
            CREATE TABLE categorias(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome VARCHAR(200)
            )
          ''');

        }

        // No caso do downgrade ali embaixo, eu poderia retirar esse cara daqui, já que a tabela não existiria mais na versão 3
        // a mesma coisa para retirar categorias do if acima
        if(oldVersion == 2) {

          batch.execute('''
            CREATE TABLE categorias(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome VARCHAR(200)
            )
          ''');
        }

        await batch.commit();
      },
      onDowngrade: (Database db, int oldVersion, int newVersion) async { // será chamado sempre que houver alteração na versão (descer a versão)

        final batch = db.batch();

        if(oldVersion == 3) {

          batch.execute('''
            DROP TABLE categorias
          ''');
        }

        await batch.commit();
      },
      onConfigure: (Database db) async { // Método executado sempre que eu abrir uma nova conexão

        // Nesse cara eu coloco todas as configurações para o meu banco de dados

        // Habilita as FK
        await db.execute("PRAGMA foreign_keys = ON");
      }
    );

    return database;
  }
}