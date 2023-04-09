//
//  listViewModel.swift
//  WorkBuddy
//
//  Created by cs-488-01 on 4/9/23.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    
    @Published var items: [Tasks] = []
    
    init(){
        getItems()
    }
    
    func getItems(){
        let newItems = [
            Tasks(title: "first1", isCompleted: false),
            Tasks(title: "second", isCompleted: true),
            Tasks(title: "third", isCompleted: false)
        ]
        //items.append(contentsof: newItems)
    }
    
    func deleteItem(indexSet: IndexSet){
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String){
        let newItem = Tasks(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: Tasks){
        
        if let index = items.firstIndex(where: {$0.id == item.id}){
            items[index] = item.updatecompleted()
        }
    }
}
