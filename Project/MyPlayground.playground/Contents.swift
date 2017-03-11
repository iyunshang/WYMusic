//: Playground - noun: a place where people can play

import UIKit

class Poin {

    lazy var p: pro = {
       return pro()
    }()

}

class pro: Poin {
    var name = "asda"
    var age = 24
}

let poin = Poin()
poin.p.name = "124"
print(poin.p.name)


let block: () -> Void = { () -> Void in
    print("Closure")
}

block()


