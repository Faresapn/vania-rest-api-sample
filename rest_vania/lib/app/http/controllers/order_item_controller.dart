import 'package:rest_vania/app/models/order_item.dart';
import 'package:vania/vania.dart';

class OrderItemController extends Controller {

     Future<Response> index() async {
      final orders_item = await OrderItem().query().get();
      return Response.json({'message': 'success', 'data': orders_item});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
      var body = request.body;
      var lastOrder = await OrderItem().query().orderBy('order_item', 'desc').limit(1).first();

      var newOrderItem = lastOrder != null ? lastOrder['order_item'] + 1 : 1;
      var orderinsert = await OrderItem().query().insert({
        'order_item': newOrderItem,
        'order_num': body['order_num'],
        'prod_id': body['prod_id'],
        'quantity': body['quantity'],
        'size': body['size'],
      });
      if (orderinsert != null) {  
        return Response.json(
            {'message': 'Data berhasil di tambahkan', 'data': body});
      } else {
        return Response.json({'message': 'Data gagal di tambahkan'});
      }
     }

     Future<Response> show(int id) async {
      final order_items = await OrderItem().query().where('order_item', '=', id).first();

      if (order_items == null) {
        return Response.json({'message': 'Data tidak ditemukan'});
      }

      return Response.json({'message': 'Data ditemukan', 'data': order_items});
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int id) async {
      await OrderItem().query().where('order_item', '=', id).update({
        'prod_id': request.body['prod_id'],
        'quantity': request.body['quantity'],
        'size': request.body['size'],
      });
      final order_items = await OrderItem().query().where('order_item', '=', id).get();

      return Response.json({'message': 'Data berhasil di update', 'data': order_items});
     }

     Future<Response> destroy(int id) async {
      await OrderItem().query().where('order_item', '=', id).delete();
      return Response.json({'message': 'Data berhasil di hapus'});
     }
}

final OrderItemController orderItemController = OrderItemController();

