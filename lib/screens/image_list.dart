import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:path_provider/path_provider.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({Key? key}) : super(key: key);

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      content: FutureBuilder<List<String>>(
        future: _getImageList(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: ProgressRing());
          }
          if (snapshot.hasError) return const Center(child: Text('Error'));
          return Container(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (ctx, index) {
                  final file = File(snapshot.data![index]);
                  return Card(
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  Future<List<String>> _getImageList() async {
    List<String> imagePathList = [];
    final tempDir = await getApplicationSupportDirectory();
    final imagePaths = tempDir.listSync(followLinks: false, recursive: false);
    for (var e in imagePaths) {
      if (e.path.endsWith('.DS_Store')) continue;
      imagePathList.add(e.path);
    }
    return imagePathList;
  }
}
