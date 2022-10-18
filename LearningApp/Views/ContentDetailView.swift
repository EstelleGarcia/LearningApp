//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        VStack{
            // only show video if we get a valid url
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            // description
            
            // show next lesson button if there is a next lesson
            if model.hasNextLesson() {
                Button {
                    // advance the lesson
                    model.nextLesson()
                } label: {
                    ZStack {
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        Text("Next lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}


