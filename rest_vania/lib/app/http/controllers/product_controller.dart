import 'package:rest_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {

     Future<Response> index() async {
      final product = await Product().query().get();
      return Response.json({'message': 'Data ditemukan', 'data': product});
     }

     Future<Response> create() async {
          return Response.json({});
     }

     Future<Response> store(Request request) async {
        var body = request.body;
        var insertProduct = await Product().query().insert({
          'prod_id': body['prod_id'],
          'vend_id': body['vend_id'],
          'prod_name': body['prod_name'],
          'prod_price': body['prod_price'],
          'prod_desc': body['prod_desc'],
        });
        if (insertProduct != null) {
          return Response.json(
              {'message': 'Data berhasil di tambahkan', 'data': body});
        } else {
          return Response.json({'message': 'Data gagal di tambahkan'});
        }
     }

     Future<Response> show(String id) async {
      final producct = await Product().query().where('prod_id', '=', id).first();

      if (producct == null) {
        return Response.json({'message': 'Data tidak ditemukan'});
      }

      return Response.json({'message': 'Data ditemukan', 'data': producct});
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,String id) async {
      await Product().query().where('prod_id', '=', id).update({
          'prod_name': request.body['prod_name'],
          'prod_price': request.body['prod_price'],
          'prod_desc': request.body['prod_desc'],
      });
      final products = await Product().query().where('prod_id', '=', id).get();

      return Response.json({'message': 'Data berhasil di update', 'data': products});
     }

     Future<Response> destroy( id) async {
      await Product().query().where('prod_id', '=', id).delete();
      return Response.json({'message': 'Data berhasil di hapus'});
     }
}

final ProductController productController = ProductController();

