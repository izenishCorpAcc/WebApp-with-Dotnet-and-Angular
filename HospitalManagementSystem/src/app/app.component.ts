import { Component } from '@angular/core';
// decorator
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html', //view
  styleUrls: ['./app.component.css']
})
export class AppComponent {     //logic
  title = 'HospitalManagementSystem';
  x: string ="";
  y: number=66;
  values:Array<string>=new Array<string>();

  doSomething(){
   this.values.push(this.x);
  this.x="";
  }

  
}
