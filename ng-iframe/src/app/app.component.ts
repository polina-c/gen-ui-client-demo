import { Component } from '@angular/core';
import { RouterOutlet } from '@angular/router';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'ng';

  onAddContent() {
    const element = document.createElement('div');
    element.innerHTML = '<iframe src="http://localhost:50796/" title="Dynamic" style="position: relative; top: -10px"></iframe>';
    document.body.appendChild(element);
  }
}
