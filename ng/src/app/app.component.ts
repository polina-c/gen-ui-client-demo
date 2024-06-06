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
    // Add the content to the DOM
    const element = document.createElement('div');
    //element.innerHTML = this.content.nativeElement.innerHTML;
    document.body.appendChild(element);
  }
}
