import 'package:flutter/material.dart';

import 'common/db_helper/objectbox_class.dart';
import 'my_application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return ErrorWidget(details.exception);
  };

  runApp(const MyApplication());
}

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<String> _items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4'
  ];

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(index, animation),
    );
    _items.insert(_items.length, "element");
    _listKey.currentState!.insertItem(_items.length - 1);
    setState(() {});
  }

  Widget _buildItem(int index, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Container(
        color: Colors.red,
        margin: EdgeInsets.all(10),
        child: ScaleTransition(
          scale: animation,
          child: Card(
            child: ListTile(
              title: Text(_items[index]),
              onTap: () => _removeItem(index),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    _items.insert(_items.length, "element");
                    _listKey.currentState!.insertItem(2);
                  },
                  child: Text("addd")),
              Expanded(
                child: AnimatedList(
                  key: _listKey,
                  physics: BouncingScrollPhysics(),
                  initialItemCount: _items.length,
                  itemBuilder: (context, index, animation) {
                    return _buildItem(index, animation);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
