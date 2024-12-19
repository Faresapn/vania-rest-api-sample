import 'package:rest_vania/app/models/order.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {
  Future<Response> index() async {
    final orders = await Order().query().get();
    return Response.json({'message': 'success', 'data': orders});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    var body = request.body;
    var lastOrder =
        await Order().query().orderBy('order_num', 'desc').limit(1).first();

    var newOrderNum = lastOrder != null ? lastOrder['order_num'] + 1 : 1;
    var data = {
      'order_num': newOrderNum,
      'order_date': DateTime.now(),
      'cust_id': body['cust_id'],
    };
    var insertOrder = await Order().query().insert(data);

    if (insertOrder != null) {
      return Response.json(
          {'message': 'Data berhasil di tambahkan', 'data': data});
    } else {
      return Response.json({'message': 'Data gagal di tambahkan'});
    }
  }

  Future<Response> show(int id) async {
    final orders = await Order().query().where('order_num', '=', id).first();

    if (orders == null) {
      return Response.json({'message': 'Data tidak ditemukan'});
    }

    return Response.json({'message': 'Data ditemukan', 'data': orders});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, id) async {
    await Order().query().where('order_num', '=', id).update(
        {'order_date': DateTime.now(), 'cust_id': request.body['cust_id']});
    final orders = await Order().query().where('order_num', '=', id).get();

    return Response.json({'message': 'Data berhasil di update', 'data': orders});
  }

  Future<Response> destroy(id) async {
    await Order().query().where('order_num', '=', id).delete();
    return Response.json({'message': 'Data berhasil di hapus'});
  }
}

final OrderController orderController = OrderController();
