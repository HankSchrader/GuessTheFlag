//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Sara Nicole Mikac on 2/9/20.
//  Copyright © 2020 Erik Mikac. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var score = 0
    @State private var article = ""
    @State private var wrongAnswer = 0
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany",
    "Ireland", "Italy", "Nigeria", "Poland", "Russia",
        "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white).font(.largeTitle).fontWeight(.black)
                }
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flaggedtapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                    
                }
                Text("Current Score: \(score).").foregroundColor(.white).font(.subheadline).fontWeight(.semibold)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("That is the  flag of \(self.countries[wrongAnswer])"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    func flaggedtapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            wrongAnswer = number
            scoreTitle = "Wrong!"
            score += -1
        }
        
        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
