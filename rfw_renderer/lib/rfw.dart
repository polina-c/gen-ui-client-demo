import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwContent extends StatelessWidget {
  const RfwContent({super.key, required this.frameId});

  final String? frameId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 180,
      child: Column(
        children: [
          Text('$frameId'),
          if (frameId == 'original') Example() else ImprovedExample(),
        ],
      ),
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
        child: Text(text: ["Hello, ", data.greet.name, "!"], textDirection: "ltr"),
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

class ImprovedExample extends StatefulWidget {
  const ImprovedExample({super.key});

  @override
  State<ImprovedExample> createState() => _ImprovedExampleState();
}

class _ImprovedExampleState extends State<ImprovedExample> {
  final Runtime _runtime = Runtime();
  final DynamicContent _data = DynamicContent();

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
        padding: [ 10.0 ],
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
