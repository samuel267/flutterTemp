import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/auth/AuthUser.dart';
import 'package:sembast/sembast.dart';

class AuthUserDao {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _auth_user_store = intMapStoreFactory.store(DBConstants.AUTH_USER_STORE);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Future<Database> _db;

  // Constructor
  AuthUserDao(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(AuthUser authUser) async {
    return await _auth_user_store.add(await _db, authUser.toMap());
  }

  Future<int> count() async {
    return await _auth_user_store.count(await _db);
  }



  Future<AuthUser> getAuthUserRecord() async {

    print('Loading from database');

    // AuthUserRecord
    var authUserRecord;

    // fetching data
    final recordSnapshots = await _auth_user_store.find(
      await _db,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if(recordSnapshots.length > 0) {
      authUserRecord = recordSnapshots.first;
    }

    return authUserRecord;
  }

  Future<int> update(AuthUser authUser) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(authUser.id));
    return await _auth_user_store.update(
      await _db,
      authUser.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(AuthUser authUser) async {
    final finder = Finder(filter: Filter.byKey(authUser.id));
    return await _auth_user_store.delete(
      await _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _auth_user_store.drop(
      await _db,
    );
  }

}
