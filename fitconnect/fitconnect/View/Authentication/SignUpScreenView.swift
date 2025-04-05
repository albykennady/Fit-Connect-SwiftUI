import SwiftUI

struct SignUpScreenView: View {
    @State private var username = "VijilDhas2222"
    @State private var email = "dhasvijil@gmail2222.com"
    @State private var password = "Test@123"
    @State private var navigateToSignIn = false  // Track navigation state
    @State private var showingAlert = false // To control when to show the alert
    @State private var alertMessage = "" // The message to display in the alert
    @State private var isSuccess = false // To track success or failure

    // Assuming you have this as a @StateObject for the ViewModel
    @StateObject private var viewModel = UserViewModel(apiService: APIService()) // ViewModel injected here

    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Username Field
                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Email Field
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Error message display (if any)
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Sign Up Button
                Button(action: {
                    // Validate user input
                    if validateInput() {
                        // Create a User object for registration
                        let user = User(
                            username: username,
                            password: password,
                            email: email,
                            roles: ["user"]  // Default role as "user"
                        )
                        
                        // Call registerUser method from the ViewModel
                       
                        viewModel.registerUser(user: user) { result in
                            switch result {
                            case .success(let response):
                                // If registration is successful, check the response
                                if let statusCode = response.httpStatusCode, statusCode == 200 {
                                    alertMessage = "Registration successful!"
                                    isSuccess = true
                                    navigateToSignIn = true
                                } else {
                                    // Use the error message from the response (not the HTTP message)
                                    alertMessage = response.message ?? "Unexpected error occurred"
                                    isSuccess = false
                                }

                            case .failure(let error):
                                // Handle failure case
                                alertMessage = error.localizedDescription  // This will display the error message from API or HTTP
                                isSuccess = false
                            }
                            
                            // Show the alert with the appropriate message
                            showingAlert = true
                        }
                            
                        

                        
                    } else {
                        alertMessage = "Please ensure all fields are filled correctly."
                        isSuccess = false
                       // showingAlert = true
                    }
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                // Show a loading spinner if registration is in progress
                if viewModel.isRegistering {
                    ProgressView("Registering...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }

                // NavigationLink placed outside button action
                NavigationLink(destination: SignInScreenView(), isActive: $navigateToSignIn) {
                    EmptyView()
                }
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                // Create the alert based on success or failure
                Alert(
                    title: Text(isSuccess ? "Success" : "Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    // Function to validate user input
    private func validateInput() -> Bool {
        // Basic validation
        if username.isEmpty || email.isEmpty || password.isEmpty {
            return false
        }
        
        // Validate email format
        if !isValidEmail(email) {
            return false
        }
        
        // Password strength check (basic example)
        if password.count < 6 {
            return false
        }
        
        // If all validations pass
        return true
    }
    
    // Function to validate email format using regex
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

#Preview {
    SignUpScreenView()
}
