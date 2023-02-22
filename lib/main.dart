import 'package:flutter/material.dart';
import 'package:my_first_app/edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      _items = prefs.getStringList("todos") ?? [];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return ListTile(
                onTap: () async {
                  var currentTodo = _items[index];
                  var newTodo = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              AddEditPage(todo: currentTodo)));

                  if (newTodo != null) {
                    var itemIndex = _items.indexOf(currentTodo);
                    _items.removeAt(itemIndex);
                    _items.insert(itemIndex, newTodo);
                    setState(() {});

                    final prefs = await SharedPreferences.getInstance();
                    prefs.setStringList("todos", _items);
                  }
                },
                title: Text(_items[index]),
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      _items.removeAt(index);
                      setState(() {});

                      final prefs = await SharedPreferences.getInstance();
                      prefs.setStringList("todos", _items);
                    }));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var newTodo = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditPage(todo: null)));

          if (newTodo != null) {
            _items.add(newTodo);
            setState(() {});

            final prefs = await SharedPreferences.getInstance();
            prefs.setStringList("todos", _items);
          }
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
