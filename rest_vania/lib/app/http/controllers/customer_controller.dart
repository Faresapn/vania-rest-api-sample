import 'package:vania/vania.dart';
import 'package:rest_vania/app/models/customer.dart';

class CustomerController extends Controller {
  // Mendapatkan semua customers
  Future<Response> index() async {
    final customers = await Customer().query().get();
    return Response.json({'message': 'Data ditemukan', 'data': customers});
  }

  // Menyimpan customer baru
  Future<Response> store(Request request) async {
    // Mengasumsikan request.body sudah dalam format Map dan langsung bisa digunakan
    var body = request.body;
    var insertedCustomer = await Customer().query().insert({
      'cust_id': body['cust_id'],
      'cust_name': body['cust_name'],
      'cust_address': body['cust_address'],
      'cust_city': body['cust_city'],
      'cust_state': body['cust_state'],
      'cust_zip': body['cust_zip'],
      'cust_country': body['cust_country'],
      'cust_telp': body['cust_telp']
    });
    if (insertedCustomer != null) {
      // Mengembalikan response dengan data yang dimasukkan
      // Mengasumsikan bahwa `insertedCustomer` mengembalikan data dalam bentuk yang bisa langsung digunakan
      return Response.json(
          {'message': 'Data berhasil ditambahkan', 'data': body});
    } else {
      return Response.json({'message': 'Data gagal di tambahkan'});
    }
  }

  // Menampilkan customer berdasarkan ID
  Future<Response> show(String id) async {
    final customer = await Customer().query().where('cust_id', '=', id).first();

    if (customer == null) {
      return Response.json({'message': 'Data tidak ditemukan'});
    }

    return Response.json({'message': 'Data ditemukan', 'data': customer});
  }

  // Memperbarui data customer
  Future<Response> update(Request request, String id) async {
    // Asumsi bahwa data dari request sudah dalam bentuk Map

    await Customer().query().where('cust_id', '=', id).update({
      'cust_name': request.body['cust_name'],
      'cust_address': request.body['cust_address'],
      'cust_city': request.body['cust_city'],
      'cust_state': request.body['cust_state'],
      'cust_zip': request.body['cust_zip'],
      'cust_country': request.body['cust_country'],
      'cust_telp': request.body['cust_telp']
    });
    final customers = await Customer().query().where('cust_id', '=', id).get();

    return Response.json({'message': 'Data berhasil di update', 'data': customers});
  }

  // Menghapus customer
  Future<Response> destroy(String id) async {
    await Customer().query().where('cust_id', '=', id).delete();

    return Response.json({'message': 'Data berhasil di hapus'});
  }
}

final CustomerController customerController = CustomerController();
