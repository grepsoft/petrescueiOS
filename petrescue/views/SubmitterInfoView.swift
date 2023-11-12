//
//  SubmitterInfoView.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-12.
//

import SwiftUI
import iPhoneNumberField

struct SubmitterInfoView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel = SubmitterInfoViewModel()
    @StateObject var locationManager = LocationManager()
    
    @State var isPresented = false
    
    private var _petImage: PetImage
    init(petImage: PetImage) {
        self._petImage = petImage
    }
    
    var body: some View {
        VStack {
            
            Form {
                TextField("Name", text: $viewModel.submitterName, prompt: Text("First Last").italic())
                
                if viewModel.validationErrors.contains(.invalidName) {
                    Text("Please enter a name")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                //TextField("Phone", text: $viewModel.phone)
                iPhoneNumberField("Phone",text: $viewModel.submitterPhone)
                    .maximumDigits(10)
                
                
                if viewModel.validationErrors.contains(.invalidPhone) {
                    Text("Please enter a valid 10 digit phone")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                TextField("Email", text: $viewModel.submitterEmail,
                          prompt: Text("john@email.com")
                    .italic())
                .textInputAutocapitalization(.never)
                
                if viewModel.validationErrors.contains(.invalidEmail) {
                    Text("Please enter a valid email")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
                
                HStack {
                    Text("I Accept")
                    Button {
                        isPresented = true
                    } label: {
                        Text("terms and conditions")
                    }
                    Spacer()
                    viewModel.agreeToTerms ? Image(systemName: "checkmark")
                        .foregroundColor(.green) : nil
                }
                
                if viewModel.validationErrors.contains(.invalidTac) {
                    Text("You must accept terms and conditions")
                        .foregroundColor(.red)
                        .padding(.top, 5)
                }
            }
            .disableAutocorrection(true)
            
            Group {
                if viewModel.inProgress {
                    HStack {
                        Text("Submitting ticket...")
                            .font(.headline)
                        ProgressView()
                    }
                }
                else {
                    Button {
                        guard viewModel.validateInfo() else { return }
                        
                        viewModel.submitInfo(self._petImage, self.locationManager.latLong())
                    } label: {
                        
                        Text("Submit")
                            .frame(width: 300, height: 40)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(6)
                    }
                }
            }
            
            
            Spacer()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(viewModel.alertType.title),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $isPresented, content: {
            TermsAndConditionsView(agreeToTerms: $viewModel.agreeToTerms, isPresented: $isPresented)
        })
        .navigationTitle("User info")
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

struct SubmitterInfoView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitterInfoView(petImage: PetImage(image: Image("test"), uiImage: UIImage()))
    }
}
