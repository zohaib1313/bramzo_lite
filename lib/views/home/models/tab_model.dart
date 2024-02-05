class TabModel {
  int id;
  String value;
  bool isCheckedOff;

  TabModel({
    required this.id,
    required this.value,
    this.isCheckedOff = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          value == other.value &&
          isCheckedOff == other.isCheckedOff;

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ isCheckedOff.hashCode;

  @override
  String toString() {
    return 'TabModel{id: $id, value: $value, isCheckedOff: $isCheckedOff}';
  }
}
