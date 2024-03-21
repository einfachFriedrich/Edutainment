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
    @State private var MultiplicatorArray = [2,3,4,5,6,7,8,9,10,Int.random(in: 1...10), Int.random(in: 1...10)].shuffled()
    @State private var showAnswers = Array(repeating: false, count: 20)
    @State private var einmaleins = "großes 1x1"
    @State private var checkAll = false
    
    
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
                    .onAppear{
                        updateeinmaleins()
                    }
                }
                
                Section("Welchen Multiplikator möchtest du üben?"){
                    Stepper("\(Multiplicator)", value: $Multiplicator, in: einmaleins == "großes 1x1" ? 10...20 : 1...10)
                }
                Section("Wie viele Übungsfragen möchtest du?") {
                    Picker("Test", selection: $ÜbungsfragenAnzahl) {
                        if einmaleins == "kleines 1x1"{
                            ForEach(0..<11) {
                                Text("\($0)")
                            }
                        } else{
                            ForEach(0..<21) {
                                Text("\($0)")
                            }
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.wheel)
                }
                Section("Übungsfragen"){
                    ForEach(0..<ÜbungsfragenAnzahl, id: \.self){ number in
                        
                        let randomQuestionMultiplikator = MultiplicatorArray[number]
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
                            if checkAll || showAnswers[number] == true && guesses[number] != 0{
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
                    guesses = Array(repeating: 0, count: 20)
                    checkAll = false
                }
                Button(checkAll ? "Antorten verstecken" : "Überprüfen"){
                    checkAll.toggle()
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
            MultiplicatorArray = [2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20, Int.random(in: 1...20), Int.random(in: 1...20)].shuffled()
        } else{
            Multiplicator = 5
            if ÜbungsfragenAnzahl > 10{
                ÜbungsfragenAnzahl = 10
            }
            MultiplicatorArray = [2,3,4,5,6,7,8,9,10, Int.random(in: 1...10), Int.random(in: 1...10)].shuffled()
        }
    }
}


#Preview {
    ContentView()
}
