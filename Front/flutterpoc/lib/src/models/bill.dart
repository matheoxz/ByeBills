import 'dart:convert';

class BillModel {
  final int id;
  final String name;
  final String description;
  final DateTime payday;
  final double value;
  final String barcode;

  BillModel(this.id, this.name, this.description, this.payday, this.value,
      this.barcode);

  BillModel copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? payday,
    double? value,
    String? barcode,
  }) {
    return BillModel(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      payday ?? this.payday,
      value ?? this.value,
      barcode ?? this.barcode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'payday': payday.millisecondsSinceEpoch,
      'value': value,
      'barcode': barcode,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      map['id'],
      map['name'],
      map['description'],
      DateTime.fromMillisecondsSinceEpoch(map['payday']),
      map['value'],
      map['barcode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BillModel.fromJson(String source) =>
      BillModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BillModel(id: $id, name: $name, description: $description, payday: $payday, value: $value, barcode: $barcode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BillModel &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.payday == payday &&
        other.value == value &&
        other.barcode == barcode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        payday.hashCode ^
        value.hashCode ^
        barcode.hashCode;
  }
}
