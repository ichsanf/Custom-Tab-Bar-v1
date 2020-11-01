//
//  ContentView.swift
//  Custom-Tab-Bar-v1
//
//  Created by Achmad Ichsan Fauzi on 01/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = "Home"
//    @StateObject var modelData = ModelView()
    @Namespace var animation
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        VStack {
            GeometryReader {_ in
                ZStack {
                    
                    // Tabs
                    NavigationView{
                        ScrollView {
                            ForEach(1...25, id: \.self) { i in
                                NavigationLink(
                                    destination: Text("Home Data \(i)")) {
                                    
                                    VStack(alignment: .leading) {
                                        Text("Home Data \(i)")
                                            .padding()
                                            .foregroundColor(.black)
                                        
                                        Divider()
                                    }
                                }
                            }
                            .padding()
                        }
                        .navigationBarHidden(true)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
