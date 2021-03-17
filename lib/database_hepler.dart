import 'package:path/path.dart';
import 'package:simple_parking_app/place_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  Future<Database> database() async
  {
    return openDatabase(
      join(await getDatabasesPath(), 'parkingPlaces.db'),

      onCreate: (db, version) async
        {
          await db.execute("CREATE TABLE places(id INTEGER PRIMARY KEY, name TEXT, lat TEXT, lon TEXT, description TEXT, rating INTEGER)");
          return db;
        },
        version: 1,
    );
  }

  Future<int> addPlace(ParkingPlace place) async
  {
    var id = 0;

    var _db = await database();
    await _db.insert('places',
        place.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace).then((value) {
          id = value;
    });

    return id;
  }

  Future<List<ParkingPlace>> getPlaces() async
  {
    Database _db = await database();
    List<Map<String, dynamic>> placesMap = await _db.query('places');
    return List.generate(placesMap.length, (index) {
      return ParkingPlace(placesMap[index]['id'], placesMap[index]['name'], placesMap[index]['lat'],  placesMap[index]['lon'], placesMap[index]['description'], placesMap[index]["rating"]);
    });
  }

}