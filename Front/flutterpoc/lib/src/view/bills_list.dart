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
    return Scaffold(
        appBar: _appBar(),
        body: _body(),
        floatingActionButton: FloatingActionButton(
          onPressed: onNewBill,
          child: Icon(Icons.add),
          backgroundColor: Colors.teal.shade800,
        ));
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
            children: [
              for (var item in bills)
                _listTile(item.id, item.name, item.value, item.payday)
            ],
          ),
          width: widgetWidth),
    );
  }

  _listTile(int id, String title, double value, DateTime expire) {
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
        height: MediaQuery.of(context).size.height / 10,
        child: Center(
          child: ListTile(
            title: Text(title),
            trailing: Column(children: [
              Text('R\$${value.toStringAsFixed(2)}'),
              Text('${expire.day}/${expire.month}/${expire.year}')
            ]),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.amber,
          icon: Icons.edit,
          onTap: () => onSelect(id),
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

  _edit() {}
}
