//
//  ContentView.swift
//  Project2 GuessTheFlag
//
//  Created by Stefan Storm on 2024/12/13.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State var tappedFlag = ""
    @State var alertText = "Continue"
    @State var gameOver = false
    @State var questionsAsked = 0
    
    
    var body: some View {
        ZStack{
//            LinearGradient(colors: [.purple, .black], startPoint: .top, endPoint:                    .bottom)
//                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.0, green: 0.0, blue: 0.75), location: 0.4),
                .init(color: .black, location: 0.6)
            ],center: .bottom, startRadius: 300, endRadius: 500)
            
            .ignoresSafeArea()

            VStack{
                Spacer()
                Text("Guess he flag!")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack(spacing: 0){
                        Text("Tap the flag of")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) { number in
                        
                        Button {
                            tappedFlag = countries[number]
                            flagTapped(number)
                        } label: {
                            //    print(number)
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .overlay(RoundedRectangle(cornerRadius: 10 ).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                        .shadow(radius: 5)
                        
                        //  .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 2.0)))
                        
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
            }
            .padding()
        }
        
        .alert(scoreTitle,isPresented: $showingScore){
            Button(alertText, action: askQuestion)
        }message: {
            Text("Your score is \(score)")
        }

    }
    
    func flagTapped(_ number: Int){
        
        questionsAsked += 1
    
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        }else{
            scoreTitle = "Wrong, that is \(tappedFlag)'s flag."
            score -= 1
        }
        
        showingScore = true
        
        if questionsAsked == 8{
            scoreTitle = "Game Over"
            alertText = "Restart"
            questionsAsked = 0
            showingScore = true
            gameOver = true

        }
    }
    
    func askQuestion(){
        if gameOver{
            score = 0
            gameOver = false
        }
        
        alertText = "Continue"
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}







#Preview {
    ContentView()
}
