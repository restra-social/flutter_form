import 'package:flutter/material.dart';
import 'package:flutter_form/image_picker_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Form Key
  final _formKey = GlobalKey<FormState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //double _width = MediaQuery.of(context).size.width;

    return MaterialApp(
        title: 'Flutter Demo',
        home: Scaffold(
          appBar: new AppBar(
            title: Text("Flutter App"),
          ),
          body: Form(
              key: _formKey,
              child: new ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    ImagePickerForm(placeholder: AssetImage("assets/img/no-item-picture.png"),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: new Text(
                        "Information",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Description'),
                    ),
                  ])),
        ));
  }
}
