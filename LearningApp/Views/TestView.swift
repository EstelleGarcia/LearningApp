//
//  TestView.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/20/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State var selectedAnswerIndex: Int?
    @State var submitted = false
    
    @State var numCorrect = 0
    
    var body: some View {
        if model.currentQuestion != nil {
            
            VStack (alignment: .leading) {
                    // question number
                Text("Question \(model.currentQuestionIndex+1) of \(model.currentModule?.test.questions.count ?? 0)").padding(.horizontal, 20)
                    // question
                    CodeTextView().padding(.horizontal, 20)
                    // answers
                ScrollView {
                    VStack {
                        ForEach (0..<model.currentQuestion!.answers.count, id: \.self) {index in
                           
                                Button {
                                selectedAnswerIndex = index
                                    
                                } label: {
                                    ZStack {
                                        if submitted == false {
                                            RectangleCard(color: selectedAnswerIndex == index ? .gray : .white)
                                                .frame(height: 48)
                                        }
                                        else if submitted == true && index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else if submitted == true && index != model.currentQuestion!.correctIndex && index == selectedAnswerIndex {
                                                RectangleCard(color: .red)
                                                    .frame(height: 48)
                                            }
                                        else {
                                            RectangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                            Text(model.currentQuestion!.answers[index])
                                }.accentColor(.black)
                                        
                                }.disabled(submitted)
                        }
                    }
                    .padding(.all)
                }
                    // button to submit answer or finish quizz
                Button {
                    // submit the answer
                    submitted = true
                    //check the answer and increment the counter if correct
                    if  selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        numCorrect += 1
                    }
                } label: {
                    ZStack {
                        RectangleCard(color: .green).frame(height: 48)
                        Text("Submit").foregroundColor(.white).bold()
                    }.padding()
                }.disabled(selectedAnswerIndex == nil)

            }.padding(.vertical).navigationBarTitle("\(model.currentModule?.category ?? "") test")
        }
        else {
            //question hasn't loaded yet
            ProgressView()
        }
    }
}

