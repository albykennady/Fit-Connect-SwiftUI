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
            
            Text(Translations.LABEL_WELCOME)
                .font(.system(size: 32, weight: .bold))
                .padding(.bottom, 20)
            
            Spacer().frame(height: 40)
            
            VStack(alignment: .leading, spacing: 15) {
                Text(Translations.LABEL_EMAIL)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                TextField(Translations.PLACEHOLDER_EMAIL, text: $viewModel.email)
                    .padding()
                    .background(Color.gray).opacity(10/100)
                    .cornerRadius(16)
                
                Text(Translations.LABEL_PASSWORD)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                SecureField(Translations.PLACEHOLDER_PASSWORD, text: $viewModel.password)
                    .padding()
                    .background(Color.gray).opacity(10/100)
                    .cornerRadius(16)
                    .padding(.bottom, 10)
                
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text(Translations.BTN_FORGOT_PASSWORD)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(Color(red: 0.337, green: 0.863, blue: 0.773))
                    }
                }.padding(.bottom, 4)
                
                Button(action: {
                    viewModel.validate()
                }) {
                    NavigationLink(destination: DashboardScreenView()) {
                        Text(Translations.BTN_SIGN_IN)
                            .font(.system(size: 18, weight: .light))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.337, green: 0.863, blue: 0.773))
                            .cornerRadius(26)
                    }
                }
                Spacer()
                
                HStack {
                    Text(Translations.LABEL_NO_ACCOUNT)
                        .font(.system(size: 16))
                    Button(action: {
                        
                    }) {
                        NavigationLink(destination: SignUpScreenView()) {
                            Text(Translations.BTN_SIGN_UP)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(Color(red: 0.337, green: 0.863, blue: 0.773))
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 20)
            .navigationBarBackButtonHidden(true)
        }
       
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text(viewModel.errorMessage))
        }
    }
}

#Preview {
    SignInScreenView()
}

