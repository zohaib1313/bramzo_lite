import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class TabModel {
  @Id()
  int? id;
  int localId;
  int? index;
  String value;
  bool isVisible;
  bool isCheckedOff;
  FocusNode? focusNode;

  TabModel({
    required this.localId,
    this.index,
    required this.value,
    this.focusNode,
    this.isVisible = true,
    this.isCheckedOff = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TabModel &&
          runtimeType == other.runtimeType &&
          localId == other.localId &&
          focusNode == other.focusNode &&
          value == other.value &&
          isCheckedOff == other.isCheckedOff;

  @override
  int get hashCode => localId.hashCode ^ value.hashCode ^ isCheckedOff.hashCode;

  @override
  String toString() {
    return 'TabModel{id: $id,index: $index, localId: $localId, value: $value, isCheckedOff: $isCheckedOff}';
  }
}
