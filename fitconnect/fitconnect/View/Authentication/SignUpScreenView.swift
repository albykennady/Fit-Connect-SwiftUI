import SwiftUI

struct SignUpScreenView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var navigateToSignIn = false  // Track navigation state
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                TextField("Username", text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Email", text: $email)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    // Handle Sign Up logic here
                    // For example, you can verify input and perform the sign-up action
                    
                    // After successful sign-up, set the flag to navigate
                    navigateToSignIn = true
                }) {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // NavigationLink placed outside button action
                NavigationLink(destination: SignInScreenView(), isActive: $navigateToSignIn) {
                    EmptyView()
                }
            }
            .padding()
        }
    }
}

#Preview {
    SignUpScreenView()
}
