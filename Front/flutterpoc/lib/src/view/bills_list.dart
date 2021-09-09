import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterpoc/src/models/bill.dart';

class BillsList extends StatefulWidget {
  final Function() onNewBill;
  final Function() onConfigurations;
  final Function(int id) onSelect;

  const BillsList(
      {Key? key,
      required this.onConfigurations,
      required this.onNewBill,
      required this.onSelect})
      : super(key: key);

  @override
  _BillsListState createState() => _BillsListState(
        onConfigurations: onConfigurations,
        onNewBill: onNewBill,
        onSelect: onSelect,
      );
}

class _BillsListState extends State<BillsList> {
  final Function() onNewBill;
  final Function() onConfigurations;
  final Function(int id) onSelect;
  _BillsListState(
      {required this.onConfigurations,
      required this.onNewBill,
      required this.onSelect});

  List<BillModel> bills = [
    BillModel(1, "AAAA", "description", DateTime.now(), 20.0, "654654654"),
    BillModel(2, "BBBB", "description", DateTime.now(), 500.0, "654654654"),
    BillModel(3, "CCCC", "description", DateTime.now(), 1000.0, "654654654"),
    BillModel(4, "DDDD", "description", DateTime.now(), 5.0, "654654654"),
    BillModel(5, "AAAA", "description", DateTime.now(), 20.0, "654654654"),
    BillModel(6, "BBBB", "description", DateTime.now(), 500.0, "654654654"),
    BillModel(7, "CCCC", "description", DateTime.now(), 1000.0, "654654654"),
    BillModel(8, "DDDD", "description", DateTime.now(), 5.0, "654654654"),
    BillModel(9, "AAAA", "description", DateTime.now(), 20.0, "654654654"),
    BillModel(10, "BBBB", "description", DateTime.now(), 500.0, "654654654"),
    BillModel(11, "CCCC", "description", DateTime.now(), 1000.0, "654654654"),
    BillModel(12, "DDDD", "description", DateTime.now(), 5.0, "654654654"),
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Scaffold(
            appBar: _appBar(),
            body: _body(),
            floatingActionButton: FloatingActionButton(
              onPressed: onNewBill,
              child: Icon(Icons.add),
              backgroundColor: Colors.teal.shade800,
            ));
      }
      if (snapshot.hasError) {
        return Scaffold(appBar: _appBar(), body: _hasError());
      }
      return Scaffold(appBar: _appBar(), body: _isWaitingResponse());
    });
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.teal.shade400,
      title: Text("bills"),
      actions: [
        IconButton(onPressed: onConfigurations, icon: Icon(Icons.settings))
      ],
    );
  }

  _body() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double widgetWidth = width > height ? width / 2 : width;
    return Center(
      child: Container(
          child: ListView(
            children: [for (var item in bills) _listTile(item)],
          ),
          width: widgetWidth),
    );
  }

  _listTile(BillModel bill) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 2.0, color: Colors.grey.shade100),
          ),
        ),
        height: 80,
        child: Center(
          child: ListTile(
            title: Text(
              bill.name,
              style: TextStyle(fontSize: 20),
            ),
            trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'R\$${bill.value.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                      '${bill.payday.day}/${bill.payday.month}/${bill.payday.year}')
                ]),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.amber,
          icon: Icons.edit,
          onTap: () => onSelect(bill.id),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _delete(),
        ),
      ],
    );
  }

  _delete() {}

  _hasError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "😞",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'We coudn\'t complete the request',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  _isEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "😅",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            'You still have no bills to show',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  _isWaitingResponse() {
    List<String> emojis = [
      '💰',
      '💸',
      '🤑',
      '💳',
      '💵',
      '💲',
      '📄',
      '📆',
      '📅',
      '💱'
    ];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            (emojis..shuffle()).first,
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }
}
