import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'contact_details.dart';

class DBHelper {
  static Future<Database> initDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'my_contacts.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    const sql = '''CREATE TABLE my_contacts(
      id INTEGER PRIMARY KEY,
      name TEXT,
      mobileNumber TEXT,
      emailAddress TEXT
    )''';

    await db.execute(sql);
  }

  static Future<int> createContacts(ContactDetails contact) async {
    Database db = await DBHelper.initDB();

    return await db.insert('my_contacts', contact.toJson());
  }

  static Future<List<ContactDetails>> readContacts() async {
    Database db = await DBHelper.initDB();
    var contact = await db.query('my_contacts', orderBy: 'name');

    List<ContactDetails> contactList = contact.isNotEmpty
        ? contact.map((details) => ContactDetails.fromJson(details)).toList()
        : [];

    return contactList;
  }

  static Future<int> updateContacts(ContactDetails contact) async {
    Database db = await DBHelper.initDB();

    return await db.update('my_contacts', contact.toJson(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  static Future<int> deleteContacts(int id) async {
    Database db = await DBHelper.initDB();

    return await db.delete('my_contacts', where: 'id = ?', whereArgs: [id]);
  }
}
