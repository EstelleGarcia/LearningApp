//
//  ContentViewRow.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI

struct ContentViewRow: View {
    @EnvironmentObject var model: ContentModel
    var index: Int
    var body: some View {
        var lesson = model.currentModule!.content.lessons[index]
        ZStack (alignment: .leading){
            Rectangle().foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            HStack (spacing: 30){
                Text(String(index+1)).bold()
                VStack(alignment: .leading) {
                    Text(lesson.title).bold()
                    Text(lesson.duration)
                }
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .padding(.bottom, 5.0)
    }
}


