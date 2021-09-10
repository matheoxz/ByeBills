import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpoc/config/get_it_registrations.dart';
import 'package:flutterpoc/src/misc/currency_formatter.dart';
import 'package:flutterpoc/src/models/bill.dart';
import 'package:flutterpoc/src/services/bill_service_abstract.dart';

class BillDetail extends StatefulWidget {
  final int billId;
  final Function() onBack;

  BillDetail({Key? key, required this.billId, required this.onBack})
      : super(key: key);

  @override
  _BillDetailState createState() =>
      _BillDetailState(billId: billId, onBack: onBack);
}

class _BillDetailState extends State<BillDetail> {
  final billId;
  final Function() onBack;
  late IBillService billService;

  _BillDetailState({required this.billId, required this.onBack}) {
    billService = getIt<IBillService>();
  }

  BillModel? bill;

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _dateTimeController = TextEditingController();

  DateTime? _dateTime;

  final _valueController = TextEditingController();

  final _barcodeController = TextEditingController();

  String title = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        key: UniqueKey(),
        future: billService.getBill(billId),
        builder: (context, AsyncSnapshot<BillModel> snapshot) {
          if (snapshot.hasData) {
            if (bill == null) {
              bill = snapshot.data!;
              title = bill!.name;
              _nameController.text = bill!.name;
              _descriptionController.text = bill!.description;
              _dateTime = bill!.payday;
              _dateTimeController.text =
                  "${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}";
              _valueController.text = "R\$ ${bill!.value.toStringAsFixed(2)}";
              _barcodeController.text = bill!.barcode;
            }

            return Scaffold(
              appBar: _appBar(),
              body: _body(context),
            );
          } else if (snapshot.hasError) {
            title = '😞';
            return Scaffold(
              appBar: _appBar(),
              body: _hasError(),
            );
          }
          title = '';
          return Scaffold(
            appBar: _appBar(),
            body: _isWaitingResponse(),
          );
        });
  }

  _appBar() {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.teal.shade300,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: onBack,
      ),
    );
  }

  _body(context) {
    return Padding(
      padding: EdgeInsets.all(25),
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: _form(context),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _form(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _textFields(),
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _updateBillButton(),
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
        _sizedBox(),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _deleteBillButton(),
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
      ],
    );
  }

  final _formKey = GlobalKey<FormState>();

  _textFields() {
    return Flexible(
      child: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          children: [
            _field(_nameController, _nameValidation, "name", Icons.tag),
            _sizedBox(),
            _field(_descriptionController, _nameValidation, "description",
                Icons.text_fields,
                maxLines: 5),
            _sizedBox(),
            _datePicker(context),
            _sizedBox(),
            _currencyField(),
            _sizedBox(),
            _field(
              _barcodeController,
              _nameValidation,
              "barcode",
              Icons.qr_code,
            )
          ],
        ),
      ),
    );
  }

  TextFormField _field(TextEditingController controller,
      String? Function(String?) validator, String label, IconData icon,
      {bool password = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.text,
      obscureText: password,
      maxLines: maxLines,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(icon)),
    );
  }

  _datePicker(BuildContext context) {
    return TextFormField(
      controller: _dateTimeController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "expirations date",
        labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        prefixIcon: Icon(Icons.calendar_today),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        _dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100));
        _dateTimeController.text =
            '${_dateTime!.day}/${_dateTime!.month}/${_dateTime!.year}';
      },
    );
  }

  _currencyField({String locale = 'pt-br'}) {
    return TextFormField(
      controller: _valueController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CurrencyInputFormatter(locale)
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "\$0,00",
          labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(Icons.money)),
    );
  }

  String? _nameValidation(String? value) {
    if (value!.isEmpty) return ('Invalid field');
    return null;
  }

  _updateBillButton() {
    return TextButton(
      onPressed: _updateBill,
      child: Text(
        "update",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade400,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  _deleteBillButton() {
    return TextButton(
      onPressed: _deleteBill,
      child: Text(
        "delete",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.red.shade400,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  _updateBill() async {
    if (_formKey.currentState!.validate()) {
      try {
        String doubleToParse = _valueController.text
            .replaceRange(0, 1, '')
            .replaceFirst(RegExp(r'\$'), '')
            .replaceAll(RegExp(r'\.'), '')
            .replaceFirst(RegExp(r','), '.')
            .trim();

        bool res = await billService.putBill(BillModel(
            billId,
            _nameController.text,
            _descriptionController.text,
            _dateTime!,
            double.parse(doubleToParse),
            _barcodeController.text));

        if (res)
          onBack();
        else
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.amber,
            content: Text('error'),
            elevation: 5.0,
          ));
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.amber,
          content: Text('error'),
          elevation: 5.0,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.amber,
        content: Text("invalid fields, please fill it correctly"),
        elevation: 5.0,
      ));
    }
  }

  _deleteBill() async {
    try {
      bool res = await billService.deleteBill(billId);

      if (res)
        onBack();
      else
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.amber,
          content: Text("error on delete, try again later"),
          elevation: 5.0,
        ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.amber,
        content: Text("error on delete, try again later"),
        elevation: 5.0,
      ));
    }
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
            'I think this bill doesn\'t exist',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
