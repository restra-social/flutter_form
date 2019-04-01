import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter/services.dart';

class AvatarPickerForm extends FormField<ImageProvider> {
  static Future<ImageProvider> getImage() async {
    final _assets = await MultiImagePicker.pickImages(
      maxImages: 1,
      enableCamera: true,
      cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
    );
    for (var image in _assets) {
      await image.requestThumbnail(400, 200, quality: 80);
    }

    if (_assets.length > 0) {
      return MemoryImage(_assets[0].thumbData.buffer.asUint8List());
    }
    return null;
  }

  AvatarPickerForm({
    FormFieldSetter<ImageProvider> onSaved,
    FormFieldValidator<ImageProvider> validator,
    ImageProvider initialValue,
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<ImageProvider> state) {
              return Container(
                  child: Center(
                child: Stack(
                  fit: StackFit.passthrough,
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          image: new DecorationImage(
                            image: state.value ?? initialValue,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          color: Color(0x66e0e1e1)),
                    ),
                    Container(
                      height: 100.0,
                      width: 100.0,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            height: 30.0,
                            padding: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                                color: Color(0xFFe73a5d),
                                shape: BoxShape.circle),
                            child: IconButton(
                              icon: state.value != null
                                  ? Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 14.0,
                                    )
                                  : Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                              onPressed: () {
                                var images = getImage();
                                images
                                    .then((images) => state.didChange(images));
                              },
                            )),
                      ),
                    ),
                  ],
                ),
              ));
            });
}

/*

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AvatarPickerForm extends FormField<Image> {
  static Future<Image> getImage() async {
    final _assets = await MultiImagePicker.pickImages(maxImages: 4);
    for (var image in _assets) {
      await image.requestThumbnail(400, 200, 80);
    }

    if (_assets.length > 0) {
      return _assets;
    }
    return null;
  }

  AvatarPickerForm({
    FormFieldSetter<Image> onSaved,
    FormFieldValidator<Image> validator,
    Image initialValue = const <Asset>[],
    bool autovalidate = false,
  }) : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidate: autovalidate,
      builder: (FormFieldState<Image> state) {
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
