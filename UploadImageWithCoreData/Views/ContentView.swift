import SwiftUI
import PhotosUI
import UIKit
import CoreData

struct ContentView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    @State private var showImageDetail = false
    
    @ObservedObject private var imageGridViewModel = ImageGridViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                        ForEach(imageGridViewModel.images) { image in
                            Image(uiImage: image.image!)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .sheet(isPresented: $showImageDetail) {
                                ImageDetailView(image: image.image) {
                                    showImageDetail.toggle()
                                    imageGridViewModel.deleteImage(image: image)
                                }
                            }
                            .onTapGesture {
                                showImageDetail.toggle()
                            }
                        }
                    }
                }
                
                ScrollView {
                    HStack {
                        Image("batman")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                    }
                }
                .frame(height: 200)
                
                PhotosPicker(
                    selection: $selectedItem,
                    matching: .images,
                    photoLibrary: .shared()) {
                        Text("Select a photo")
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
        ContentView()
    }
}
