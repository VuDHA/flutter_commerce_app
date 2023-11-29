// Class representing a Tag, typically associated with a Product
class Tag {
  // Attributes of a Tag
  final int id; // Unique identifier for the tag
  final String title; // Title or name of the tag
  final double price; // Price associated with the tag

  // Constructor to create a Tag instance
  Tag({required this.id, required this.title, required this.price});

  // Factory method to create a Tag instance from a JSON map
  factory Tag.fromJson(Map<String, dynamic> data) => Tag(
        id: data['id'],
        // Access nested attributes to get the title and price
        title: data['attributes']['title'],
        price: data['attributes']['price'].toDouble(),
      );
}
