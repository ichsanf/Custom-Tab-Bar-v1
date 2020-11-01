//
//  ContentView.swift
//  Custom-Tab-Bar-v1
//
//  Created by Achmad Ichsan Fauzi on 01/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = "Home"
    @StateObject var modelData = ViewModel()
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
                    .opacity(selectedTab == "Home" ? 1 : 0)
                    
                    Text("Restaurant")
                        .opacity(selectedTab == "Restaurant" ? 1 : 0)
                    Text("Orders")
                        .opacity(selectedTab == "Orders" ? 1 : 0)
                    Text("Rewards")
                        .opacity(selectedTab == "Rewards" ? 1 : 0)
                }
            }
            .onChange(of: selectedTab) { _ in

                switch(selectedTab) {
                case "Restaurant":
                    if !modelData.isRestaurantLoad{modelData.loadRestaurant()}
                case "Orders":
                    if !modelData.isOrderLoad{modelData.loadOrders()}
                case "Rewards":
                    if !modelData.isRewardLoad{modelData.loadReward()}
                default: ()
                }
            }
            
            // TabView
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    
                    if tab != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabButton : View {
      
      var title : String
      @Binding var selectedTab : String
      var animation : Namespace.ID
      
      var body: some View{
          
          Button(action: {
              withAnimation{selectedTab = title}
          }) {
              
              VStack(spacing: 6){
                  
                  // Top Indicator....
                  
                  // Custom Shape...
                  
                  // Slide in and out animation...
                  
                  ZStack{
                      
                      CustomShape()
                          .fill(Color.clear)
                          .frame(width: 45, height: 6)
                      
                      if selectedTab == title{
                          
                          CustomShape()
                              .fill(Color("tint"))
                              .frame(width: 45, height: 6)
                              .matchedGeometryEffect(id: "Tab_Change", in: animation)
                      }
                  }
                  .padding(.bottom,10)
                  
                  Image(title)
                      .renderingMode(.template)
                      .resizable()
                      .foregroundColor(selectedTab == title ? Color("tint") : Color.black.opacity(0.2))
                      .frame(width: 24, height: 24)
                  
                  Text(title)
                      .font(.caption)
                      .fontWeight(.bold)
                      .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
              }
          }
      }
  }

struct CustomShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

var tabs = ["Home","Restaurants","Orders","Rewards"]
