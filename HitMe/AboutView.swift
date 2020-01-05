//
//  AboutView.swift
//  HitMe
//
//  Created by Angelos Roussakis on 5/1/20.
//  Copyright © 2020 Angelos Roussakis. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
    
    struct AboutHeadingStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 30))
                .foregroundColor(Color.black)
                .padding(.top, 20)
                .padding(.bottom, 20)
        }
    }
    
    struct AboutBodyStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 16))
                .foregroundColor(Color.black)
                .padding(.leading, 60)
                .padding(.trailing, 60)
                .padding(.bottom, 20)
        }
    }
    
    var body: some View {
        Group {
            VStack {
                Text("🎯 Hit Me 🎯").modifier(AboutHeadingStyle())
                Text("Try to move the slider as close as you can to win points!").modifier(AboutBodyStyle())
                Text("Angelos Roussakis Creations.").modifier(AboutBodyStyle())
            }
            .navigationBarTitle("About HitMe")
            .background(beige)
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
