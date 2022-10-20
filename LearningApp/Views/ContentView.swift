//
//  LessonsList.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ContentModel
    var body: some View {
            ScrollView{
                LazyVStack{
                    if model.currentModule != nil {
                        ForEach (0..<model.currentModule!.content.lessons.count) {index in
                            // lesson card
                            NavigationLink {
                                ContentDetailView().onAppear(perform:{ model.beginLesson(index)})
                            } label: {
                                ContentViewRow(index: index)
                            }.accentColor(Color.black)

                            
                        }
                    }
                }.padding()
                 .navigationBarTitle("Learn \(model.currentModule?.category ?? "")")
            }
    }
}

