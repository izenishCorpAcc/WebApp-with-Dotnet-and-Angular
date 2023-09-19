import { Component, OnDestroy, OnInit } from '@angular/core';
import { ProductserviceService } from './productservice.service';
import {Subscription} from 'rxjs';
// decorator
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html', //view
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit,OnDestroy{     //logic
  private xSubscription: Subscription = new Subscription;
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
/**
 *
 */
constructor(private productService:ProductserviceService) {
}

ngOnInit() {
  //this is a life cycle method and will work after creation and constructor
  this.values=this.productService.getProducts();
  this.xSubscription=this.productService.xUpdated.subscribe(()=>{
  this.values=this.productService.getProducts();

  });
  
}
ngOnDestroy() {
  this.xSubscription.unsubscribe();
}

  doSomething(form: any){
    console.log(form);
    if (form.valid){
      // instead of pushing to the local array we can now push to the service
      // this.values.push(form.value.x);  
      this.productService.addProduct(form.value.x);
    }
  //  this.values.push(this.x);
  this.x="";
  // console.log(this.d);
  // alert(this.d);
  
  }

  rthis(p:string){
    this.values=this.values.filter(x=>x!=p);
    console.log('clicked');
    
  }
  
}
