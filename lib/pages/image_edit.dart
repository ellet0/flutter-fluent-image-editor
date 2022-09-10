import 'dart:typed_data';

import 'package:flutter/material.dart' as m;
import 'package:fluent_ui/fluent_ui.dart';
import 'package:image_painter/image_painter.dart';

class ImageEdit extends StatefulWidget {
  const ImageEdit(this.selectedImage, {Key? key}) : super(key: key);

  final Uint8List selectedImage;

  @override
  State<ImageEdit> createState() => _ImageEditState();
}

class _ImageEditState extends State<ImageEdit> {
  final globalKey = GlobalKey<ImagePainterState>();

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: _getAppBar(),
      content: Center(
        child: m.Material(
          child: ImagePainter.memory(widget.selectedImage, key: globalKey),
        ),
      ),
    );
  }

  NavigationAppBar _getAppBar() => NavigationAppBar(
      title: const Text(
        "Edit image",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      leading: Center(
        child: GestureDetector(
          child: const Icon(FluentIcons.back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      actions: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: OutlinedButton(
              child: Text('Done'),
              onPressed: () {
                var editedImage = globalKey.currentState!.exportImage();
                Navigator.pop(context, editedImage);
              }),
        ),
      ));
}
