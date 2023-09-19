import { Injectable } from '@angular/core';
import {Subject} from 'rxjs';
@Injectable({
  providedIn: 'root'
})
export class ProductserviceService {

  private x =['A book'];
  xUpdated=new Subject();

  addProduct(productName:string){
    this.x.push(productName);
    this.xUpdated.next(this.x);
  }

  getProducts(){
    return [...this.x];
  }
  deleteProduct(productName:string){
    this.x=this.x.filter(p=>p!==productName);
    this.xUpdated.next(this.x);

  }
}
