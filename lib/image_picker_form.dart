import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePickerForm extends FormField<List<Asset>> {
  static Future<List<Asset>> getImage() async {
    final _assets = await MultiImagePicker.pickImages(maxImages: 4);
    for (var image in _assets) {
      await image.requestThumbnail(400, 200, 80);
    }

    if (_assets.length > 0) {
      return _assets;
    }
    return null;
  }

  ImagePickerForm({
    FormFieldSetter<List<Asset>> onSaved,
    FormFieldValidator<List<Asset>> validator,
    List<Asset> initialValue = const <Asset>[],
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<List<Asset>> state) {
              Widget _previewImage = new Container();

              if (state.value.length > 0) {
                // Add to list
                final _itemCount = state.value.length;
                _previewImage = new Container(
                  child: Column(
                    children: new List.generate(
                        _itemCount,
                        (index) => Container(
                            padding: EdgeInsets.only(top: 10.0),
                            child: new Container(
                              height: 100.0,
                              decoration: new BoxDecoration(
                                  //color: Color(AppDecorator.PlaceholderColor),
                                  borderRadius: new BorderRadius.circular(5.0),
                                  image: new DecorationImage(
                                    image: new MemoryImage(state
                                        .value[index].thumbData.buffer
                                        .asUint8List()),
                                    fit: BoxFit.cover,
                                  )),
                            ))).toList(),
                  ),
                );
              } else {
                print("WTF");
              }

              return Column(
                children: <Widget>[
                  _previewImage,
                  Container(
                    width: 600.0,
                    child: RaisedButton(
                      onPressed: () {
                        var images = getImage();
                        images.then((images) => state.didChange(images));
                      },
                      child: Text("Add Images"),
                    ),
                  ),
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

/*

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePickerForm extends FormField<List<Asset>> {
  static Future<List<Asset>> getImage() async {
    final _assets = await MultiImagePicker.pickImages(maxImages: 4);
    for (var image in _assets) {
      await image.requestThumbnail(400, 200, 80);
    }

    if (_assets.length > 0) {
      return _assets;
    }
    return null;
  }

  ImagePickerForm({
    FormFieldSetter<List<Asset>> onSaved,
    FormFieldValidator<List<Asset>> validator,
    List<Asset> initialValue = const <Asset>[],
    bool autovalidate = false,
  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidate: autovalidate,
      builder: (FormFieldState<List<Asset>> state) {
        if (state.value.length == 0) {
          return Column(
            children: <Widget>[
              Container(
                width: 600.0,
                child: RaisedButton(
                  onPressed: () {
                    var images = getImage();
                    images.then((images) => state.didChange(images));
                  },
                  child: Text("Add Images"),
                ),
              ),
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
        } else {
          // Add to list
          final _itemCount = state.value.length;
          List<Widget> _uploadedImage = new List.generate(
              _itemCount,
                  (index) => Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new Container(
                    height: 100.0,
                    decoration: new BoxDecoration(
                      //color: Color(AppDecorator.PlaceholderColor),
                        borderRadius: new BorderRadius.circular(5.0),
                        image: new DecorationImage(
                          image: new MemoryImage(state
                              .value[index].thumbData.buffer
                              .asUint8List()),
                          fit: BoxFit.cover,
                        )),
                  ))).toList();
          _uploadedImage.add(Container(
            width: 600.0,
            child: RaisedButton(
              onPressed: () {
                var images = getImage();
                images.then((images) => state.didChange(images));
              },
              child: Text("Add Images"),
            ),
          ));
          return Column(children: _uploadedImage);
        }
      });
}

 */
