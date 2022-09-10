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
      appBar: null,
      pane: _getNavigationPane(),
      content: _getContentBody(),
    );
  }

  NavigationAppBar _getAppBar() => const NavigationAppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            'Image editor',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        automaticallyImplyLeading: false,
      );

  NavigationPane _getNavigationPane() => NavigationPane(
        header: FlutterLogo(
          style: FlutterLogoStyle.horizontal,
          size: 100,
        ),
        selected: _selectedIndex,
        onChanged: (value) => setState(() {
          _selectedIndex = value;
        }),
        items: [
          PaneItem(
            icon: Icon(FluentIcons.add),
            title: Text('Add image'),
          ),
          PaneItem(
            icon: Icon(FluentIcons.photo_collection),
            title: Text('Edited images'),
          ),
        ],
      );

  NavigationBody _getContentBody() => NavigationBody(
        index: _selectedIndex,
        children: const [
          AddImageScreen(),
          ImageListScreen(),
        ],
      );
}
