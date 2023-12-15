//
//  ColorSchemeDataSource.swift
//  FoFoSays
//
//  Created by Forrest Hickey on 12/15/23.
//

import SwiftUI

final class ColorSchemeDataSource {
    
    let colorData: [ColorSchemeModel] = [
        ColorSchemeModel(colors: [.green, .red, .yellow, .blue], title: "Classic", index: 0),
        ColorSchemeModel(colors: [Color(hex: "FFCCBB"), Color(hex: "6EB5C0"), Color(hex: "006C84"), Color(hex: "E2E8E4")], title: "Arctic Sunrise", index: 1),
        ColorSchemeModel(colors: [Color(hex: "003B46"), Color(hex: "07575B"), Color(hex: "66A5AD"), Color(hex: "C4DFE6")], title: "Cool Blues", index: 2),
        ColorSchemeModel(colors: [Color(hex: "0F1F38"), Color(hex: "8E7970"), Color(hex: "F55449"), Color(hex: "1B4B5A")], title: "High-Impact", index: 3),
        ColorSchemeModel(colors: [Color(hex: "2C4A52"), Color(hex: "537072"), Color(hex: "8E9B97"), Color(hex: "F4EBDB")], title: "Hazy", index: 4),
        ColorSchemeModel(colors: [Color(hex: "262F34"), Color(hex: "F34A4A"), Color(hex: "F1D3BC"), Color(hex: "615049")], title: "Shadowy", index: 5),
        ColorSchemeModel(colors: [Color(hex: "A49592"), Color(hex: "727077"), Color(hex: "EED8C9"), Color(hex: "E99787")], title: "Smokey", index: 6),
        ColorSchemeModel(colors: [Color(hex: "90AFC5"), Color(hex: "336B87"), Color(hex: "2A3132"), Color(hex: "763626")], title: "Professional", index: 7),
        ColorSchemeModel(colors: [Color(hex: "FFECD6"), Color(hex: "4CB9E7"), Color(hex: "3559E0"), Color(hex: "0F2167")], title: "Beachgoer", index: 8),
        ColorSchemeModel(colors: [Color(hex: "C5FFF8"), Color(hex: "96EFFF"), Color(hex: "5FBDFF"), Color(hex: "7B66FF")], title: "Sea Breeze", index: 9)
    ]
    
}
