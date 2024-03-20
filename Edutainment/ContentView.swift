//
//  ContentView.swift
//  Edutainment
//
//  Created by Friedrich Vorländer on 19.03.24.
//

import SwiftUI
struct ContentView: View {
    @State private var Multiplicator = 15
    @State private var ÜbungsfragenAnzahl = 5
    @State private var guesses = Array(repeating: 0, count: 20)
    @State private var MultiplicatorArray = [1, 4 , 3, 2 , 5, 7 , 6, 12, 10, 8, 9, 11].shuffled()
    @State private var showAnswers = Array(repeating: false, count: 20)
    @State private var einmaleins = "großes 1x1"
    
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    Picker("Hello", selection: $einmaleins){
                        Text("Großes 1x1").tag("großes 1x1")
                        Text("Kleines 1x1").tag("kleines 1x1")
                    }
                    .labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: einmaleins) {
                        updateeinmaleins()
                    }
                }
                
                Section("Welchen Multiplikator möchtest du üben?"){
                    Stepper("\(Multiplicator)", value: $Multiplicator, in: einmaleins == "großes 1x1" ? 10...20 : 1...10)
                }
                Section("Wie viele Übungsfragen möchtest du?") {
                    Picker("Test", selection: $ÜbungsfragenAnzahl) {
                        ForEach(0..<21) {
                            Text("\($0)")
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.wheel)
                }
                Section("Übungsfragen"){
                    ForEach(0..<ÜbungsfragenAnzahl, id: \.self){ number in
                        let randomQuestionMultiplikator = Int.random(in: 1...12)
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Was ist \(Multiplicator) * \(randomQuestionMultiplikator)?")
                                    TextField("Antwort", value: $guesses[number], formatter: NumberFormatter())
                                        .keyboardType(.numberPad)
                                    
                                }
                                
                                Button("Überprüfen") {
                                    
                                    showAnswers[number].toggle()
                                    
                                }
                                .frame(width: 100, height: 50)
                                
                            }
                            if showAnswers[number] == true{
                                Spacer()
                                if checkAnswer(RandomMultiplicator: randomQuestionMultiplikator, userAnswer: guesses[number]){
                                    Text("Richtig ✅")
                                } else{
                                    Text("Falsch ❌")
                                }
                                
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    }
                    
                    
                }
                
            }
            .toolbar{
                Button("Neue Fragen"){
                    MultiplicatorArray = MultiplicatorArray.shuffled()
                }
            }
            .navigationTitle(einmaleins == "großes 1x1" ? "Das große 1x1" : "Das kleine 1x1")
           
        }
    }
    
    func checkAnswer(RandomMultiplicator : Int, userAnswer : Int) -> Bool{
        if userAnswer == RandomMultiplicator * Multiplicator{
            
            return true
        }
        return false
    }
    func updateeinmaleins(){
        if einmaleins == "großes 1x1"{
            Multiplicator = 15
        } else{
            Multiplicator = 5
        }
    }
}


#Preview {
    ContentView()
}
