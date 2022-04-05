import 'package:flutter/material.dart';
import 'package:modulo_15_sqlite/database/database_sqlite.dart';
    
class HomePage extends StatefulWidget {

  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    _database();
  }

  Future<void> _database() async {

    // final database = await DatabaseSqlite().openConnection();

    // database.insert("teste", {"nome" : "Bruno Noveli"});
    // database.delete("teste", where: "nome = ?", whereArgs: ["Bruno Noveli"]);
    // database.update(
    //   "teste", {
    //     "nome": "Academia do Flutter"
    //   },
    //   where: "nome = ?",
    //   whereArgs: ["Bruno Noveli"]
    // );
    // var result = await database.query("teste");
    // print(result);

    // database.rawInsert("INSERT INTO teste VALUES(NULL, ?)", ["Bruno"]);
    // database.rawUpdate("UPDATE teste SET nome = ? where id = ?", ["Bruno Academia do Flutter", 5]);
    // database.rawDelete("DELETE FROM teste WHERE id = ?", [5]);
    // var result2 = await database.rawQuery("SELECT * FROM teste");
    // print(result2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(),
    );
  }
}