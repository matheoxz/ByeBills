import 'package:flutterpoc/src/models/bill.dart';

abstract class IBillService {
  Future<List<BillModel>> getAllBills();
  Future<BillModel> getBill(int id);
  Future<bool> postBill(BillModel bill);
  Future<bool> putBill(BillModel bill);
  Future<bool> deleteBill(int id);
}
