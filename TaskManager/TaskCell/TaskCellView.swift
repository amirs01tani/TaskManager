//
//  TaskCellView.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import SwiftUI

struct TaskCellView: View {
    
    @StateObject var viewModel: TaskViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                CustomText(text: viewModel.title, font: .headline, color: .heading)
                CustomText(text: viewModel.desc, font: .caption, color: .caption)
                Text("\(viewModel.order)")
            }
            Spacer()
            Button(action: {
                viewModel.toggleHasDone()
            }, label: {
                Image(systemName: viewModel.hasDone ? "checkmark.circle" : "circle")
            })
            
        }
    }
}



