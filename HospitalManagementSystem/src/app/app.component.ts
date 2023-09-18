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
  d:boolean=true
  values:Array<string>=new Array<string>();
  
  /**
   *
   */
//   constructor() {
//     setTimeout(()=>{this.y=this.y+1 ;
//       this.d=false;
//       console.log(this.d);
      
//   },2000);   
// }

  doSomething(){
   this.values.push(this.x);
  this.x="";
  // console.log(this.d);
  // alert(this.d);
  
  }

  rthis(p:string){
    this.values=this.values.filter(x=>x!=p);
    console.log('clicked');
    
  }
  
}
