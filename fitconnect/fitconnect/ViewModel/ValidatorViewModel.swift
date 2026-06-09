//
//  ValidatorViewModel.swift
//  FitConnect
//
//  Created by Alby Kennady on 18/02/25.
//

import Foundation

class ValidatorViewModel: ObservableObject {
    @Published var email : String = ""
    @Published var password : String = ""
    @Published var username : String = ""
    
    var errorMessage : String = ""
    @Published var isError : Bool = false
    
    func validate(){
        if email.isEmpty && password.isEmpty{
            errorMessage = "Email and password is empty"
            isError = true
        }else if password.isEmpty{
            errorMessage = "Password is empty"
            isError = true
        }else if email.isEmpty {
            errorMessage = "Email is empty"
            isError = true
        }else if username.isEmpty{
            errorMessage = "Username is empty"
            isError = true
        }
        else{
            errorMessage = ""
            isError = false
        }
        
    }
    
    
    
    
    
}
