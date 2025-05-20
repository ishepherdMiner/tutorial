import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tName = 'company';
final String columnId = "_id";
final String columnName = "name";
final String columnDesc = "description";

class Company {
  int? id;
  String? name;

  /// 5.模型增加对应字段 + 列
  String? description;
  Company();

  /// 6. 更新map和对象的转换方法
  Map<String, Object?> toMap() {
    var map = <String, Object?>{columnName: name, columnDesc: description};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Company.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
    description = map[columnDesc];
  }
}

class CompanyProvider {
  Database? db;

  Future<Database?> open() async {
    if (db == null) {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'demo.db');
      db = await openDatabase(
        path,
        version: 2,

        /// 1.新版本发布时改成2
        onCreate: (db, version) async {
          /// 2.新安装设备直接用新数据库
          await db.execute('''
            create table $tName (
            $columnId integer primary key autoincrement,
            $columnName text not null,
            $columnDesc text)
        ''');
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          var batch = db.batch();

          /// 3.对旧版本的设备:判断安装设备已创建的数据库版本
          if (oldVersion == 1) {
            _updateTableCompanyV1toV2(batch);
          }
          await batch.commit();
        },
      );
    }
    return db;
  }

  /// 4.添加description字段
  void _updateTableCompanyV1toV2(Batch batch) {
    batch.execute('ALTER TABLE Company ADD description TEXT');
  }

  /// 注册企业
  Future insert(Company company) async {
    company.id = await db?.insert(tName, company.toMap());
    return company;
  }

  /// 查找企业
  Future findById(int id) async {
    List<Map> maps = await db!.query(
      tName,
      columns: [columnId, columnName],
      where: '$columnId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Company.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Company>> find() async {
    List<Company> companys = [];
    List<Map> maps = await db!.query(tName, columns: [columnId, columnName]);
    for (var map in maps) {
      Company c = Company.fromMap(map);
      companys.add(c);
    }
    return companys;
  }

  /// 删除企业
  Future delete(int id) async {
    return await db?.delete(tName, where: '$columnId = ?', whereArgs: [id]);
  }

  /// 更新企业信息
  Future update(Company company) async {
    return await db?.update(
      tName,
      company.toMap(),
      where: '$columnId = ?',
      whereArgs: [company.id],
    );
  }
}
