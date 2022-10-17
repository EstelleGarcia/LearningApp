//
//  ContentView.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("What do you want to do today").padding(.leading, 20)
                ScrollView {
                    LazyVStack {
                        ForEach (model.modules) {module in
                            VStack (spacing: 20){
                                NavigationLink {
                                    ContentView().onAppear {
                                        model.beginModule(_moduleId: module.id)
                                    }
                                } label: {
                                    // learning card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, number: "\(module.content.lessons.count) lesson", time: module.content.time)
                                }.accentColor(Color.black)

                                    
                                
                                
                                // test card
                                HomeViewRow(image: module.test.image, title: "\(module.category) test", description: module.test.description, number: "\(module.test.questions.count) questions", time: module.test.time)
                            }
                        }
                    }.padding()
                }
            }.navigationTitle("Get Started")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
