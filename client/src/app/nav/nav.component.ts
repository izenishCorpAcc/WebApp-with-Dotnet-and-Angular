import { Component, OnInit } from '@angular/core';
import { AccountService } from '../_services/account.service';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.css']
})
export class NavComponent implements OnInit {
  model: any = {}; // Initialize an empty object to store user input
  loggedIn = false;

  constructor(private accountService: AccountService) { }

  ngOnInit(): void {
  }

  login() {
    // console.log(this.model);
    // Call the login() method from the AccountService
    this.accountService.login(this.model).subscribe({
      next: response => {
        console.log(response);
        this.loggedIn = true; // Set loggedIn to true upon successful login
      },
      error: error => console.log(error)

    })

  }
  logout(){
    this.loggedIn=false;
  }


}
// NavComponent is an Angular component responsible for displaying a navigation bar and handling user login.
// It imports the AccountService to use its login() method for sending login requests to the server.
// The model object is used to store user input, likely including a username and password entered in a form.
// The login() method is called when the user initiates a login action, such as clicking a "Login" button in the user interface.
// Inside the login() method, the accountService.login(this.model) function is called to send a POST request to the server's login endpoint with the user's input.
// The .subscribe() method is used to subscribe to the HTTP request's response. When a successful response is received (next), the loggedIn variable is set to true, indicating that the user is now logged in. If an error occurs during the request (error), it is logged to the console.
// In summary, the AccountService handles HTTP requests related to account functionality, while the NavComponent is responsible for user interactions, like filling out a login form and processing the login request. Upon a successful login, the loggedIn variable is set to true.