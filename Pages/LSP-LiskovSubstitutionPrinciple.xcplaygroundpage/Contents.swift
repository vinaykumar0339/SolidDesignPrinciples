/*: [Previous](@previous)                                   [Home](Introduction)                                        [Next](@next)*/
/*: # Definition
The Liskov Substitution Principle is the third principle in the Solid Design Principles.
1. Objects of the Super-Class should be replaceable with objects of a Sub-Class without affecting the correctness of the program.
*/

//: # Violating LSP:

class Bird {
    func fly() {
        print("Bird is Flying...")
    }
}

class Duck: Bird {
    override func fly() {
        print("Duck is Flying...")
    }
}

class Ostrich: Bird {
    //we will not be implementing this function in Ostrich because it does not make sense to add this function as Ostrich can't fly. so for demenstrate purposes keep this code with fatalError.
    override func fly() {
        fatalError("Ostrich doesn't fly so behaviour of the application going to change if we pass Ostrich Object to any function which having contract to Bird")
    }
}

func flyBird(bird: Bird) {
    bird.fly()
}

// usage
let bird = Bird()
let duckBird = Duck()
let ostrichBird = Ostrich()
flyBird(bird: bird)
flyBird(bird: duckBird)
flyBird(bird: ostrichBird)

/*: # Issues with Violating SRP:
1. Unexpected Behavior:
   * Subclasses that change the expected behaviour of the base class can lead to runtime errors and bugs.
2. Reduced Maintainability:
   * Modifying subclasses to fix LSP violations can make the code harder to maintain.
3. Inconsistent Substitution:
   * Clients using the base class might not work correctly with all subclasses, leading to inconsistent behaviour.
*/

/*: # Adhering to LSP
 To adhere to LSP, Using Proper Inheritance, or using protocols etc.
*/

//: ## Using Class Separation
class BirdLSP {
    func eat() {
        print("Bird is eating...")
    }
}

class FlyingBird: BirdLSP {
    func fly() {
        print("FlyingBird is flying...")
    }
}

class DuckLSP: FlyingBird {
    override func fly() {
        print("Duck is flying...")
    }
}

class OstrichLSP: BirdLSP {
    override func eat() {
        print("Ostrich eating...")
    }
}

func flyBirdLSP(flyingBird: FlyingBird) {
    flyingBird.fly()
}

// usage
let birdLsp = BirdLSP()
let flyingBirdLSP = FlyingBird()
let duckLSP = DuckLSP()
let ostrichLSP = OstrichLSP()

flyBirdLSP(flyingBird: flyingBirdLSP)
flyBirdLSP(flyingBird: duckLSP)

// below example will throw error at compile time
// flyBirdLSP(flyingBird: birdLsp)
// flyBirdLSP(flyingBird: ostrichLSP)

//: ## Using Protocol
protocol Eater {
    func eat()
}
protocol Flyer {
    func fly()
}

class BirdLSPUsingProtocol: Eater {
    func eat() {
        print("BirdLSPUsingProtocol is eating")
    }
}

class DuckLSPUsingProtocol: Eater, Flyer {
    func eat() {
        print("DuckLSPUsingProtocol is eating")
    }
    
    func fly() {
        print("DuckLSPUsingProtocol is flying")
    }
}

class OstrichLSPUsingProtocol: Eater {
    func eat() {
        print("OstrichLSPUsingProtocol is eating")
    }
}

func flyingBirdLSPUsingProtocol(flyer: Flyer) {
    flyer.fly()
}

// usage
let birdLSPUsingProtocol = BirdLSPUsingProtocol()
let duckLSPUsingProtocol = DuckLSPUsingProtocol()
let ostrichLSPUsingProtocol = OstrichLSPUsingProtocol()


flyingBirdLSPUsingProtocol(flyer: duckLSPUsingProtocol)

// below will thrown an error on compile time
// flyingBirdLSPUsingProtocol(flyer: birdLSPUsingProtocol)
// flyingBirdLSPUsingProtocol(flyer: ostrichLSPUsingProtocol)

/*: # Benefits of Adhering to LSP:
1. Improved Maintainability:
   * Ensures that derived classes can be used interchangeably with base classes without unexpected behaviour.
2. Enhanced Flexibility:
   * Encourages the use of polymorphism, allowing more flexible and scalable code.
3. Increased Reliability:
   * Substitutable objects ensure consistent behaviour, reducing the likelihood of runtime errors.
*/

/*: # Drawbacks of Adhering to LSP:
1. More Classes and Interfaces:
   * Can lead to an increase in the number of classes and interfaces, making the codebase larger.
2. Initial Complexity:
   * Implementing LSP correctly may require a more complex initial design and detailed planning.
*/

/*: # Mitigating Drawbacks:
1. Balanced Approach:
   * Apply LSP judiciously, balancing between simplicity and the need for extensibility.
2. Clear Documentation:
   * Maintain clear and concise documentation to help developers understand class hierarchies and responsibilities.
3. Use of Design Patterns:
   * Employ design patterns that naturally adhere to LSP, such as the Strategy pattern, to manage complexity.
*/

/*: # Conclusion:
By understanding and applying the Liskov Substitution Principle thoughtfully, you can create more maintainable, understandable, and reliable software. Ensuring that subclasses can be substituted for their superclasses without altering the program's correctness promotes better software design and flexibility.
*/





