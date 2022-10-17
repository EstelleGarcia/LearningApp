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
    
    var styleData: Data?
    
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
    
}
