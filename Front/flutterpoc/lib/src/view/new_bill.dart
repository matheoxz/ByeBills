import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterpoc/src/misc/currency_formatter.dart';

class NewBill extends StatefulWidget {
  final Function() onBack;
  NewBill({Key? key, required this.onBack}) : super(key: key);

  @override
  _NewBillState createState() => _NewBillState(onBack: onBack);
}

class _NewBillState extends State<NewBill> {
  final Function() onBack;

  _NewBillState({required this.onBack});

  final _nameController = TextEditingController();

  final _descriptionController = TextEditingController();

  final _dateTimeController = TextEditingController();

  DateTime? _dateTime;

  final _valueController = TextEditingController();

  final _barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  _appBar() {
    return AppBar(
      title: Text("New Bill"),
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
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: _addBillButton(),
            width: MediaQuery.of(context).size.height / 2,
          ),
        ),
      ],
    );
  }

  _textFields() {
    return Flexible(
      child: Form(
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
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          prefixIcon: Icon(icon)),
    );
  }

  _datePicker(BuildContext context) {
    return TextFormField(
      controller: _dateTimeController,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: "expiration date",
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
        prefixIcon: Icon(Icons.attach_money),
      ),
    );
  }

  String? _nameValidation(String? value) {
    if (value!.isEmpty) return ('Invalid field');
    return null;
  }

  _addBillButton() {
    return TextButton(
      onPressed: _addBill,
      child: Text(
        "add",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      style: TextButton.styleFrom(
          backgroundColor: Colors.teal.shade500,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
          padding: EdgeInsets.all(20)),
    );
  }

  _addBill() {
    onBack();
  }

  _sizedBox({double space = 10}) {
    return SizedBox(height: space, width: space);
  }
}
