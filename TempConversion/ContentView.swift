//
//  ContentView.swift
//  TempConversion
//
//  Created by Simone on 11/15/24.
//

import SwiftUI

struct ContentView: View {
    let tempConversion = ["Celcius", "Fahrenheit", "Kelvin"]
    
    @State private var userTemp = 0.0
    @State private var userScale = "Fahrenheit"
    @State private var convertToTempScale = ""
    //make the keyboard dismiss
    @FocusState private var amountIsFocused: Bool
    
    var tempResult: Double {
        return getTemp(convertToTempScale)
    }
    
    func getTemp(_ conversion: String) -> Double {
        if userScale == conversion {
            return userTemp
        }
        switch conversion {
        case "Celcius":
            if userScale == "Fahrenheit" {
                return (userTemp * 9/5) + 32
            }
            if userScale == "Kelvin" {
                return (userTemp + 273.15)
            }
        case "Fahrenheit":
            if userScale == "Celcius" {
                return (userTemp - 32) * (5/9)
            }
            if userScale == "Kelvin" {
                return ((userTemp - 32) * (5/9)) + 273.15
            }
        case "Kelvin":
            if userScale == "Fahrenheit" {
                return ((userTemp - 273.15) * (9/5)) + 32
            }
            if userScale == "Celcius" {
                return (userTemp - 273.15)
            }
        default:
            return 0
        }
        return 0
    }
    
    
    var body: some View {
        NavigationStack {
           form
            .navigationTitle("Temperature Conversion")
            //make navigation bar small
            .navigationBarTitleDisplayMode(.inline)
            //dismiss the keyboard
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    var form: some View {
        Form {
            Section("Enter a temperature") {
                TextField("Enter a temperature", value: $userTemp, format: .number.decimalSeparator(strategy: .automatic)).keyboardType(.decimalPad).focused($amountIsFocused)
                Picker("Degrees", selection: $userScale) {
                    ForEach(tempConversion, id: \.self) {
                        Text($0)
                    }
                }
            }
            Section("Select the temperature for conversion") {
                Picker("Conversion", selection: $convertToTempScale) {
                    ForEach(tempConversion, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            Section {
                Text(tempResult, format: .number)
            }
        }
    }
}

#Preview {
    ContentView()
}
