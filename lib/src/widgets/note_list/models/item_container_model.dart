import 'package:equatable/equatable.dart';
import 'package:gnotes/src/models/note.dart';

class ItemContainer extends Equatable {
  final Note note;
  bool selected = false;

  ItemContainer(this.note, {bool selected = false});

  static List<ItemContainer> fromNote(List<Note> list) {
    List<ItemContainer> items = List<ItemContainer>();
    list.forEach((i) {
      items.add((ItemContainer(i)));
    });
    return items;
  }

  @override
  List<Object> get props => [note, selected];
}
