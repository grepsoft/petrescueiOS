//
//  ThumbnailView.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-15.
//

import SwiftUI

struct ThumbnailView: View {
    
    var image: Image?
    
    var body: some View {
        ZStack {
            if let image = image {
                image
                    .resizable()
                    .scaledToFill()
            }
        }
        .frame(width: 41, height: 41)
        .cornerRadius(11)
        
    }
}

struct ThumbnailView_Previews: PreviewProvider {
    
    static var previews: some View {
        ThumbnailView(image: Image(systemName: "photo.fill"))
    }
}
