//
//  signIn.swift
//  ExercisingSoloV2
//
//  Created by 55GOParticipant on 7/19/25.
//

import SwiftUI

struct signin: View {
    @State private var isSignUp = false
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isAuthenticated = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .font(.largeTitle)
                    .bold()
                
                // Email Field
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)

                // Confirm Password Field (Sign Up only)
                if isSignUp {
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10)
                }

                // Submit Button
                Button(action: {
                    if email.isEmpty || password.isEmpty {
                        alertMessage = "Please fill in all fields."
                        showingAlert = true
                    } else if isSignUp && password != confirmPassword {
                        alertMessage = "Passwords do not match."
                        showingAlert = true
                    } else {
                        // Simulate auth success
                        isAuthenticated = true
                    }
                }) {
                    Text(isSignUp ? "Create Account" : "Log In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // Toggle Mode
                Button(isSignUp ? "Already have an account? Sign In" : "Don't have an account? Sign Up") {
                    isSignUp.toggle()
                }
                .padding(.top)

                Spacer()

                // Navigation to main app
                NavigationLink(destination: tabs(), isActive: $isAuthenticated) {
                    EmptyView()
                }
            }
            .padding()
            .navigationTitle("Welcome")
            .alert(alertMessage, isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}


#Preview {
    signin()
}

