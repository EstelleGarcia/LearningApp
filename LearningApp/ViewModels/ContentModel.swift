//
//  ContentModel.swift
//  LearningApp
//
//  Created by Estelle Garcia on 10/17/22.
//

import Foundation

class ContentModel: ObservableObject {
    // list of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    
    var styleData: Data?
    
    // current selected content and test
    @Published var currentContentSelected: Int?
    
    init () {
        getLocalData()
    }
    
    //MARK: - data method
    func getLocalData() {
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: ".json")
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            let jsonDecoder = JSONDecoder()
            let modulesData = try jsonDecoder.decode([Module].self, from: jsonData)
            self.modules = modulesData
        }
        catch {
            print ("Couldn't parse local data")
        }
        
        // Parse style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print ("Couldn't parse style data")
        }
    }
    
    //MARK: - Module navigation method
    func beginModule(_moduleId: Int){
        // set the current module
        for index in 0..<modules.count {
            if modules[index].id == _moduleId {
                //found the matching module
                currentModuleIndex = index
                break
            }
        }
        // find the index for this module id
        currentModule = modules[currentModuleIndex]
    }
    //MARK: - Lesson navigation method
    func beginLesson(_lessonIndex: Int) {
        // check that the lesson index is in range of module lesson
        if _lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = _lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        //set current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(_htmlString: currentLesson!.explanation)
    }
    //MARK: - advance lesson
    func nextLesson() {
        // advance the lesson index
        currentLessonIndex += 1
        // check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            // set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(_htmlString: currentLesson!.explanation)
        }
        else {
            // reset lesson state
            currentLessonIndex = 0
            currentLesson = nil
            //lessonDescription = nil not necessary
        }
    }
    //MARK: - check if next lesson exists method
    func hasNextLesson() -> Bool {
        /*if currentLessonIndex < currentModule!.content.lessons.count - 1 {
            return true
        }
        else {
            return false
        }*/
        return (currentLessonIndex < currentModule!.content.lessons.count - 1)
    }
    //MARK: - code styling
    private func addStyling(_htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data\
        if styleData != nil {
            data.append(self.styleData!)
        }
        //Add the html data
        data.append(Data(_htmlString.utf8))
        // convert to attributed string
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            
            resultString = attributedString
        }
        catch {
            print("couldn't turn html into attributed string")
        }
        /* if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
         
         resultString = attributedString*/
        
        return resultString
    }
    
    
   
    
    
    
    
}
