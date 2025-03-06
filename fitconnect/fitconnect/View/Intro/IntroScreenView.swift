import SwiftUI

struct IntroScreenView: View {
    var body: some View {
        NavigationStack {
               VStack {
                   // Text at the top, with margin centered
                   Text("FitConnect")
                       .font(.title)
                       .fontWeight(.bold)
                       .padding(.top, 150)  // Top margin for the title
                       .padding(.bottom, 30) // Bottom padding to separate from buttons

                   Spacer()  // Pushes the buttons to the center of the screen

                   // Sign In Button inside NavigationLink
                   NavigationLink(destination: SignInScreenView()) {
                       Text("Sign In")
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.blue)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   .padding(.horizontal, 50) // Margin of 50 on both sides

                   // Sign Up Button inside NavigationLink
                   NavigationLink(destination: SignUpScreenView()) {
                       Text("Sign Up")
                           .frame(maxWidth: .infinity) 
                           .padding()
                           .background(Color.green)
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   .padding(.horizontal, 50) // Margin of 50 on both sides
                   
                   Spacer()  // Pushes the buttons to the center vertically
               }
           }
        
    }
}

#Preview {
    IntroScreenView()
}
