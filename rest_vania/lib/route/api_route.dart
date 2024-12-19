import 'package:rest_vania/app/http/controllers/auth_controller.dart';
import 'package:rest_vania/app/http/controllers/customer_controller.dart';
import 'package:rest_vania/app/http/controllers/order_controller.dart';
import 'package:rest_vania/app/http/controllers/order_item_controller.dart';
import 'package:rest_vania/app/http/controllers/product_controller.dart';
import 'package:rest_vania/app/http/controllers/product_note_controller.dart';
import 'package:rest_vania/app/http/controllers/vendor_controller.dart';
import 'package:vania/vania.dart';
import 'package:rest_vania/app/http/middleware/authenticate.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    Router.group(() {
      // Customer Routes
      Router.get("/customers", customerController.index);
      Router.post("/customers", customerController.store);
      Router.get("/customers/{id}", customerController.show);
      Router.put("/customers/{id}", customerController.update);
      Router.delete("/customers/{id}", customerController.destroy);

      // Vendor Routes
      Router.get("/vendors", vendorController.index);
      Router.post("/vendors", vendorController.store);
      Router.get("/vendors/{id}", vendorController.show);
      Router.put("/vendors/{id}", vendorController.update);
      Router.delete("/vendors/{id}", vendorController.destroy);

      // Product Routes
      Router.get("/products", productController.index);
      Router.post("/products", productController.store);
      Router.get("/products/{id}", productController.show);
      Router.put("/products/{id}", productController.update);
      Router.delete("/products/{id}", productController.destroy);

      // Notes Product Routes
      Router.get("/notes-products", productNoteController.index);
      Router.post("/notes-products", productNoteController.store);
      Router.get("/notes-products/{id}", productNoteController.show);
      Router.put("/notes-products/{id}", productNoteController.update);
      Router.delete("/notes-products/{id}", productNoteController.destroy);

      // Orders Routes
      Router.get("/orders", orderController.index);
      Router.post("/orders", orderController.store);
      Router.get("/orders/{id}", orderController.show);
      Router.put("/orders/{id}", orderController.update);
      Router.delete("/orders/{id}", orderController.destroy);

      // Order Items Routes
      Router.get("/order-items", orderItemController.index);
      Router.post("/order-items", orderItemController.store);
      Router.get("/order-items/{id}", orderItemController.show);
      Router.put("/order-items/{id}", orderItemController.update);
      Router.delete("/order-items/{id}", orderItemController.destroy);
    }, middleware: [AuthenticateMiddleware()]);
  }
}
