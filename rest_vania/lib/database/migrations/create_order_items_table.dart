import 'package:vania/vania.dart';

class CreateOrderItemsTable extends Migration {
  @override
  Future<void> up() async {
        super.up();
    await createTableNotExists('order_items', () {
      bigInt('order_item');
      primary('order_item');
      bigInt('order_num');
      foreign('order_num', 'orders', 'order_num', constrained: true, onDelete: 'CASCADE');
      char('prod_id', length: 10);
      foreign('prod_id', 'products', 'prod_id', constrained: true, onDelete: 'CASCADE');
      integer('quantity');
      integer('size');
    });
  }
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('order_items');
  }
}
