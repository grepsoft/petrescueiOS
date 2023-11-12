//
//  petRescueService.swift
//  petrescue
//
//  Created by Grepsoft on 2023-09-24.
//

import Foundation
import SwiftUI
import Alamofire

class PetrescueService {
    let BASE_URL = "http://[END-POINT-URL]:3000/api/ticket"
    
    init() {}
    
    func submitInfo(endPoint: String, petImage: PetImage, uploadData: Data) async throws -> NetworkResponse {
        
        let url = URL(string: "\(BASE_URL)")!
        let requestUrl = url.appendingPathComponent(endPoint)
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.httpBody = uploadData
        
        var postData = Data()
        
        let filename = "image.jpg"
        let mimetype = "image/jpeg"
        
        // Append the JSON data
        postData.append("--\(boundary)\r\n".data(using: .utf8)!)
        
        postData.append("Content-Disposition: form-data; name=\"userinfo\"\r\n".data(using: .utf8)!)
        postData.append("Content-Type: application/json\r\n\r\n".data(using: .utf8)!)
        //postData.append("Origin: http://10.0.0.92".data(using: .utf8)!)
        postData.append(uploadData)
        postData.append("\r\n".data(using: .utf8)!)
        
        // Add the image data to the raw http request data
        postData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        postData.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        postData.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        postData.append(petImage.uiImage.jpegData(compressionQuality: 0.8)!)
        
        // close the request
        postData.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        
        request.httpBody = postData
        
        //
        // perform the network request
        //
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            print(response)
            return NetworkResponse(code: 1, message: "Server error", data: nil)
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(NetworkResponse.self, from: data)
            print("Got data: \(decodedResponse)")
            return decodedResponse
            
        } catch {
            print("Error parsing JSON: \(error)")
            return NetworkResponse(code: 1, message: "Failed to decode response", data: nil)

        }
    }
    
}

struct NetworkResponse: Codable {
    let code: Int
    let message: String
    let data: String?
}

enum NetworkError: Error {
    case invalidResponse(Int)
    case emptyResponse
    case invalidRequestBody
    case invalidResponseData
}
