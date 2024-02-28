//
//  TgtSelectFFView.swift
//  LLimg_sw01
//
//  Created by EFI-Admin on 1/29/24.
//

import SwiftUI
//import UniformTypeIdentifiers

struct TgtSelectSparseView: View {
    @State private var filePath: String = ""
    @State private var selectedItems = Set<UUID>()
    @ObservedObject private var fileSelectionManager = FileSelectionManager()
    @State private var stillWorking = false
    let path2img: String = "Targeted sparse Image"
//    let butlabel: String = (stillWorking ? "Working on it" : "Select Files/Folders")
    
    var body: some View {
        VStack {
            HStack {
                TextField(path2img, text: $filePath)
                    .font(.system(size: 12))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .frame(width: 290, alignment: .leading)
                    .padding(2)
                
                Button(action: {
                    let openPanel = NSOpenPanel()
                    openPanel.allowsMultipleSelection = false
                    openPanel.canChooseDirectories = false
                    openPanel.canChooseFiles = true
//                    openPanel.allowedFileTypes = [".sparseimage"]
//                    openPanel.allowedContentTypes = [UTType(filenameExtension: ".sparseimage") ?? .data]
                    
                    if openPanel.runModal() == .OK {
                        openPanel.urls.forEach { url in
                            fileSelectionManager.addFileFolder(path: url.path)
                            FileSelectionManager.shared.addFileFolder(path: url.path)
 
                        }
                    }
                    
                })
                {
                    Text(stillWorking ? "Working on it" : "Select Sparse Imag")

                      
                }
                .disabled(stillWorking)
                .frame(width:140, height: 25)
    

            }
            .onAppear() {
                let butlabel: String = (stillWorking ? "Working on it" : "Select Files/Folders")
            }
            .background()


            List(selection: $selectedItems) {
                ForEach(FileSelectionManager.shared.selectedFiFo, id: \.id) { file in
                    HStack {
                        Text(file.path)
                            .font(.subheadline)
//                        Spacer()
//                        Text("\(file.size) bytes")
//                            .font(.caption)
                    }
                }
//                HStack {
//                    Text("Total Size")
//                        .font(.caption)
//                    Spacer()
//                    Text("\(FileSelectionManager.shared.totalSize) bytes")
//                        .font(.caption)
//                }
    }
//    .listStyle(SidebarListStyle())

            HStack {
                Button("Delete Selected") {
                    deleteSelectedItems()
                }

                
            }
            
        }
        .frame(width: 420, height: 220)
    }
    

    
    func deleteSelectedItems() {
        FileSelectionManager.shared.selectedFiles.removeAll { fileItem in
            selectedItems.contains(fileItem.id)
        }
        selectedItems.removeAll()
    }
}


#Preview {
    TgtSelectSparseView()
}
