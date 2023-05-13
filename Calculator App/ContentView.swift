//
//  ContentView.swift
//  Calculator App
//
//  Created by Quang Anh on 12/05/2023.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case mutiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .add, .subtract, .divide, .mutiply:
            return.orange
        case .clear, .negative, .percent:
            return Color(.gray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        
        }
    }
}
enum Operation{
    case add, subtract, divide, mutiply, none
}

struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none

    let button: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                //TEXT DISPLAY
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                }
                .padding()
                
                //OUR BUTTON
                ForEach(button, id: \.self) {row in
                    HStack (spacing: 12){
                        ForEach(row, id:\.self) { item in Button(action: {
                            self.Tap(button: item)
                        }, label: {
                            Text(item.rawValue)
                                .font(.system(size: 32))
                                .frame(
                                    width: self.buttonWidth(item: item),
                                    height: self.buttonHeight()
                                )
                                .background(item.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(40)
                        })
                            
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
    func Tap(button: CalcButton){
        switch button{
        case .equal, .add, .subtract, .mutiply, .divide:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .mutiply{
                self.currentOperation = .mutiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(currentValue + runningValue)"
                case .subtract: self.value = "\(currentValue - runningValue)"
                case .mutiply: self.value = "\(currentValue * runningValue)"
                case .divide: self.value = "\(currentValue / runningValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative, .percent:
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
        }
    }
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return((UIScreen.main.bounds.width - (5*12)) / 4) * 2
        }
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeight() -> CGFloat {
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
