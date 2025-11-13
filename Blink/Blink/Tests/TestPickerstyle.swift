//
//  TestPickerstyle.swift
//  Blink
//
//  Created by Arnaud Hayon on 13/11/2025.
//

import SwiftUI

struct TestPickerstyle: View {
      @State private var selection1 = 1
      @State private var selection2 = 2
      @State private var selection3 = "Maroual"
  
      var body: some View {
          VStack {
              
              Picker(selection: $selection1, label: Text("Options")) {
                  Text("Bichette 1").tag(1)
                  Text("Option 2").tag(2)
              }.pickerStyle(DefaultPickerStyle())
              
              Picker(selection: $selection2, label: Text("Options")) {
                  Text("Option 1").tag(1)
                  Text("Option 2").tag(2)
              }.pickerStyle(SegmentedPickerStyle())
              
              
              Picker(selection: $selection3, label: Text("Options")) {
                  Text("Option 1").tag(1)
                  Text("Option 2").tag(2)
              }.pickerStyle(WheelPickerStyle())
              
          }
      }
  }

#Preview {
    TestPickerstyle()
}
