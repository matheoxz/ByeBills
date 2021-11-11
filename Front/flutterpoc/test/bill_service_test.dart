import 'package:flutter_test/flutter_test.dart';
import 'package:flutterpoc/src/services/bill_service.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'mock_http.dart';

void main() {
  test('deleteBill returns true', () {
    BaseClient httpMock = MockHttp();
    BillService billService = BillService();
    String url = "localhost:5001";
    int id = 1;
    String jwt = 'testjwt';

    when(httpMock.delete(Uri.https(url, 'api/Bill/$id'), headers: any))
        .thenAnswer((value) async {
      return Response('{}', 204);
    });

    expect(billService.deleteBill(id), isTrue);
  });
}
