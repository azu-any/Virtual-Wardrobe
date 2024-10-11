//
//  AddClothesView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI
import PhotosUI

struct AddClothesView: View {
    
    @Binding var showAddClothesView: Bool
    @State private var color: Color = Color.blue
    let subCategories: [String] = ["Jeans", "T-Shirt"]
    @State var selectedSubCategory: String = "Jeans"
    
    //photo library
    @State private var showPhotoPicker = false
    @State private var showCamera = false
    @State private var selectedItem: PhotosPickerItem?
    @State var image: Image?
    
    //camera
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Menu {
                    Button(action: {
                        resetPhotos()
                        showCamera.toggle()
                    }) {
                        Label(title: {Text("Take from camera")}, icon: {Image(systemName: "camera.fill")})
                    }
                    
                    Button(action: {
                        resetPhotos()
                        showPhotoPicker.toggle()
                    }) {
                        Label(title: {Text("Choose from library")}, icon: {Image(systemName: "photo.fill")})
                    }
                } label: {
                    if let image{
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    } else if let selectedImage{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        

                    } else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.30))
                                .frame(width: 200, height: 200)
                            
                            Image(systemName: "camera.fill")
                                .font(.system(size: 80))
                                .foregroundStyle(.gray)
                            
                        }
                    }
                }
                .padding(.bottom)
                
                
                VStack(spacing: 20){
                    ColorPicker("Color", selection: $color)
                    HStack{
                        Text("Type")
                        Spacer()
                        Picker("Picker", selection: $selectedSubCategory) {
                            ForEach(subCategories, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                .frame(width: 200)
                
                Button("Save item"){
                    
                }
                .buttonStyle(MainButton())
                .padding(.top, 50)
                
                
            }
            .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItem)
            .fullScreenCover(isPresented: self.$showCamera) {
                accessCameraView(selectedImage: self.$selectedImage)
                    .background(.black)
            }
            .onChange(of: selectedItem) {
                Task {
                    if let loadedImage = try? await selectedItem?.loadTransferable(type: Data.self),
                       let uimg = UIImage(data: loadedImage){
                        self.image = Image(uiImage: uimg)
                    }
                    print("Failed to load the image")
                }
            }
            .navigationTitle("Add new clothes")
        }
    }
    
    private func resetPhotos(){
        selectedItem = nil
        selectedImage = nil
        image = nil
    }
}








// ugly things for making camera work

struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    AddClothesView(showAddClothesView: .constant(true))
}
