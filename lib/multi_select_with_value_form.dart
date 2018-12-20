import 'package:flutter/material.dart';

typedef MultiCheckboxCallback(bool value);

class MultiSelectWithValueFormField extends FormField<Map<String, int>> {
  MultiSelectWithValueFormField(
      {FormFieldSetter<Map<String, int>> onSaved,
      FormFieldValidator<Map<String, int>> validator,
      bool autovalidate = false,
      Map<String, int> initialValue = const {},
      List<Map<String, int>> items = const <Map<String, int>>[] // An Empty List
      })
      : super(
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            initialValue: initialValue,
            builder: (FormFieldState<Map<String, int>> state) {
              Container _checkBox(Map<String, int> label,
                  MultiCheckboxCallback callback, Map<String, int> state) {
                if (state == null) {
                  state = new Map<String, int>();
                }
                return Container(
                  width: 150.0,
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: state.containsKey(label.keys.join()),
                        onChanged: callback,
                      ),
                      Text(
                        label.keys.join(),
                        style: new TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14.0),
                      )
                    ],
                  ),
                );
              }

              List<Widget> _items = items.map<Widget>((item) {
                Map<String, int> _item = state.value;
                if (_item.length == 0) {
                  _item = new Map<String, int>();
                }

                return _checkBox(item, (value) {
                  if (value) {
                    _item.addAll(item);
                    state.didChange(_item);
                  } else {
                    _item.remove(item.keys.join());
                    state.didChange(_item);
                  }
                }, state.value);
              }).toList();

              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(direction: Axis.horizontal, children: _items),
                  state.hasError
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            state.errorText,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container()
                ],
              );
            });
}
