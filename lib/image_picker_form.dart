import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form/elements/carosal.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ImagePickerForm extends FormField<List<Asset>> {
  ImagePickerForm({
    FormFieldSetter<List<Asset>> onSaved,
    FormFieldValidator<List<Asset>> validator,
    List<Asset> initialValue = const <Asset>[],
    bool autovalidate = false,
    ImageProvider placeholder,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<List<Asset>> state) {
              Future<List<Asset>> getImage() async {

                List<Asset> _assets = List<Asset>();
                try {
                  _assets = await MultiImagePicker.pickImages(
                    maxImages: 4,
                    enableCamera: true,
                    cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                  );
                } on PlatformException catch (e) {
                  print(e.message);
                }


                for (var image in _assets) {
                  await image.requestThumbnail(400, 200, quality: 80);
                }

                if (_assets.length > 0) {
                  return _assets;
                }
                return null;
              }

              List<Widget> _images = <Widget>[];
              final _itemCount = state.value.length;
              if (_itemCount > 0) {
                // Add to list
                for (var index = 0; index < _itemCount; index++) {
                  _images.add(Container(
                    width: 380.0,
                    margin: new EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: SliderCard(
                      memoryImage: state.value[index],
                      placeholder: placeholder,
                    ),
                  ));
                }
              }
              _images.add(GestureDetector(
                  onTap: () {
                    var images = getImage();
                    images.then((images) => state.didChange(images));
                  },
                  child: ClipRRect(
                    borderRadius:
                        new BorderRadius.all(new Radius.circular(5.0)),
                    child: Container(
                      width: 550.0,
                      child: Center(
                        child: Text("Upload Image"),
                      ),
                      decoration: BoxDecoration(color: Color(0x88e0e1e1)),
                    ),
                  )));
              return CarouselSlider(
                items: _images,
                //autoPlay: true,
                viewportFraction: 0.8,
                aspectRatio: 2.0,
              );
            });
}

class SliderCard extends StatelessWidget {
  ImageProvider placeholder;
  Asset memoryImage;
  SliderCard({this.memoryImage, this.placeholder});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ClipRRect(
        borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        child: Container(
          child: FadeInImage(
            placeholder: placeholder,
            image: AssetThumbImageProvider(memoryImage),
            fit: BoxFit.cover,
          ),
        ));
  }
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
