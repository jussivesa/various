//: Playground - noun: a place where people can play

import UIKit

// Linked list
// 1->2->3->250->nil

// Define a data structure that supports this list
// next = optional Node class (next pointer, Node?)
class Node {
    let value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
}

// Creating linked list
let someNode = Node(value: 250, next: nil)
let fourNode = Node(value: 4, next: someNode)
let threeNode = Node(value: 3, next: fourNode)
let twoNode = Node(value: 2, next: threeNode)
let oneNode = Node(value: 1, next: twoNode)

func printList(head: Node?) {
    print("Printing out list of nodes")
    var currentNode = head // must be var
    while currentNode != nil {
        print(currentNode?.value ?? -1) // -1 disables optional text from output
        currentNode = currentNode?.next
    }
}

printList(head: oneNode)



// Basicly does this per n:th cycle (flips arrow): 
// nil<-1->2->3->nil
// nil<-1<-2->3->nil
// nil<-1<-2<-3

// And flips the list
// nil<-1<-2<-3
// 3->2->1->nil

// -> means that it will return Node
func reverseList(head: Node?) -> Node? {
    print("Printing out reversed list of nodes")
    var currentNode = head
    var prev: Node?
    var next: Node?
    
    while currentNode != nil {
        next = currentNode?.next
        currentNode?.next = prev
        
        print("Prev: \(prev?.value ?? -1), Curr: \(currentNode?.value ?? -1), Next: \(next?.value ?? -1)")
        
        prev = currentNode
        
        
        currentNode = next
    }
    
    return prev
}

let myReversedList = reverseList(head: oneNode)

printList(head: myReversedList) //needs to print out 3, 2, 1










