//
//  AddTaskView.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import SwiftUI

struct AddTaskView: View {
    
    @StateObject var viewModel: NewTaskViewModel
    @Environment(\.dismiss) var dismiss
    @State var isAlertPresent: Bool = false
    @State var errorMessage: String = ""
     
    var body: some View {
        Form {
            Section("Data") {
                TextField("Title", text: $viewModel.title)
                TextField("caption", text: $viewModel.desc)
            }
            Section("Accept") {
                Button(action: {
                    do {
                        try viewModel.addTask()
                        dismiss()
                    } catch(let error) {
                        if let myError = error as? ErrorTypes {
                            errorMessage = myError.getDescription()
                            isAlertPresent.toggle()
                        } else {
                            errorMessage = "Something went wrong."
                            isAlertPresent.toggle()
                        }
                    }
                }, label: {
                    Text("Save")
                        .foregroundColor(.blue)
                })
            }
            Section("Dismiss") {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                })
            }
        }
        .padding(24)
        .alert(errorMessage, isPresented: $isAlertPresent) {
            Button("OK", role: .cancel) { }
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(viewModel: NewTaskViewModel(order: 0))
    }
}
