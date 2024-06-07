# Demo steps

## 1. RFW in Angular

```
cd ng
ng serve
```

## 2. GenUI in JS

### Choose one of two:

#### Start app from build
In terminal 1:
1. `cd static_renderer`
2. `flutter build web` to produce `static_renderer\build\web\`
3. cd build/web/
4. Run `python3 -m http.server 8000`
5. Copy `http://localhost:8000/`

#### Or start app with flutter tools
In terminal 1:
1. `cd static_renderer`
2. `flutter run -d chrome`
3. Find `uri=` in console output and copy the url

### Render UI
In terminal 2:
1. Run `open js/renderer.html`
2. Paste the copied URL to boxes to replace hard coded one
3. Click `Render`
4. Find the frames rendered

If started with flutter tools:
5. Update a frame's code and trigger hot reload with 'r' in console
6. Click 'Render' near the modified frame on renderer.html
