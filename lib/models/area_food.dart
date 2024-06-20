class Food {
  final String name;            // The Phoenix Hotel Yogyakarta
  final String description;     // Historic hotel combining colonial charm and modern comfort in central Yogyakarta.
  final String imagePath;       // lib/images/yogyakarta.jpg
  final double price;           // $73
  final hotelCategory category; // Hotel
  List<Addon> availableAddons;  // [ Guided city tours, cultural performances, airport transfer, traditional Javanese massage, bicycle rental ]

  Food({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });

}

// CATEGORIES
enum hotelCategory {
  historical,
  beach,
  nature,
  resort,
  modern,
}

// ADD ONS

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}