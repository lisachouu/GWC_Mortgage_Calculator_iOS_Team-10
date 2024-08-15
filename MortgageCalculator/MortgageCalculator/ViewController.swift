import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            // Background Image
            Image("logIn") // Replace "backgroundImage" with the name of your image asset
                .resizable()
                .frame(width: 395,height:800)
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                
            
            VStack {
                // Your other content goes here
                // App Logo or Image
                Image("logo") // Replace with your app's logo image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                
                Text("Welcome Back!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 41/255, green: 127/255, blue: 178/255))
                    .padding(.top, 80)
                
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
                
                // Login Button
                Button(action: {
                    // Handle login action
                    if username.isEmpty || password.isEmpty {
                        showAlert = true
                    } else {
                        // Implement your login logic here
                        print("Username: \(username), Password: \(password)")
                    }
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(Color(red: 41/255, green: 127/255, blue: 178/255))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                   
                }
                
                Spacer()
                
                    
                    Text("Forgot Password?")
                    .fontWeight(.bold)
                    .padding(.bottom,75)
        
                    
                // Sign Up Link
                HStack {
                 
                    
                    Text("Don't have an account?")
                    Button(action: {
                        // Handle sign-up action
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 41/255, green: 127/255, blue: 178/255))
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Username or Password cannot be empty"), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
static var previews: some View {
ContentView()
}
}



