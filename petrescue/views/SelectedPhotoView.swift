//
//  SelectedPhotoView.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-19.
//

import SwiftUI

struct SelectedPhotoView: View {
    
    let imageState: CameraViewModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let petImage):
            petImage
                .image
                .resizable()
                .scaledToFit()
                .padding()
                .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 2)
                    )
        case .empty:
            Text("Take a Pet photo")
                .font(.system(size: 28))
        case .loading:
            ProgressView()
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct SelectedPhotoView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedPhotoView(imageState: .empty)
    }
}
