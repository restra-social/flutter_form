import 'package:flutter_form/elements/date_time_picker.dart';
import 'package:flutter/material.dart';

class DateTimeFormField extends FormField<TimeOfDay> {
  DateTimeFormField(
      {FormFieldSetter<TimeOfDay> onSaved,
      FormFieldValidator<TimeOfDay> validator,
      TimeOfDay initialValue = const TimeOfDay(hour: 0, minute: 0),
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<TimeOfDay> state) {
              return new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTimePicker(
                    onTimePick: (time) {
                      state.didChange(time);
                      //print(state.value);
                    },
                    initTime: state.value,
                  ),
                  state.hasError
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            state.errorText,
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : Container(),
                ],
              );
            });
}

typedef void OnTimePickerSelected(TimeOfDay time);

class CustomTimePicker extends StatefulWidget {
  TimeOfDay initTime;
  final OnTimePickerSelected onTimePick;
  CustomTimePicker({this.initTime, this.onTimePick});

  _CustomTimePicker createState() => _CustomTimePicker();
}

class _CustomTimePicker extends State<CustomTimePicker> {
  TimeOfDay _currentTime = new TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    if (widget.initTime != null) {
      _currentTime = widget.initTime;
    }

    TimePicker _timePicker = new TimePicker(
      selectedTime: _currentTime,
      selectTime: (time) {
        setState(() {
          _currentTime = time;
          widget.onTimePick(time);
          widget.initTime = null;
        });
      },
    );

    // TODO: implement build
    return new GestureDetector(
      onTap: () {
        _timePicker.pickTime(context);
      },
      child: new Row(
        children: <Widget>[
          new Icon(
            Icons.access_time,
            size: 18.0,
            color: Colors.black,
          ),
          new Text(' ' + _currentTime.format(context),
              style: new TextStyle(color: Colors.black))
        ],
      ),
    );
  }
}
