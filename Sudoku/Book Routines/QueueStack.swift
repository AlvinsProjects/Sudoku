//
//  QueueStack.swift
//  Sudoku
//
//  Created by Alvin Alleyne on 4/3/24.
//

import Foundation


struct Queue <Item> {
    
    private var items: [Item] = []
    
    //Enqueue   (Push)
    mutating func enqueue(item: Item) {
        items.append(item)
    }
    
    //Dequeue   (Pop)
    mutating func dequeue() -> Item {
        guard !items.isEmpty else { fatalError("The queue is empty") }
        return items.removeLast()
    }
    
    //Head
    var head: Item {
        guard let firstItem = items.first else { fatalError("The queue is empty") }
        return firstItem
    }
    
    //Tail
    var tail: Item {
        guard let lastItem = items.last else { fatalError("The queue is empty") }
        return lastItem
    }
}

