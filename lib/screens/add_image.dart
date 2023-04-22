import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:image_editor/pages/image_edit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AddImageScreen extends StatefulWidget {
  const AddImageScreen({Key? key}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  Uint8List? _selectedImage;
  String? _imageName;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: Center(
        child: _selectedImage != null
            ? Column(
                children: [
                  Image.memory(_selectedImage!, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                          onPressed: _removeImage,
                          child: const Text('Remove image')),
                      OutlinedButton(
                          onPressed: _editImage,
                          child: const Text('Edit image')),
                      OutlinedButton(
                          onPressed: _saveImage,
                          child: const Text('Save image')),
                    ],
                  )
                ],
              )
            : _getPickImage(),
      ),
    );
  }

  Widget _getPickImage() => GestureDetector(
        onTap: () async {
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (result == null) return;
          _selectedImage = File(result.files.single.path!).readAsBytesSync();
          _imageName = result.names.single;
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              FluentIcons.add,
              size: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text('Add Image')
          ],
        ),
      );

  void _removeImage() => setState(() {
        _selectedImage = null;
      });

  void _editImage() {
    Navigator.push(
      context,
      FluentPageRoute(
        builder: (context) => ImageEdit(_selectedImage!),
      ),
    ).then((value) {
      if (value != null && value is Uint8List) {
        setState(() {
          _selectedImage = value;
        });
      }
    });
  }

  void _saveImage() async {
    final tempDir = await getApplicationSupportDirectory();
    final path =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}${p.extension(_imageName!)}';
    File file = File(path);
    file.writeAsBytesSync(_selectedImage!);
    setState(() {
      _selectedImage = null;
    });
    Future.microtask(() =>
        showSnackbar(context, const Snackbar(content: Text('Image saved'))));
  }
}
