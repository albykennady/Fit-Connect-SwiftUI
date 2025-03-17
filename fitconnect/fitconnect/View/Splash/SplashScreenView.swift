//
//  SplashScreenView.swift
//  fitconnect
//
//  Created by Vijil Dhas A S on 18/02/25.
//
import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                
                Image("fitnesslogo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .ignoresSafeArea(edges: .all)
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    VStack (spacing: 70){
                        Image("Fitconnectlogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 95)
                        
                        Text("FitConnect")
                        
                            .font(.system(size: 45, weight: .regular, design: .default))
                            .foregroundColor(.white)
                            .padding(.bottom)
                        
                    }
                    .padding(.top,60)
                    Text("Join our community and start your fitness journey today!")
                        .font(.system(size: 17, weight: .regular, design: .default))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    
                    
                    Spacer()
                    
                    
                    VStack (spacing: 10) {
                        Button(action: {
                            
                        }){
                            NavigationLink(destination: SignInScreenView()) {
                                Text("Get Started")
                                    .font(.system(size: 20,weight: .light))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color(red: 0.337, green: 0.863, blue: 0.773))
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                        }
                        Button(action: {
                            
                        })
                        {
                            NavigationLink(destination: SignUpScreenView()) {
                                Text("Sign up ")
                                    .font(.system(size: 20,weight: .light))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white,lineWidth: 1.5)
                                    )
                                
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.bottom, 55)
                    
                    
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    SplashScreenView()
}
