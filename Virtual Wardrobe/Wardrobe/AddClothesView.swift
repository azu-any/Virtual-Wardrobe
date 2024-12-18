//
//  AddClothesView.swift
//  Virtual Wardrobe
//
//  Created by Francesco Paciello on 09/10/24.
//

import SwiftUI
import PhotosUI
import BackgroundRemoval

struct AddClothesView: View {
    
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var mode
    @Binding var showAddClothesView: Bool
    @State private var color: Color = Color.blue
    let subCategories: [String] = [
        "T-Shirts", "Jeans", "Shorts", "Jackets", "Coats", "Sweaters", "Hoodies",
        "Dresses", "Skirts", "Shirts", "Blouses", "Leggings", "Sneakers", "Necklace", "Earrings", "Bracelet", "Watch", "Glasses"
    ]
    
    @State var selectedSubCategory: String = Clothe.ClotheType.Top.tShirt.rawValue
    @State var selectedCategory: Clothe.ClotheType = Clothe.ClotheType.top

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
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else if let selectedImage{
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    } else{
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.30))
                                .frame(width: 250, height: 250)
                            
                            Image(systemName: "camera.fill")
                                .font(.system(size: 100))
                                .foregroundStyle(.gray)
                            
                        }
                    }
                }
                .padding(.bottom)
                
                
                VStack(spacing: 20){
                    
                    ColorPicker("Color", selection: $color)
                    
                    HStack{
                        Text("Category")
                        Spacer()
                        Picker("Category", selection: $selectedCategory) {
                            ForEach(Clothe.ClotheType.allCases, id: \.self) { category in
                                Text(category.rawValue).tag(category)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    HStack{
                        Text("Type")
                        Spacer()
                        
                        // Picker for selecting subcategories based on the selected category
                        Picker("Subcategory", selection: $selectedSubCategory) {
                            ForEach(selectedCategory.subcategories(), id: \.0) { subcategory, _ in
                                Text(subcategory).tag(subcategory)
                            }
                        }
                    }
                }
                .frame(width: 250)
                
                Button("Save item"){
                    // Create a new clothe item
                    var image_data: Data = Data()
                    
                    let backgroundRemoval = BackgroundRemoval()
                    var image_without_background = UIImage()
                    
                    if let image {
                        let renderer = ImageRenderer(content: image)
                        if let renderedImage = renderer.uiImage {
                            do {
                                image_without_background = try backgroundRemoval.removeBackground(image: renderedImage)
                            } catch {
                                print(error)
                            }
                            image_data = image_without_background.pngData() ?? Data()
                            
                        }
                    } else if let selectedImage{
                        do {
                            image_without_background = try backgroundRemoval.removeBackground(image: selectedImage)
                        } catch {
                            print(error)
                        }
                        image_data = image_without_background.pngData() ?? Data()
                        
                    }
                    
                    
                    if image_data.count > 0{
                        let newClothe = Clothe(image: image_data, hexColor: color.hex, type: selectedCategory, subType: selectedSubCategory)
                        print("New clothe: \(newClothe)")
                        print("\(newClothe.type) \(newClothe.subType)")
                        
                        context.insert(newClothe)
                        // try? context.save()
                        
                        mode.wrappedValue.dismiss()
                    }
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
