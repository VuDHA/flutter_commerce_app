import 'package:hive/hive.dart';

part 'tag.g.dart'; // Generated part file

@HiveType(typeId: 6) // Specify the type ID for Hive
class Tag {
  @HiveField(0) // Specify the Hive field number for each attribute
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  Tag({required this.id, required this.title, required this.price});

  // Factory method to create a Tag instance from a JSON map
  factory Tag.fromJson(Map<String, dynamic> data) => Tag(
        id: data['id'],
        title: data['attributes']['title'],
        price: data['attributes']['price'].toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      // Add other necessary fields based on your Product model
    };
  }
}
