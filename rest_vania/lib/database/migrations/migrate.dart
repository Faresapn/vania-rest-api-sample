import 'dart:io';
import 'package:rest_vania/database/migrations/create_customers_table.dart';
import 'package:rest_vania/database/migrations/create_order_items_table.dart';
import 'package:rest_vania/database/migrations/create_orders_table.dart';
import 'package:rest_vania/database/migrations/create_personal_access_tokens_table.dart';
import 'package:rest_vania/database/migrations/create_product_notes_table.dart';
import 'package:rest_vania/database/migrations/create_products_table.dart';
import 'package:rest_vania/database/migrations/create_vendors_table.dart';
import 'package:vania/vania.dart';
import 'create_users_table.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  // Method untuk menjalankan semua migrations
  Future<void> registry() async {
    await CreateUserTable()
        .up(); // Anggap CreateUserTable adalah migration valid
    await CreateCustomersTable().up();
    await CreateOrdersTable().up();
    await CreateVendorsTable().up();
    await CreateProductsTable().up();
    await CreateOrderItemsTable().up();
    await CreateProductNotesTable().up();
    await CreatePersonalAccessTokensTable().up();
    
  }

  // Method untuk menghapus semua tabel
  Future<void> dropTables() async {
    await CreateProductNotesTable().down();
    await CreateProductsTable().down();
    await CreateVendorsTable().down();
    await CreateOrderItemsTable().down();
    await CreateOrdersTable().down();
    await CreateCustomersTable().down();
        await CreatePersonalAccessTokensTable().down();

    await CreateUserTable()
        .down(); // Anggap CreateUserTable adalah migration valid
  }
}
