//
//  LoginView.swift
//  KcHeroesMulti (iOS)
//
//  Created by Noe Cruz Rodriguez on 19/09/2021.
//

import SwiftUI

struct LoginView: View {
    // Al indicar que es EnvironmentObject le pasa la instancia sin necesidad de hacerlo nosotros
    @EnvironmentObject var rootViewModel: RootViewModel
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack{
            // Logo
            Image(decorative: "logo")
                .resizable()
                .scaledToFit()
                .padding([.trailing, .leading], 20)
            
            Spacer()
            // Input fields
            VStack{
                TextField("Email", text: self.$email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x:20, y:10)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .disableAutocorrection(true)
                
                SecureField("Clave", text: self.$password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x:20, y:10)
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .disableAutocorrection(true)
            }
            .padding([.trailing, .leading], 20)
            
            // Submit button
            Button(action: {
                // Login action
                rootViewModel.login(email: email, password: password)
            }) {
                Text("Entrar")
                    .padding()
                    .font(.title2)
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .background(Color.orange)
                    .cornerRadius(20.0)
                    .shadow(radius: 10.0, x:20, y:10)
            }
            .padding(.top, 50)
            
            Spacer()
            // Register account
            HStack{
                Text("¿No tienes cuenta?")
                Button(action: {
                    // Register action
                }){
                    Text("Registro")
                        .foregroundColor(.blue)
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), .orange, .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
        )
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.locale, .init(identifier: "en"))
        
    }
}
