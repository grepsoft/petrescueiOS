//
//  TermsAndConditionsView.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-12.
//

import SwiftUI

struct TermsAndConditionsView: View {
    
    @Binding var agreeToTerms: Bool
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack {
            ScrollView {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisiut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisiut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisiut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisiut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
            }.padding(12)
            
            Button {
                // take a photo and then show a form to capture
                // Name, photo or email
                // and stamp the photo with date and gps location
                agreeToTerms = true
                isPresented = false
            } label: {
                Text("Agree")
                    .frame(width: 300, height: 40)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(6)
            }
            Button {
                // take a photo and then show a form to capture
                // Name, photo or email
                // and stamp the photo with date and gps location
                agreeToTerms = false
                isPresented = false
            } label: {
                Text("Disagree")
                    .frame(width: 300, height: 40)
                    .foregroundColor(.blue)
                    .cornerRadius(6)
            }
        }

    }
}

struct TermsAndConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditionsView(agreeToTerms: .constant(false), isPresented: .constant(true))
    }
}
