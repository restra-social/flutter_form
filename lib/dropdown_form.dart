import 'package:flutter/material.dart';

class DropDownSelectFormField extends FormField<String> {
  DropDownSelectFormField(
      {FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      String initialValue = "",
      bool autovalidate = false,
      String hintText = "Select", // Default Hint Text
      List<String> items = const <String>[] // An Empty List
      })
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> state) {
              List<DropdownMenuItem<String>> _items = items.map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList();

              return Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new DropdownButton<String>(
                    hint: Text(hintText),
                    value: state.value,
                    items: _items,
                    onChanged: (String val) {
                      state.didChange(val);
                    },
                  ));
            });
}
