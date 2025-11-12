//
//  ImageModule.swift
//  SwiftConcurrencyMaster
//
//  Created by Sachin Randive on 11/11/25.
//

import SwiftUI
class ImageDownloader {
    private let url = URL(string: "https://picsum.photos/200")!
    func downloadImage() async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badURL)
        }
        return image
    }
    
    // completionHandler - extra function
    func downloadImage(completionHandler: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data, let image = UIImage(data: data) else { return }
            completionHandler(image)
        } .resume()
    }
}
@MainActor
class ImageModuleViewModel: ObservableObject {
    @Published var image: Image?
    let imageDownloader = ImageDownloader()
    init () {
        Task {
            await self.loadImage()
        }
    }
    
    func loadImage() async {
        do {
            let imageData = try await imageDownloader.downloadImage()
            self.image = Image(uiImage: imageData)
        } catch {
            print("Error downloading image: \(error)")
        }
    }
}

struct ImageModule: View {
    @StateObject private var viewModel = ImageModuleViewModel()
    private let url = URL(string: "https://picsum.photos/200")!
    var body: some View {
//        if let image = viewModel.image {
//            image
//                .resizable()
//                .frame(width: 350, height: 450)
//                .scaledToFill()
//                .clipShape(.rect(cornerRadius: 20))
//        } else {
//            ProgressView()
//        }
        
        AsyncImage(url: url) {  image in
            image
                .resizable()
                .frame(width: 350, height: 450)
                .scaledToFill()
                .clipShape(.rect(cornerRadius: 20))
        } placeholder: {
            ProgressView()
        }

    }
}

#Preview {
    ImageModule()
}
