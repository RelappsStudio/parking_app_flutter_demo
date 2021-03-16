class ParkingPlace{
  final int id;
  final String name;
  final String lat;
  final String lon;
  final String description;
  final int rating;

  ParkingPlace(this.id, this.name, this.lat, this.lon, this.description, this.rating);

  Map<String, dynamic> toMap()
  {
    return {
      'id' : id,
      'name' : name,
      'lat' : lat,
      'lon' : lon,
      'description' : description,
      'rating' : rating
    };
  }

}