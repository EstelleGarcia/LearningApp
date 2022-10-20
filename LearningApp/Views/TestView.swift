//
//  TestView.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/20/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        if model.currentQuestion != nil {
            
                VStack {
                    // question number
                    Text("Question \(model.currentQuestionIndex+1) of \(model.currentModule?.test.questions.count ?? 0)")
                    // question
                    CodeTextView()
                    // answers
                    
                    // button to submit answer or finish quizz
            }.navigationBarTitle("\(model.currentModule?.category ?? "") test")
        }
        else {
            //question hasn't loaded yet
            ProgressView()
        }
    }
}

