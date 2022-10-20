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
                                NavigationLink (
                                    destination:
                                    ContentView().onAppear {
                                        model.beginModule(module.id)
                                    },
                                    tag: module.id,
                                    selection: $model.currentContentSelected)
                                {
                                    // learning card
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, number: "\(module.content.lessons.count) lesson", time: module.content.time)
                                }.accentColor(Color.black)

                                NavigationLink(
                                    destination:
                                        TestView()
                                        .onAppear(perform: {
                                            model.beginTest(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected) {
                                        
                                        // test card
                                        HomeViewRow(image: module.test.image, title: "\(module.category) test", description: module.test.description, number: "\(module.test.questions.count) questions", time: module.test.time)
                                    }.accentColor(Color.black)

                               
                            }
                        }
                    }.padding()
                }
            }.navigationBarTitle("Get Started")
        }.navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ContentModel())
    }
}
