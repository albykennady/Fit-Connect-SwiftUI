//
//  SignInScreenView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import SwiftUI

struct SignInScreenView: View {
    @ObservedObject var viewModel = ValidatorViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 90)
            
            Text("Welcome Back 👋")
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 20)
            
            Spacer().frame(height: 40)
            
            VStack(alignment: .leading, spacing: 15) {
                Text("Email")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                TextField("Enter email", text: $viewModel.email)
                    .padding()
                    .background(Color.gray).opacity(10/100)
                    .cornerRadius(16)
                
                Text("Password")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                SecureField("Enter Password", text: $viewModel.password)
                    .padding()
                    .background(Color.gray).opacity(10/100)
                    .cornerRadius(16)
                    .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Forgot Password?")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(red: 0.337, green: 0.863, blue: 0.773))
                    }
                }.padding(.bottom, 4)
                
                Button(action: {
                    viewModel.validate()
                }) {
                    Text("Sign In")
                        .font(.system(size: 18, weight: .light))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.337, green: 0.863, blue: 0.773))
                        .cornerRadius(26)
                }
                Spacer()
                
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 16))
                    Button(action: {
                        
                    }) {
                        Text("Sign Up")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0.337, green: 0.863, blue: 0.773))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
        }
       
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
}

#Preview {
    SignInScreenView()
}

