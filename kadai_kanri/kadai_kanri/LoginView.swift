//
//  LoginView.swift
//  kadai_kanri
//
//  Created by 當山寛人 on 2022/07/04.
//

import SwiftUI

struct LoginView: View {
    @Binding var username: String
    
    var body: some View {
        ProgressView()
            .onAppear(perform: login)
    }
    
    func login(){
        Task {
            do {
                let user = try await realmApp.login(credentials: .anonymous)
                username = user.id
            }catch{
                print("Failed to log in: \(error.localizedDescription)")
            }
        }
    }
}

