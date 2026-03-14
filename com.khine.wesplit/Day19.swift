//
//  Day19.swift
//  com.khine.wesplit
//
//  Created by MayMK on 3/14/26.
//

import SwiftUI

struct DAY19 : View {
    enum UnitTypes: CaseIterable {
        case Temperature
        case Length
        case Time
        case Volume
    }
    
    enum TemperatureUnit: String, CaseIterable {
        case celsius = "Celsius"
        case fahrenheit = "Fahrenheit"
        case kelvin = "Kelvin"
    }
    
    enum LengthUnit: String, CaseIterable {
        case meters = "Meters"
        case kilometers = "Kilometers"
        case feet = "Feet"
        case yards = "Yards"
        case miles = "Miles"
    }
    
    enum TimeUnit: String, CaseIterable {
        case seconds = "Seconds"
        case minutes = "Minutes"
        case hours = "Hours"
        case days = "Days"
    }
    
    enum VolumeUnit: String, CaseIterable {
        case milliliters = "Milliliters"
        case liters = "Liters"
        case cups = "Cups"
        case pints = "Pints"
        case gallons = "Gallons"
    }
    
    @State var selectedType : UnitTypes = .Time
    @State var input : Double = 0.0
   
    var unitsList : [String]  {
        switch  selectedType{
        case .Temperature:
            return TemperatureUnit.allCases.map {$0.rawValue}
        case .Length:
            return LengthUnit.allCases.map {$0.rawValue}
        case .Time:
            return TimeUnit.allCases.map {$0.rawValue}
        case .Volume:
            return VolumeUnit.allCases.map {$0.rawValue}
        }
    }
    
    @State var inputType : String = ""
    @State var outputType : String = ""
    
    var toBaseValue : Double {
        if selectedType == .Temperature {
            switch inputType {
            case TemperatureUnit.celsius.rawValue:
              return input
            case TemperatureUnit.fahrenheit.rawValue:
                //(F−32)×95
                return (input-32) * 5 / 9
            case TemperatureUnit.kelvin.rawValue:
                //K−273.15
                return input - 273.15
            default :
                return 0.0
            }
        } else if selectedType == .Length {
            switch inputType {
            case LengthUnit.meters.rawValue:
                return input
            case LengthUnit.kilometers.rawValue:
                return input * 1000
            case LengthUnit.feet.rawValue:
                return input * 0.3048
            case LengthUnit.yards.rawValue:
                return input * 0.9144
            case LengthUnit.miles.rawValue:
                return input * 1609.344
            default:
                return 0.0
            }
        }
        else if selectedType == .Time{
            switch  inputType {
            case TimeUnit.seconds.rawValue:
                return input
            case TimeUnit.minutes.rawValue:
                return input * 60
            case TimeUnit.hours.rawValue:
                return input * 3600
            case TimeUnit.days.rawValue:
                return input * 86400
            default:
                return 0.0
            }
        }
        else {
            switch inputType {
            case VolumeUnit.milliliters.rawValue:
                return input
            case VolumeUnit.liters.rawValue:
                return input * 1000
            case VolumeUnit.cups.rawValue:
                return input * 236.588
            case VolumeUnit.pints.rawValue:
                return input * 473.176
            case VolumeUnit.gallons.rawValue:
                return input * 3785.41
            default:
                return 0.0
            }
        }
    }
    
    var output : Double {
        switch selectedType {
        case .Temperature:
            switch outputType {
            case TemperatureUnit.celsius.rawValue:
                return toBaseValue
            case TemperatureUnit.fahrenheit.rawValue:
                //(C×59​)+32
                return (toBaseValue * (9 / 5)) + 32
            case TemperatureUnit.kelvin.rawValue:
                //C+273.15
                return toBaseValue + 273.15
            default:
                return 0.0
            }
        case .Length:
            switch outputType {
            case LengthUnit.meters.rawValue:
                return toBaseValue
            case LengthUnit.kilometers.rawValue:
                return toBaseValue / 1000
            case LengthUnit.feet.rawValue:
                return toBaseValue / 0.3048
            case LengthUnit.yards.rawValue:
                return toBaseValue / 0.9144
            case LengthUnit.miles.rawValue:
                return toBaseValue / 1609.344
            default:
                return 0.0
            }
           
        case .Time:
            switch  outputType {
            case TimeUnit.seconds.rawValue:
                return toBaseValue
            case TimeUnit.minutes.rawValue:
                return toBaseValue / 60
            case TimeUnit.hours.rawValue:
                return toBaseValue / 3600
            case TimeUnit.days.rawValue:
                return toBaseValue / 86400
            default:
                return 0.0
            }
        case .Volume:
            switch outputType {
            case VolumeUnit.milliliters.rawValue:
                return toBaseValue
            case VolumeUnit.liters.rawValue:
                return toBaseValue / 1000
            case VolumeUnit.cups.rawValue:
                return toBaseValue / 236.588
            case VolumeUnit.pints.rawValue:
                return toBaseValue / 473.176
            case VolumeUnit.gallons.rawValue:
                return toBaseValue / 3785.41
            default:
                return 0.0
            }
        }
    }
    
    var body : some View {
        Form{
            Section("Select Type First"){
                Picker("Your selected Type to convert is ",selection: $selectedType){
                    ForEach(UnitTypes.allCases, id: \.self){
                        Text(String(describing : $0))
                    }
                }
            }
            Section("Choose the Unit and give input for convertion"){
                TextField("Your Input", value:  $input, format: .number)
                Picker("Choose Type For Input", selection: $inputType){
                    ForEach(unitsList.filter{ $0 != outputType},id: \.self){
                        Text($0)
                    }
                    
                }.pickerStyle(.segmented)
                
                Picker("Choose Type For Output", selection: $outputType){
                    ForEach(unitsList.filter{$0 != inputType},id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
                
            }
            Text ("Converting From \(input.formatted()) \(inputType) to \(output.formatted()) \(outputType)")
            
        }
    }
}


#Preview {
    DAY19()
}
