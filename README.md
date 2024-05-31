# Demo steps

## Start app from build
In terminal 1:
1. `cd counter`
2. `flutter build web` to produce `counter\build\web\`
3. cd build/web/
4. Run `python3 -m http.server 8000`
5. Copy `http://localhost:8000/`

## Or start app with flutter tools
In terminal 1:
1. `cd counter`
2. `flutter run -d chrome`
3. Find `uri=` in console output and copy the url

## Render app
In terminal 2:
1. Run `open js/renderer.html`
2. Paste `http://localhost:8000/`
3. Click `Render`
4. Find counter rendered
