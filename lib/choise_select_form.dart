import 'package:flutter/material.dart';

class ChoiseSelectFormField extends FormField<int> {
  ChoiseSelectFormField(
      {FormFieldSetter<int> onSaved,
      FormFieldValidator<int> validator,
      int initialValue = 0,
      bool autovalidate = false,
      List<String> items = const <String>[] // An Empty List
      })
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<int> state) {
              Container _radioButton(
                  String label, int value, int updatedValue) {
                return Container(
                  width: 120.0,
                  child: Row(
                    children: <Widget>[
                      Radio(
                        groupValue: updatedValue,
                        value: value,
                        onChanged: (val) {
                          state.didChange(val);
                        },
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

              var itemCount = 0;
              List<Widget> _items = items.map<Widget>((item) {
                itemCount++;
                return _radioButton(item, itemCount, state.value);
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
