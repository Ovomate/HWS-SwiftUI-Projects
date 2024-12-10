//
//  ContentView.swift
//  Project1 WeSplit
//
//  Created by Stefan Storm on 2024/11/07.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var grandTotal: Double{
        
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    
    var body: some View {
        
        if #available(iOS 16.0, *) {
            NavigationStack{
                Form{
                    Section("Amount and total people:"){
                        
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of people", selection: $numberOfPeople){
                            ForEach(2..<100){
                                Text("\($0) people")
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                        
                    }
                    
                    Section("Tip percentage:") {
                        Picker("Tip percentage", selection: $tipPercentage){
                            ForEach(Array(stride(from: 0, to: 105, by: 5)), id: \.self){
                                Text($0,format: .percent)
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    Section("Amounut with tip included:"){
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                    }
                    
                    Section("Final amount/person:"){
                        
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "ZAR"))
                        
                    }
                    

                }
                
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.large)
                .toolbar{
                    if amountIsFocused {
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
            }

        } else {
            // Fallback on earlier versions
        }
        

    }
}

#Preview {
    ContentView()
}
