
print("Stack invertion")
class Stack {
    let val: Int
    var next: Stack?
    init(_ value: Int, _ next: Stack?) {
        val = value
        self.next = next
    }
}

let list = Stack(1, Stack(2, Stack(3, Stack(4, Stack(5, nil)))))

func invert(_ node: Stack) -> Stack {
    if let next = node.next {
        node.next = nil
        return invertMain(current: next, previous: node)
    } else {
        return node
    }
}

func invertMain(current: Stack, previous: Stack) -> Stack {
    if let next = current.next {
        current.next = previous
        return invertMain(current: next, previous: current)
    } else {
        current.next = previous
        return current
    }
}

let invertedList = invert(list)
print(invertedList.val)
print(invertedList.next?.val ?? 0)
print(invertedList.next?.next?.val ?? 0)
print(invertedList.next?.next?.next?.val ?? 0)
print(invertedList.next?.next?.next?.next?.val ?? 0)
print(invertedList.next?.next?.next?.next?.next?.val ?? 0)

print("Array invertion")
let direct = "Hello".map{ $0 }
var inverted = [Character]()

func invert(substr: Array<Character>) {
    if substr.count > 0 {
        inverted.append(substr.last!)
        let newsubstr = substr.dropLast().map{$0}
        invert(substr: newsubstr)
    }
}

invert(substr: direct)
print(inverted)
