//
//  ContentView.swift
//  MinimalistCalculator
//
//  Created by Daniel Garcia on 12/8/22.
//

import SwiftUI

struct ContentView: View {
    @State private var currentLine = ""
    
    var body: some View {
        ZStack {
            // Color.teal
            
            VStack {
                Text(currentLine)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                
                Grid {
                    ForEach(0..<buttonRows.count, id: \.self) { rowIndex in
                        GridRow {
                            ForEach(0..<buttonRows[rowIndex].count, id: \.self) { columnIndex in
                                buttonRows[rowIndex][columnIndex]
                            }
                        }
                    }
                }
            }
            .padding(.all)
        }
    }

    var rows: [[ButtonOption]] {
        [
            [.seven, .eight, .nine, .empty, .delete],
            [.four, .five, .six, .division, .times],
            [.one, .two, .three, .minus, .plus],
            [.zero, .dot, .openParenthesis, .closeParenthesis, .equal]
        ]
    }

    var buttonRows: [[some View]] {
        rows.map { row in
            row.map { buttonOption in
                calculatorButtons(buttonOption: buttonOption)
            }
        }
    }

    func calculatorButtons(buttonOption: ButtonOption) -> AnyView {
        [
            .empty: AnyView(Text("")),
            .zero: numberButton(text: String(0)),
            .one: numberButton(text: String(1)),
            .two: numberButton(text: String(2)),
            .three: numberButton(text: String(3)),
            .four: numberButton(text: String(4)),
            .five: numberButton(text: String(5)),
            .six: numberButton(text: String(6)),
            .seven: numberButton(text: String(7)),
            .eight: numberButton(text: String(8)),
            .nine: numberButton(text: String(9)),
            .delete: AnyView(
                Button {
                    withAnimation {
                        _ = currentLine.popLast()
                    }
                } label: {
                    Image(systemName: "delete.left")
                }
                .frame(width: 20, height: 20)
                .padding()
                .foregroundColor(.primary)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
            ),
            .openParenthesis: numberButton(text: "("),
            .closeParenthesis: numberButton(text: ")"),
            .times: symbolButton(text: "x"),
            .division: symbolButton(text: "/"),
            .dot: numberButton(text: "."),
            .minus: symbolButton(text: "—"),
            .plus: symbolButton(text: "+"),
            .equal: AnyView(
                Button {
                    withAnimation {
                        currentLine.append("=")
                    }
                } label: {
                    Text("=")
                }
                .frame(width: 20, height: 20)
                .padding()
                .foregroundColor(.white)
                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 5))
            ),
        ][buttonOption]!
    }

    func numberButton(text: String) -> AnyView {
        AnyView(
            appendButton(text: text)
                .foregroundColor(.primary)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 5))
        )
    }

    func symbolButton(text: String) -> AnyView {
        AnyView(
        appendButton(text: text)
            .foregroundColor(.white)
            .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 5))
        )
    }

    func appendButton(text: String) -> AnyView {
        AnyView(
            Button {
                withAnimation {
                    currentLine.append(text)
                }
            } label: {
                Text(text)
            }
            .frame(width: 20, height: 20)
            .padding()
        )
    }
}

enum ButtonOption {
    case empty, dot, zero, one, two, three, four, five, six, seven, eight, nine, minus, plus, equal, times, division, openParenthesis, closeParenthesis, delete
}

enum ButtonType {
    case number, symbol, primary, empty
}

struct CalculatorButton: Identifiable {
    let id = UUID()
    let view: AnyView
    let buttonType: ButtonType
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
