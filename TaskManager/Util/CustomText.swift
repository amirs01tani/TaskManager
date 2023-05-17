//
//  CustomText.swift
//  TaskManager
//
//  Created by Amir on 5/15/23.
//

import SwiftUI

enum TitleColor {
    case heading
    case caption
    
    func getColor() -> String {
        switch self {
        case .heading:
            return "TitleColor"
        case .caption:
            return "CaptionColor"
        }
    }
}


struct CustomText: View {
    
    let text: String
    let font: Font
    let color: TitleColor
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(Color(color.getColor()))
    }
}

struct CustomText_Previews: PreviewProvider {
    static var previews: some View {
        CustomText(text: "Sample", font: .title, color: .heading)
    }
}
