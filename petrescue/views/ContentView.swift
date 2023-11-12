//
//  ContentView.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-12.
//  The idea is to take photo of the pet and then
//  fill out a form to submit the photo
//

import SwiftUI
import PhotosUI

struct Order: Codable {
    let customerId: String
    let items: [String]
}

struct ContentView: View {
    @StateObject private var viewModel = CameraViewModel()
    private var service = PetrescueService()
    
    @State var isPresented = false
    //@State var isCameraPreviewPresented = false
    
    private static let barHeightFactor = 0.15
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                Image("pet_dog")
                    .frame(width: 200, height: 200)
                    .scaledToFill()
                //Text("location status: \(locationManager.latLong())")
                SelectedPhotoView(imageState: viewModel.imageState)
                //                    .overlay(alignment: .bottom){
                //                        Text("\(locationManager.latLong())")
                //                            .foregroundColor(.red)
                //                    }
                
                Spacer()
                
                HStack {
                    Button {
                        //logger.debug("send")
                        viewModel.takePhoto.toggle()
                    } label: {
                        Text("Take photo")
                            .padding(16)
                            .font(.system(size: 24))
                            .background(.purple)
                            .foregroundColor(.white)
                            .clipShape(.capsule)
//                        ZStack {
//                            Circle()
//                                .strokeBorder(.blue, lineWidth: 2)
//                                .frame(width: 80, height: 80)
//                            Image(systemName: "camera.fill")
//                                .font(.system(size: 40))
//                                .foregroundColor(.blue)
//                        }
                    }
                    
                    
                    
//                    Spacer()
//                    
//                    PhotosPicker(selection: $viewModel.selectedPhoto,
//                                 matching: .any(of: [.images, .not(.screenshots), .not(.videos)])) {
//                        ZStack {
//                            Circle()
//                                .strokeBorder(.blue, lineWidth: 2)
//                                .frame(width: 62, height: 62)
//                            Image(systemName: "photo.fill")
//                                .font(.system(size: 30))
//                                .foregroundColor(.blue)
//                        }
//                    }
                    
                }.padding()
                
                Spacer()
                
                if viewModel.imageSelected {
                    NavigationLink {
                        switch viewModel.imageState {
                        case .success(let petImage):
                            SubmitterInfoView(petImage: petImage)
                        case .empty:
                            Text("Empty")
                        case .loading(_):
                            ProgressView()
                        case .failure(_):
                            Text("Failed")
                        }
                        
                    } label: {
                        Text("Next")
                            .frame(width: 300, height: 40)
                            .foregroundColor(.white)
                            .background(.blue)
                            .cornerRadius(6)
                    }
                }
            }
            .sheet(isPresented: $viewModel.takePhoto, onDismiss: didDismiss) {
                GeometryReader { geometry in
                    
                    ViewFinderView(image: $viewModel.viewfinderImage)
                        .frame(height: geometry.size.height)
                        .overlay(alignment: .bottom) {
                            
                            buttonsView()
                                .frame(height: geometry.size.height * Self.barHeightFactor)
                                .background(.black.opacity(0.75))
                        }.overlay(alignment: .topLeading) {
                            Button {
                                viewModel.takePhoto.toggle()
                            } label: {
                                Label {
                                    Text("Close live photo")
                                } icon: {
                                    Image(systemName: "chevron.left")
                                        .font(.system(size: 28))
                                        .foregroundColor(.blue)
                                        .opacity(0.85)
                                    }
                            }
                            .padding()
                        }
                        .labelStyle(.iconOnly)
                }
                .task {
                    // start camera
                    await viewModel.camera.start()
                }
            }
            
        }
        
    }
    
    func didDismiss() {
        viewModel.camera.stop()
    }
    
    private func buttonsView() -> some View {
        
        HStack {
                        
            Spacer()
            
            Button {
                viewModel.camera.takePhoto()
            } label: {
                Label {
                    Text("Take photo")
                } icon: {
                    ZStack {
                        Circle()
                            .strokeBorder(.white, lineWidth: 3)
                            .frame(width: 62, height: 62)
                        
                        Circle()
                            .fill(.white)
                            .frame(width: 50, height: 50)
                    }
                }
            }
            
            Spacer()
        }
        .buttonStyle(.plain)
        .labelStyle(.iconOnly)
        .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
