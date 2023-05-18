//
//  ContentView.swift
//  TimesTable
//
//  Created by Anastasiia Solomka on 17.05.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding public var timesTableSelection: Int
    @Binding public var questionsAmountSelection: Int
    
    @State private var userAnswer = ""
    @State private var score = 0
    @State private var questionCount = 1
    
    @State private var showingResult = false
    
    @State private var number = Int.random(in: 2...10)
    
    enum FocusedField {
        case inputField
    }
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("What is \(timesTableSelection) * \(number) ?")
                    .font(.title)
                    .frame(width: 400, height: 100)
                    .background(.yellow)
                
                TextField("Enter answer..", text: $userAnswer)
                    .padding()
                    .border(.cyan)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .inputField)
                
                Button("Next"){
                    checkAnswer()
                }
                .frame(width: 200, height: 70)
                .foregroundColor(.white)
                .background(.cyan)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
            }
            .alert("Good job!", isPresented: $showingResult) {
                Button("Start new game", action: newGame)
                    .foregroundColor(.red)
            } message: {
                Text("Bro your points are \(score)/\(questionsAmountSelection)")
            }
            .onAppear {
                focusedField = .inputField
            }
            .onSubmit {
                focusedField = .inputField
            }
            .safeAreaInset(edge: .bottom) {
                Text("Your points: \(score)/\(questionsAmountSelection)")
                    .scaleEffect()
                    .animation(.default, value: score)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .font(.title)
                    .background(.cyan)
            }
        }
    }
    
    func checkAnswer() {
        if Int(userAnswer) == timesTableSelection * number {
            score += 1
            askQuestion()
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        questionCount += 1
        userAnswer = ""
        number = Int.random(in: 2...10)
        
        if questionCount == questionsAmountSelection {
            showingResult = true
        }
    }
    
    func newGame() {
        score = 0
        questionCount = 1
        userAnswer = ""
        number = Int.random(in: 2...10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timesTableSelection: SettingsView().$timesTableSelection, questionsAmountSelection: SettingsView().$questionsAmountSelection)
    }
}
