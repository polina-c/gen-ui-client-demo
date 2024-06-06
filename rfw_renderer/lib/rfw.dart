import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwContent extends StatelessWidget {
  const RfwContent({super.key, required this.frameId});

  final String? frameId;

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('before'),
        SizedBox(
          width: 300,
          height: 300,
          child: Example(),
        ),
        Text('after'),
      ],
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

  // @override
  // void reassemble() {
  //   // This function causes the Runtime to be updated any time the app is
  //   // hot reloaded, so that changes to _createLocalWidgets can be seen
  //   // during development. This function has no effect in production.
  //   super.reassemble();
  //   _update();
  // }

  // static const LibraryName localName = LibraryName(<String>['local']);
  // static const LibraryName remoteName = LibraryName(<String>['remote']);

  // void _update() {
  //   _runtime.update(localName, _createLocalWidgets());
  //   // Normally we would obtain the remote widget library in binary form from a
  //   // server, and decode it with [decodeLibraryBlob] rather than parsing the
  //   // text version using [parseLibraryFile]. However, to make it easier to
  //   // play with this sample, this uses the slower text format.
  //   _runtime.update(remoteName, parseLibraryFile('''
  //     import local;
  //     widget root = GreenBox(
  //       child: Hello(name: "World"),
  //     );
  //   '''));
  // }

  // static WidgetLibrary _createLocalWidgets() {
  //   return LocalWidgetLibrary(<String, LocalWidgetBuilder>{
  //     'GreenBox': (BuildContext context, DataSource source) {
  //       return ColoredBox(
  //         color: const Color(0xFF002211),
  //         child: source.child(<Object>['child']),
  //       );
  //     },
  //     'Hello': (BuildContext context, DataSource source) {
  //       return Center(
  //         child: Text(
  //           'Hello, ${source.v<String>(<Object>["name"])}!',
  //           textDirection: TextDirection.ltr,
  //         ),
  //       );
  //     },
  //   });
  // }

  // Normally this would be obtained dynamically, but for this example
  // we hard-code the "remote" widgets into the app.
  //
  // Also, normally we would decode this with [decodeLibraryBlob] rather than
  // parsing the text version using [parseLibraryFile]. However, to make it
  // easier to demo, this uses the slower text format.
  static final RemoteWidgetLibrary _remoteWidgets = parseLibraryFile('''
    // The "import" keyword is used to specify dependencies, in this case,
    // the built-in widgets that are added by initState below.
    import core.widgets;
    // The "widget" keyword is used to define a new widget constructor.
    // The "root" widget is specified as the one to render in the build
    // method below.
    widget root = Container(
      color: 0xFF002211,
      child: Center(
        child: Text(text: "Hello, World!"),
      ),
    );
  ''');

  static const LibraryName coreName = LibraryName(<String>['core', 'widgets']);
  static const LibraryName mainName = LibraryName(<String>['main']);

  @override
  void initState() {
    super.initState();
    // Local widget library:
    _runtime.update(coreName, createCoreWidgets());
    // Remote widget library:
    _runtime.update(mainName, _remoteWidgets);
    // Configuration data:
    _data.update('greet', <String, Object>{'name': 'World'});
  }

  @override
  Widget build(BuildContext context) {
    return RemoteWidget(
      runtime: _runtime,
      data: _data,
      widget: const FullyQualifiedWidgetName(mainName, 'root'),
      onEvent: (String name, DynamicMap arguments) {
        // The example above does not have any way to trigger events, but if it
        // did, they would result in this callback being invoked.
        debugPrint('user triggered event "$name" with data: $arguments');
      },
    );
  }
}
