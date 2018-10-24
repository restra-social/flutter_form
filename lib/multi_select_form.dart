import 'package:flutter/material.dart';

typedef CheckboxCallback(bool value);

class MultiSelectFormField extends FormField<Set<String>> {
  MultiSelectFormField(
      {FormFieldSetter<Set<String>> onSaved,
      FormFieldValidator<Set<String>> validator,
      bool autovalidate = false,
      List<String> items = const <String>[] // An Empty List
      })
      : super(
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<Set<String>> state) {
              Container _checkBox(
                  String label, CheckboxCallback callback, Set<String> state) {
                if (state == null) {
                  state = new Set<String>();
                }
                return Container(
                  width: 150.0,
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: state.contains(label),
                        onChanged: callback,
                      ),
                      Text(
                        label,
                        style: new TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14.0),
                      )
                    ],
                  ),
                );
              }

              List<Widget> _items = items.map<Widget>((item) {
                Set<String> _values = state.value;

                if (_values == null) {
                  _values = new Set<String>();
                } else {
                  _values = state.value;
                }

                return _checkBox(item, (value) {
                  if (value) {
                    _values.add(item);
                    state.didChange(_values);
                  } else {
                    _values.remove(item);
                    state.didChange(_values);
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
