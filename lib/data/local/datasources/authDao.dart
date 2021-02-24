import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/models/auth/Authorization.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:sembast/sembast.dart';

class AuthDao {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _authStore = intMapStoreFactory.store(DBConstants.AUTHORIZATION_STORE);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final Future<Database> _db;

  // Constructor
  AuthDao(this._db);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(Authorization authorization) async {
    return await _authStore.add(await _db, authorization.toMap());
  }

  Future<int> count() async {
    return await _authStore.count(await _db);
  }



  Future<Authorization> getAuthorizationRecord() async {

    print('Loading from database');

    // authorizationRecord
    var authorizationRecord;

    // fetching data
    final recordSnapshots = await _authStore.find(
      await _db,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if(recordSnapshots.length > 0) {
      authorizationRecord = recordSnapshots.first;
    }

    return authorizationRecord;
  }

  Future<int> update(Authorization authorization) async {
    // For filtering by key (ID), RegEx, greater than, and many other criteria,
    // we use a Finder.
    final finder = Finder(filter: Filter.byKey(authorization.id));
    return await _authStore.update(
      await _db,
      authorization.toMap(),
      finder: finder,
    );
  }

  Future<int> delete(Authorization authorization) async {
    final finder = Finder(filter: Filter.byKey(authorization.id));
    return await _authStore.delete(
      await _db,
      finder: finder,
    );
  }

  Future deleteAll() async {
    await _authStore.drop(
      await _db,
    );
  }

}
