//
//  TaskListView.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import SwiftUI

struct TaskListView: View {
    
    @StateObject var viewModel = TaskListViewModel()
    @State var showAddPage = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.model, id: \.id) { item in
                    TaskCellView(viewModel: item)
                }
                .onMove(perform: viewModel.move)
            }
                .navigationTitle("Task Manager")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showAddPage.toggle()
                        } label: {
                            Label("Add Task", systemImage: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            viewModel.showCompeleted.toggle()
                            viewModel.refreshModel()
                        } label: {
                            Label("Filter", systemImage: viewModel.showCompeleted ? "checkmark.circle" : "circle" )
                        }
                    }
                }
                .sheet(isPresented: $showAddPage, onDismiss: {
                    viewModel.refreshModel()
                }) {
                    AddTaskView(viewModel: NewTaskViewModel(order: viewModel.model.count))
                        .environmentObject(viewModel)
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
