import 'package:hive/hive.dart';
import 'product.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 5)
class CartItem extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  Product product;

  @HiveField(2)
  int quantity;

  CartItem({required this.id, required this.product, required this.quantity});
}
