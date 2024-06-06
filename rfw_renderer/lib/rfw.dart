import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwContent extends StatelessWidget {
  const RfwContent({super.key, required this.frameId});

  final String? frameId;

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 150,
      child: Example(),
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
import core.widgets;
import core.material;

widget root = Container(
  color: 0xFF66AACC,
  child: Center(
    child: Button(
      child: Padding(
        padding: [ 20.0 ],
        child: Text(text: data.counter, style: {
          fontSize: 56.0,
          color: 0xFF000000,
        }),
      ),
      onPressed: event 'increment' { },
    ),
  ),
);

widget Button { down: false } = GestureDetector(
  onTap: args.onPressed,
  onTapDown: set state.down = true,
  onTapUp: set state.down = false,
  onTapCancel: set state.down = false,
  child: Container(
    duration: 50,
    margin: switch state.down {
      false: [ 0.0, 0.0, 2.0, 2.0 ],
      true: [ 2.0, 2.0, 0.0, 0.0 ],
    },
    padding: [ 12.0, 8.0 ],
    decoration: {
      type: "shape",
      shape: {
        type: "stadium",
        side: { width: 1.0 },
      },
      gradient: {
        type: "linear",
        begin: { x: -0.5, y: -0.25 },
        end: { x: 0.0, y: 0.5 },
        colors: [ 0xFFFFFF99, 0xFFEEDD00 ],
        stops: [ 0.0, 1.0 ],
        tileMode: "mirror",
      },
      shadows: switch state.down {
        false: [ { blurRadius: 4.0, spreadRadius: 0.5, offset: { x: 1.0, y: 1.0, } } ],
        default: [],
      },
    },
    child: DefaultTextStyle(
      style: {
        color: 0xFF000000,
        fontSize: 32.0,
      },
      child: args.child,
    ),
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
