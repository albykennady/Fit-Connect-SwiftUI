import SwiftUI

struct DashboardHeaderView: View {
    @State private var isLoggedOut = false // Track logout state

    var body: some View {
        VStack {
            HStack {
                Image("FC")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .background(Color.white)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                
                Spacer()
                
                Menu {
                    Button(action: {
                        handleLogout()
                    }) {
                        Label("Logout", systemImage: "power")
                    }
                } label: {
                    Image("user2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
            }
            
            HStack(spacing: 10) {
                Image(systemName: "sun.max.fill")
                    .foregroundColor(Color(UIColor(red: 0.34, green: 0.37, blue: 0.42, alpha: 1.00)))
                Text(Translations.LABEL_DATE_TIME)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(UIColor(red: 0.34, green: 0.37, blue: 0.42, alpha: 1.00)))
                Spacer()
            }
            
            // Navigate to Sign-In Screen on logout
            NavigationLink(destination: SignInScreenView(), isActive: $isLoggedOut) {
                EmptyView()
            }
        }
    }
    
    func handleLogout() {
        isLoggedOut = true 
    }
}

#Preview {
    DashboardHeaderView()
}
