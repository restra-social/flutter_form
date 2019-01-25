import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePickerForm extends FormField<List<Asset>> {

  ImagePickerForm({
    FormFieldSetter<List<Asset>> onSaved,
    FormFieldValidator<List<Asset>> validator,
    List<Asset> initialValue = const <Asset>[],
    bool autovalidate = false,
    Axis previewDirection = Axis.vertical,
    double height = 150.0,
    double width = 150.0
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<List<Asset>> state) {
              double singleMinWidthFactor = 0.7;

              Future<List<Asset>> getImage() async {
                final _assets = await MultiImagePicker.pickImages(maxImages: 4);
                for (var image in _assets) {
                  await image.requestThumbnail(400, 200, quality: 80);
                }

                if (_assets.length > 0) {
                  return _assets;
                }
                return null;
              }

              double uploaderWidthFactor = width;

              Widget _previewImage = new Container();
              final _itemCount = state.value.length;
              if (_itemCount > 0) {
                // Add to list
                var calcedWidth = width * (singleMinWidthFactor / _itemCount.toDouble()) - .2;
                _previewImage = Column(
                  children: new List.generate(
                      _itemCount,
                      (index) => Container(
                          padding: EdgeInsets.only(top: 10.0),
                          child: new Container(
                            height: height,
                            width: calcedWidth,
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
                );
                uploaderWidthFactor = width - calcedWidth;
              } else {
                uploaderWidthFactor = width;
              }

              return Column(
                children: <Widget>[
                  Wrap(
                    direction: previewDirection,
                    children: <Widget>[
                      _previewImage,
                      Container(
                          width: uploaderWidthFactor,
                          height: height,
                          child: GestureDetector(
                            onTap: () {
                              var images = getImage();
                              images.then((images) => state.didChange(images));
                            },
                            child: new Container(
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        new BorderRadius.circular(5.0),
                                    color: Color(0x48e0e1e1)),
                                width: width,
                                height: height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Center(
                                      child: new Text(
                                        "Upload an Image",
                                      ),
                                    ),
                                    new Center(
                                      child: new Text(
                                        "(Optional)",
                                      ),
                                    ),
                                  ],
                                )),
                          )),
                    ],
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
