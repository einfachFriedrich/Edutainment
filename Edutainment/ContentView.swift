//
//  ContentView.swift
//  Edutainment
//
//  Created by Friedrich Vorländer on 19.03.24.
//

import SwiftUI
struct ContentView: View {
    @State private var Multiplicator = 2
    @State private var ÜbungsfragenAnzahl = 1
    @State private var guesses = Array(repeating: 0, count: 20)
    @State private var guess = 0
    @State private var MultiplicatorArray = [1, 4 , 3, 2 , 5, 7 , 6, 12, 10, 8, 9, 11].shuffled()
    @State private var showAnswers = Array(repeating: false, count: 20)
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Welchen Multiplikator möchtest du üben?"){
                    Stepper("\(Multiplicator)", value: $Multiplicator)
                }
                Section("Wie viele Übungsfragen möchtest du?") {
                    Picker("Test", selection: $ÜbungsfragenAnzahl) {
                        ForEach(0..<21) {
                            Text("\($0)")
                        }
                    }
                }
                Section("Übungsfragen"){
                    ForEach(0..<ÜbungsfragenAnzahl, id: \.self){ number in
                        let randomQuestionMultiplikator = MultiplicatorArray[number]
                        HStack{
                            VStack(alignment: .leading){
                                Text("Was ist \(Multiplicator) * \(randomQuestionMultiplikator)?")
                                TextField("Antwort", value: $guess, formatter: NumberFormatter())
                                
                                if showAnswers[number] == true{
                                    if checkAnswer(RandomMultiplicator: randomQuestionMultiplikator, userAnswer: guess){
                                        Text("Richtig ✅")
                                    } else{
                                        Text("Falsch ❌")
                                    }
                                }
                            }
                            Button("Überprüfen") {
                                showAnswers[number] = true
                            }
                        }
                    }
                    
                }
            }
            
            .navigationTitle("Das kleine 1x1")
        }
    }
    func checkAnswer(RandomMultiplicator : Int, userAnswer : Int) -> Bool{
        if userAnswer == RandomMultiplicator * Multiplicator{
            return true
        }
        return false
    }
}


#Preview {
    ContentView()
}
