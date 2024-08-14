//
//  mortgageCalculatorScreen.swift
//  MortgageCalculator
//
//  Created by Lisa Chou on 8/8/24.
//

import SwiftUI

// custom hex colors
extension Color {
    static let customGreen = Color(hex: "#91C744")
    static let customBlue = Color(hex: "#297FB2")
}

// code to add hex color codes
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = hex.hasPrefix("#") ? 1 : 0
        
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
        let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
        let b = Double(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b)
    }
}

//constant variables for calculator
struct mcalculator: View {
    @State private var downPayment: String = ""
    @State private var loanPayment: String = ""
    @State private var loanDurationIndex: Int = 0
    @State private var monthlyPayment: String = ""
    @State private var navigateToLogin = false
    
    private let price: Double = 1200000
    private let address: String = "12345 WestNorth Street"
    private let loanDurations = ["10 Years", "15 Years", "20 Years", "30 Years"]
    private let interestRate: Double = 7.6
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        HStack {
                            Button(action: {
                                navigateToLogin = true
                            }) {
                                Image(systemName: "arrow.left")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(.leading)
                            
                            Spacer()
                            
                            Text("Calculate Mortgage")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                            
                            
                            Spacer()
                            
                            Button(action: {
                                navigateToLogin = true
                            }) {
                                //house image circle
                                Image(systemName: "house")
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing)
                        }
                        .padding()
                        .background(Color.customBlue)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Image("house")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 170, height: 160)  // Increased circle size
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 9)) // Blue border
                            .shadow(radius: 10)
                            .padding(.bottom, 10)
                        
                        Text("$1,200,000")
                            .font(.title3)
                            .fontWeight(.bold) // Make the text bold
                            .foregroundColor(.black)
                            .padding(.bottom, 5)
                        
                        // address UI
                        Text(address)
                            .font(.body)
                            .padding(.bottom, 20)
                            .foregroundColor(.blue)
                        
                        // text field for down payment
                        TextField("Down Payment", text: $downPayment)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        // text field for down payment, UI portion
                        TextField("Loan Payment", text: $loanPayment)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal)
                        
                        // text field for down payment, calculation portion
                        Picker("Loan Duration", selection: $loanDurationIndex) {
                            ForEach(0 ..< loanDurations.count) {
                                Text(self.loanDurations[$0])
                            }
                        }
                        //UI color
                        .pickerStyle(MenuPickerStyle())
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        
                        // ui for current interest (constant)
                        Text("Current Interest Rate: \(String(format: "%.1f", interestRate))%")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.bottom, 1)
                        
                        // calculation button
                        Button(action: calculateMonthlyPayment) {
                            Text("Calculate")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(minWidth: 100, maxWidth: 120)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        
                        // Result
                        Text("Estimated Monthly Payment: \(monthlyPayment)")
                            .font(.body)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 100)
                            .background(Color.customGreen)
                            .cornerRadius(15)
                            .padding(.top, 10)
                            .padding(.horizontal)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .frame(height: UIScreen.main.bounds.height * 0.78)
                    .padding(.horizontal, 5)
                }
                // NavigationLink to go to the login screen
                NavigationLink(destination: ContentView(), isActive: $navigateToLogin) {
                    EmptyView()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // function for calculation
    func calculateMonthlyPayment() {
        let principal = price - (Double(downPayment) ?? 0.0)
        let annualInterestRate = interestRate / 100.0
        let monthlyInterestRate = annualInterestRate / 12.0
        let loanDurationInYears = Double(loanDurations[loanDurationIndex].components(separatedBy: " ")[0]) ?? 0.0
        let numberOfPayments = loanDurationInYears * 12.0
        
        let additionalLoanPayment = Double(loanPayment) ?? 0.0
        
        if monthlyInterestRate > 0 {
            let monthlyPaymentAmount = (principal + additionalLoanPayment) * (monthlyInterestRate * pow(1 + monthlyInterestRate, numberOfPayments)) / (pow(1 + monthlyInterestRate, numberOfPayments) - 1)
            monthlyPayment = String(format: "%.2f", monthlyPaymentAmount)
        } else {
            monthlyPayment = String(format: "%.2f", (principal + additionalLoanPayment) / numberOfPayments)
        }
    }
}

struct Cal_Previews: PreviewProvider {
    static var previews: some View {
        mcalculator()
    }
}
