//
//  HomeViewRow.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var number: String
    var time: String
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            HStack {
                Image (image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(title).bold()
                    Text(description).font(.caption).padding(.bottom, 20)
                    HStack {
                        // number of lessons / questions
                        Image(systemName: "text.book.closed").resizable().frame(width: 15, height: 15)
                        Text(number).font(.system(size: 10))
                        Spacer()
                        // time
                        Image(systemName: "clock").resizable().frame(width: 15, height: 15)
                        Text(time).font(.system(size: 10))
                        
                    }
                }.padding(.leading, 20)
            }.padding(.horizontal, 20)
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        let model = ContentModel()
        HomeViewRow(image: model.modules[0].content.image, title: "Learn \(model.modules[0].category)", description: model.modules[0].content.description, number: " \(model.modules[0].content.lessons.count) lessons", time: model.modules[0].content.time)
    }
}
