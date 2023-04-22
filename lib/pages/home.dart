import 'package:fluent_ui/fluent_ui.dart';
import 'package:image_editor/screens/add_image.dart';
import 'package:image_editor/screens/image_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: _getNavigationPane(),
    );
  }

  NavigationPane _getNavigationPane() => NavigationPane(
        header: const FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 100,
        ),
        selected: _selectedIndex,
        onChanged: (value) => setState(() => _selectedIndex = value),
        items: [
          PaneItem(
            icon: const Icon(FluentIcons.add),
            title: const Text('Add image'),
            body: const AddImageScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.photo_collection),
            title: const Text('Edited images'),
            body: const ImageListScreen(),
          ),
        ],
      );
}
