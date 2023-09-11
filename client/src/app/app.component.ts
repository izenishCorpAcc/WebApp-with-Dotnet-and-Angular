// Import necessary modules and classes
import { HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root', // Specifies the HTML element where this component will be rendered
  templateUrl: './app.component.html', // Path to the HTML template for this component
  styleUrls: ['./app.component.css'] // Path to the CSS styles for this component
})
export class AppComponent implements OnInit {
  title: string = 'client'; // A property to hold the title

  users: any; // A property to hold the data received from the API

  constructor(private http: HttpClient) {
    // Constructor where an instance of HttpClient is injected
  }

  ngOnInit(): void 
  {
    // This method is called when the component is initialized

    // Make an HTTP GET request to the specified API endpoint
    this.http.get('https://localhost:5001/api/v1/users')
      .subscribe({
        next: (response) => {
          // Handle the successful response from the API
          this.users = response; // Assign the received data to the 'users' property
        },
        error: (error) => {
          // Handle any errors that occur during the request
          console.log(error);
        },
        complete: () => {
          // This function is called when the request has completed, regardless of success or failure
          console.log('Request has completed');
        }
      });
  }
}
