//
//  SettingsView.swift
//  TimesTable
//
//  Created by Anastasiia Solomka on 18.05.2023.
//

import SwiftUI

struct SettingsView: View {
    @State public var timesTableSelection = 2
    @State public var questionsAmountSelection = 5
    
    let questionsAmount = [5, 10, 15]
    
    @State private var animationAmount = 1.0
    
    let title = Array("Times table game")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    HStack(spacing: 0) {
                        ForEach (0..<title.count) { num in
                            Text(String(title[num]))
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .padding(3)
                                .background(enabled ? .orange : .cyan)
                                .offset(dragAmount)
                                .animation(
                                    .default.delay(Double(num) / 20),
                                    value: dragAmount
                                )
                        }
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                dragAmount = .zero
                                enabled.toggle()
                            }
                    )
                    List {
                        Section {
                            Text("Select times table for practicing")
                                .font(.headline)
                                .padding()
                            
                            Stepper("Times table for \(timesTableSelection)", value: $timesTableSelection, in: 2...12, step: 1)
                                .padding()
                        }
                        
                        Section {
                            Text("How many questions you want to practice?")
                                .font(.headline)
                                .padding()
                            
                            Picker("Question amount", selection: $questionsAmountSelection) {
                                ForEach(questionsAmount, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                            .padding()
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .background {
                        Image("background")
                            .opacity(0.10)
                    }
                    .listStyle(.grouped)
                    .listRowBackground(Color.red)
                    
                    Spacer()
                    
                    NavigationLink {
                        ContentView(timesTableSelection: $timesTableSelection, questionsAmountSelection: $questionsAmountSelection)
                    } label: {
                        Text("Start new game")
                            .frame(width: 200, height: 70)
                            .foregroundColor(.white)
                            .background(.cyan)
                            .font(.headline)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(.cyan)
                                    .scaleEffect(animationAmount)
                                    .opacity(2 - animationAmount)
                                    .animation(
                                        .easeInOut(duration: 2)
                                        .repeatForever(autoreverses: false),
                                        value: animationAmount
                                    )
                            )
                            .onAppear {
                                animationAmount = 2
                            }
                        
                    }
                }
                //.navigationTitle("Settings")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
