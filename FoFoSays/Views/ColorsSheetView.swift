//
//  ColorsSheetView.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/14/23.
//

import SwiftUI

struct ColorsSheetView: View {
    
    @ObservedObject var colorsSheetViewModel: ColorsSheetViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(colorsSheetViewModel.colorSchemeData, id: \.title) { colorScheme in
                    Button {
                        colorsSheetViewModel.selectedColorScheme(index: colorScheme.index)
                    } label: {
                        ColorSelectionsView(colors: colorScheme.colors, colorSchemeTitle: colorScheme.title, isSelect: colorScheme.isSelected)
                    }
                }
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    ColorsSheetView(colorsSheetViewModel: ColorsSheetViewModel(gameLogic: GameLogic()))
}

struct ColorSelectionsView: View {
    
    let colors: [Color]
    let colorSchemeTitle: String
    private let aspectRatio = 1.0
    var isSelect: Bool
    
    var body: some View {
        ZStack {
            if isSelect {
                Rectangle()
                    .fill(.blue)
                    .cornerRadius(15)
                    .opacity(0.15)
            }
            Rectangle()
                .fill(.clear)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.blue, lineWidth: 1)
                )
            VStack {
                Text(colorSchemeTitle)
                    .font(.title)
                    .fontWeight(.ultraLight)
                    .foregroundStyle(.black)
                ZStack {
                    HStack {
                        Rectangle()
                            .fill(colors[0])
                            .aspectRatio(aspectRatio, contentMode: .fit)
                        Rectangle()
                            .fill(colors[1])
                            .aspectRatio(aspectRatio, contentMode: .fit)
                        Rectangle()
                            .fill(colors[2])
                            .aspectRatio(aspectRatio, contentMode: .fit)
                        Rectangle()
                            .fill(colors[3])
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                    .padding(EdgeInsets(top: -10, leading: 8, bottom: 8, trailing: 8))
                }
            }
        }
    }
    
}
