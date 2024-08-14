//
//  loginScreen.swift
//  MortgageCalculator
//
//  Created by Lixing Zheng on 8/14/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var showAlert: Bool = false
    @State private var showResetPassword: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                // App Logo or Image
                Image(systemName: "lock.fill") // Replace with your app's logo image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding(.top, 50)
                
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 10)
                
                Spacer()
                
                // Username Field
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Password Field
                HStack {
                    if isSecure {
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        TextField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    Button(action: {
                        isSecure.toggle()
                    }) {
                        Image(systemName: isSecure ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                // NavigationLink to Mortgage Calculator Screen
                NavigationLink(destination: mcalculator()) {
                                    Text("Login")
                                        .frame(maxWidth: .infinity, minHeight: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .padding()
                                }
                                .simultaneousGesture(TapGesture().onEnded {
                                    if username.isEmpty || password.isEmpty {
                                        showAlert = true
                                    } else {
                                        // Implement your login logic here
                                        print("Username: \(username), Password: \(password)")
                                    }
                                })
                
                
                // Forgot Password Link
                Button(action: {
                    showResetPassword = true // Trigger the alert
                }) {
                    Text("Forgot Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.top, 20)
                

                
                Spacer()
                
                // Sign Up Link
                HStack {
                    Text("Don't have an account?")
                    Button(action: {
                        // Handle sign-up action
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("Username or Password cannot be empty"), dismissButton: .default(Text("OK")))
                        }
            .alert(isPresented: $showResetPassword) {
                            Alert(title: Text("Reset Password"), message: Text("An email has been sent to reset your password."), dismissButton: .default(Text("OK")))
                        }
            .navigationBarBackButtonHidden(true)
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    
    }
}
