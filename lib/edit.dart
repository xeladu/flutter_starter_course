import 'package:flutter/material.dart';

class AddEditPage extends StatefulWidget {
  final String? todo;

  AddEditPage({required this.todo, Key? key}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller.text = widget.todo == null ? "" : widget.todo!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add or edit")),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(controller: _controller)),
              ElevatedButton(child: Text("Save"), onPressed: _save)
            ]));
  }

  void _save() {
    Navigator.of(context).pop(_controller.text);
  }
}
