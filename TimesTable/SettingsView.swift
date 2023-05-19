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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
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
                            .opacity(0.5)
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
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
