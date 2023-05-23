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
    @State private var questionCount = 0
    
    @State private var showingResult = false
    
    @State private var randomIndex = Int.random(in: 0...9)
    
    @State private var dragAmount = CGSize.zero
    
    enum FocusedField {
        case inputField
    }
    @FocusState private var focusedField: FocusedField?
    
    var questions: [String] {
        var questionsArray = [String]()
        
        for i in 1...10 {
            questionsArray.append("What is \(timesTableSelection) * \(i)")
        }
        
        return questionsArray
    }
    
    var answers: [Int] {
        var answersArray = [Int]()
        
        for i in 1...10 {
            answersArray.append(timesTableSelection * i)
        }
        
        return answersArray
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text("\(questions[randomIndex])?")
                    .font(.title)
                    .frame(width: 400, height: 100)
                    .background(.yellow)
                    .offset(dragAmount)
                    .gesture(
                        DragGesture ()
                            .onChanged { dragAmount = $0.translation } // runs when user moves the finger
                            .onEnded { _ in dragAmount = .zero } //fired when user lift the finger
                    )
                    .animation(.interpolatingSpring(stiffness: 5, damping: 1), value: dragAmount)
                
                
                TextField("Enter answer..", text: $userAnswer)
                    .padding()
                    .border(.cyan)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($focusedField, equals: .inputField)
                
                Button(action: {
                    checkAnswer()
                }){
                    Text("Next")
                        .frame(width: 200, height: 70)
                }
                .foregroundColor(.white)
                .background(.cyan)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .contentShape(RoundedRectangle(cornerRadius: 20))
                
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
                HStack {
                    Text("Your points:")
                    Text("\(score)/\(questionsAmountSelection)")
                        .fontWeight(.bold)
                        .animation(.linear, value: score)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .font(.title)
                .background(.cyan)
            }
            .background {
                Image("background")
                    .opacity(0.10)
            }
        }
    }
    
    func checkAnswer() {
        if Int(userAnswer) == answers[randomIndex] {
            score += 1
            askQuestion()
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        questionCount += 1
        userAnswer = ""
        randomIndex = Int.random(in: 0...9)
        
        if questionCount == questionsAmountSelection {
            showingResult = true
        }
    }
    
    func newGame() {
        score = 0
        questionCount = 1
        userAnswer = ""
        randomIndex = Int.random(in: 0...9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(timesTableSelection: SettingsView().$timesTableSelection, questionsAmountSelection: SettingsView().$questionsAmountSelection)
    }
}
