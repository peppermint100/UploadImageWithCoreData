import SwiftUI
import PhotosUI
import UIKit
import CoreData

struct ContentView: View {
    
    @State private var images = [ImageDataModel]()
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    @State private var currentDetailImage: ImageDataModel? = nil
    
    @ObservedObject private var imageGridViewModel = ImageGridViewModel()
    @ObservedObject private var photoLibraryPreviewViewModel = PhotoLibraryPreviewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                // Listing Images in CoreData
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(imageGridViewModel.images) { image in
                            NavigationLink(
                                destination: ImageDetailView(image: image, onDelete: {
                                    imageGridViewModel.deleteImage(image: image)
                                })){
                                Image(uiImage: image.image)
                                .resizable()
                                .frame(width: 150, height: 150)
                            }
                        }
                    }
                }
                // Listing Images in User Photo Library
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(photoLibraryPreviewViewModel.images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                // Select a Photo Button to open Photo Picker
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Select from your library?")
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                imageGridViewModel.addImage(image: UIImage(data: data)!)
                            }
                        }
                    }
            }
            .navigationTitle("Image Picker")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // Show Both Dark and Light mode in canvas preview
        ForEach(ColorScheme.allCases, id: \.self) {
            ContentView().preferredColorScheme($0)
        }
    }
}
