

class TouristSpot {
  final int id;
  final String name;
  final String description;
  final String travelGuide;
  final double rating;
  final String imageUrl; 
  final String mapUrlPlaceholder; 

  const TouristSpot({
    required this.id,
    required this.name,
    required this.description,
    required this.travelGuide,
    required this.rating,
    required this.imageUrl,
    required this.mapUrlPlaceholder,
  });
}