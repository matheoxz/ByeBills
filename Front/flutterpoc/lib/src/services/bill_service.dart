import 'dart:convert';
import 'package:flutterpoc/main.dart';
import 'package:flutterpoc/src/models/bill.dart';
import 'package:flutterpoc/src/services/bill_service_abstract.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BillService extends IBillService {
  @override
  Future<List<BillModel>> getAllBills() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? jwt = storage.getString('jwt');
    var res = await http.get(Uri.https(url, 'api/Bill'), headers: {
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": '*'
    });

    List<dynamic> resList = jsonDecode(res.body);
    List<BillModel> returnList = [];
    for (Map<String, dynamic> item in resList) {
      returnList.add(BillModel.fromMap(item));
    }
    return returnList;
  }

  @override
  Future<bool> deleteBill(int id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? jwt = storage.getString('jwt');
    print(jwt);
    var res = await http.delete(Uri.https(url, 'api/Bill/$id'), headers: {
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": '*'
    });

    return res.statusCode == 204 ? true : false;
  }

  @override
  Future<BillModel> getBill(int id) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? jwt = storage.getString('jwt');
    var res = await http.get(Uri.https(url, 'api/Bill/$id'), headers: {
      'Authorization': 'Bearer $jwt',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": '*'
    });

    BillModel returnedBill = BillModel.fromJson(res.body);
    return returnedBill;
  }

  @override
  Future<bool> postBill(BillModel bill) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? jwt = storage.getString('jwt');
    var res = await http.post(Uri.https(url, 'api/Bill'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": '*',
        },
        body: jsonEncode({
          "name": bill.name,
          "description": bill.description,
          "payday": bill.payday.toIso8601String(),
          "value": bill.value,
          "barcode": bill.barcode,
        }));

    return res.statusCode == 200 ? true : false;
  }

  @override
  Future<bool> putBill(BillModel bill) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    String? jwt = storage.getString('jwt');
    var res = await http.put(Uri.https(url, 'api/Bill/${bill.id}'),
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Access-Control-Allow-Origin": '*',
        },
        body: jsonEncode({
          "id": "${bill.id}",
          "name": "${bill.name}",
          "description": "${bill.description}",
          "payday": "${bill.payday.toIso8601String()}",
          "value": "${bill.value}",
          "barcode": "${bill.barcode}",
        }));

    return res.statusCode == 200 ? true : false;
  }
}
