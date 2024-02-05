import 'package:bramzo_lite/views/home/models/tab_model.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../objectbox.g.dart';

late ObjectBox objectbox;

class ObjectBox {
  /// The Store of this app.
  late final Store store;

  ObjectBox._create(this.store) {}

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(
        directory: p.join(
      docsDir.path,
      "bramzo",
    ));
    return ObjectBox._create(store);
  }

  static Future<int> insertData<CustomObjectType>(CustomObjectType person,
      {PutMode mode = PutMode.put}) async {
    var box = objectbox.store.box<CustomObjectType>();

    return box.put(person, mode: mode);
  }

  static Future<bool> deleteSingleData<CustomObjectType>(int id) async {
    var box = objectbox.store.box<CustomObjectType>();
    return box.remove(id);
  }

  static Future<List<CustomObjectType>>
      getAllObjects<CustomObjectType>() async {
    var box = objectbox.store.box<CustomObjectType>();
    return box.query().build().find();
  }

  static Future<int> deleteAllObjects<CustomObjectType>() async {
    var box = objectbox.store.box<CustomObjectType>();
    return box.removeAll();
  }

  static Future<CustomObjectType?> getSingleObject<CustomObjectType>(
    int id,
  ) async {
    var box = objectbox.store.box<CustomObjectType>();
    return box.get(id);
  }

  ////custom

  static Future<TabModel?> getSingleWithLocalId({required int localId}) async {
    var box = objectbox.store.box<TabModel>();
    final query = box.query(TabModel_.localId.equals(localId)).build();
    return query.findFirst();
  }
}
