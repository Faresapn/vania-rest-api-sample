import 'package:rest_vania/app/models/vendor.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
  Future<Response> index() async {
    final vendors = await Vendor().query().get();
    return Response.json({'message': 'success', 'data': vendors});
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    var body = request.body;
    var insertVendor = await Vendor().query().insert({
      'vend_id': body['vend_id'],
      'vend_name': body['vend_name'],
      'vend_address': body['vend_address'],
      'vend_kota': body['vend_kota'],
      'vend_state': body['vend_state'],
      'vend_zip': body['vend_zip'],
      'vend_country': body['vend_country'],
    });
    if (insertVendor != null) {
      return Response.json(
          {'message': 'Data berhasil di tambahkan', 'data': body});
    } else {
      return Response.json({'message': 'Data gagal di tambahkan'});
    }
  }

  Future<Response> show(String id) async {
    final vendors = await Vendor().query().where('vend_id', '=', id).first();

    if (vendors == null) {
      return Response.json({'message': 'Data tidak ditemukan'});
    }

    return Response.json({'message': 'Data ditemukan', 'data': vendors});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, id) async {
    await Vendor().query().where('vend_id', '=', id).update({
      'vend_name': request.body['vend_name'],
      'vend_address': request.body['vend_address'],
      'vend_kota': request.body['vend_kota'],
      'vend_state': request.body['vend_state'],
      'vend_zip': request.body['vend_zip'],
      'vend_country': request.body['vend_country'],
    });
    final vendors = await Vendor().query().where('vend_id', '=', id).get();

    return Response.json({'message': 'Data berhasil di update', 'data': vendors});
  }

  Future<Response> destroy( id) async {
    await Vendor().query().where('vend_id', '=', id).delete();
    return Response.json({'message': 'Data berhasil di hapus'});
  }
}

final VendorController vendorController = VendorController();
