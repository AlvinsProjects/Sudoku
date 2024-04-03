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
        return items.removeFirst()
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


/*
extension Queue: CustomStringConvertible {
    var description: String {
        let start = "Queue"
        let end = " [HEAD]"
        let elements = items
            .map { String(describing: $0) }
            .reversed()
            .joined(separator: " -> ")

        return start + elements + end
    }

    func printQueue() {
        print(description)
    }
}



 The following are examples of adding a String or an Integer to a QueueStack.
 
 var queue: Queue = Queue<String>()
 queue.enqueue(item: "One")
 queue.enqueue(item: "Two")
 queue.enqueue(item: "Three")
 queue.enqueue(item: "Four")
 queue.enqueue(item: "Five")
 
 
 var numb: Queue = Queue<Double>()
 numb.enqueue(item: 3.14)
 numb.enqueue(item: 4.44)
 numb.enqueue(item: 5.55)
 numb.enqueue(item: 6.66) */



/*
print(queue)
queue.dequeue()
print(queue)
queue.enqueue(item: "Hello")
print(queue)

print("Head:  \(queue.head)")
print("Tail:  \(queue.tail)\n")





print(numb)
numb.dequeue()
print(numb)
numb.enqueue(item: 7.77)
print(numb)

print("Head:  \(numb.head)")
print("Tail:  \(numb.tail)")
print()
*/
