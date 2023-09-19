import { Component, Input, OnInit,EventEmitter,Output } from '@angular/core';
import { ProductserviceService } from '../productservice.service';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit{

@Input() productName: string ="";
@Output() removeItem= new EventEmitter();

constructor(private productService:ProductserviceService) {
}
ngOnInit(): void {
}
productClicked(){
  // this.removeItem.emit();
  this.productService.deleteProduct(this.productName);
}
}
