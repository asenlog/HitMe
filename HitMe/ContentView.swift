//
//  ContentView.swift
//  HitMe
//
//  Created by Angelos Roussakis on 2/1/20.
//  Copyright © 2020 Angelos Roussakis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var startOverPressed = false
    @State var score = 0
    @State var round = 1
    
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct ShadowStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .shadow(color: Color.black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .modifier(ShadowStyle())
            .foregroundColor(Color.white)
        }
    }
    
    struct ValueStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 24))
            .modifier(ShadowStyle())
            .foregroundColor(Color.yellow)
        }
    }
    
    struct ButtonLargeTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 18))
            .foregroundColor(Color.black)
        }
    }
    
    struct ButtonSmallTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
            .font(Font.custom("Arial Rounded MT Bold", size: 12))
            .foregroundColor(Color.black)
        }
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            HStack {
                Text("Put Slider as close as you can to:").modifier(LabelStyle())
                Text("\(target)").modifier(ValueStyle())
            }
            
            Spacer()
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            
            Spacer()
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit Me").modifier(ButtonLargeTextStyle())
            }.alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(
                    title: Text(alertTitle()),
                    message: Text("The Slider value is: \(sliderValueRounded()).\n You scored \(pointForCurrentRound()) point this round"),
                    dismissButton: .default(Text("Awesome!")) {
                        self.score += self.pointForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                    }
                )
                }.background(Image("Button")).modifier(ShadowStyle())
            
            Spacer()
            HStack {
                Button(action: {
                    self.startOver()
                }) {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
                
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                
                Spacer()
                NavigationLink(destination: AboutView()) {
                HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                    }
                }.background(Image("Button")).modifier(ShadowStyle())
            }.padding(.bottom, 20)

        }.background(Image("Background"), alignment: .center)
         .accentColor(midnightBlue)
         .navigationBarTitle("HitMe")
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func amountOff() -> Int {
        return abs(target - sliderValueRounded())
    }
    
    func pointForCurrentRound() -> Int {
        let maxScore = 100
        let diff = amountOff()
        var bonus = 0
        
        if diff == 0 {
            bonus = 100
        } else if diff == 1 {
            bonus = 50
        }
        
        return maxScore - diff + bonus
    }
    
    func alertTitle() -> String {
        let diff = amountOff()
        
        if diff == 0 {
            return "Bullseye!"
        } else if diff < 5 {
            return "Almost Had It!"
        } else if diff <= 10 {
            return "Not Bad"
        } else {
            return "Are you even trying?!?"
        }
    }
    
    func startOver() {
        score = 0
        round = 0
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}

