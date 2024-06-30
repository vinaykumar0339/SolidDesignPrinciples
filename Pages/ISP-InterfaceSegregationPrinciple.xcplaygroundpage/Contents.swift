/*: [Previous](@previous)                                   [Home](Introduction)                                        [Next](@next)*/

/*: # Definition
The Interface Segregation Principle is the fourth principle in the Solid Design Principles.
1. Clients should not be forced to depend on interfaces they do not use.
*/

//: # Violating ISP:
protocol Worker {
    func eat()
    func work()
}

class HumanWorker: Worker {
    func eat() {
        print("Human is eating...")
    }
    
    func work() {
        print("Human is working...")
    }
}

class RobotWorker: Worker {
    func work() {
        print("Robot is working...")
    }
    
    func eat() {
        fatalError("Robot can't eat...")
    }
}

// usage
let robot = RobotWorker()
robot.eat()  // This will cause a runtime error

/*: # Issues with Violating ISP:
1. Unnecessary Methods:
   * Classes are forced to implement methods they do not use, leading to potential runtime errors.
2. Increased Complexity:
   * Interfaces become bloated with methods irrelevant to some implementations.
3. Reduced Maintainability:
   * Changes to interfaces affect all implementing classes, even if they do not use the changed methods.
*/

/*: # Adhering to ISP
 To adhere to ISP, separate the protocol into small pieces:
*/

protocol Workable {
    func work()
}

protocol Eatable {
    func eat()
}

protocol WorkerISP: Workable, Eatable {}

class HumanWorkerISP: WorkerISP {
    func eat() {
        print("HumanWorkerISP is eating...")
    }
    
    func work() {
        print("HumanWorkerISP is working...")
    }
}

class RobotWorkerISP: Workable {
    func work() {
        print("RobotWorkerISP is eating...")
    }
}

// usage
let humanWorker = HumanWorkerISP()
humanWorker.eat()
humanWorker.work()

let robotWorker = RobotWorkerISP()
robotWorker.work()

/*: # Benefits of Adhering to ISP:
1. Improved Maintainability:
   * Smaller, specific interfaces are easier to understand and maintain.
2. Enhanced Flexibility:
   * Changes to an interface do not affect clients that do not use that part of the interface.
3. Increased Reusability:
   * Specific interfaces can be reused more easily across different parts of the application.
*/

/*: # Drawbacks of Adhering to ISP:
1. More Interfaces:
   * Can lead to an increase in the number of interfaces, making the codebase larger.
2. Initial Complexity:
   * Designing multiple specific interfaces may require more detailed planning and initial effort.
*/

/*: # Mitigating Drawbacks:
1. Balanced Approach:
   * Apply ISP judiciously, balancing between simplicity and the need for specificity.
2. Clear Documentation:
   * Maintain clear and concise documentation to help developers understand the purpose of each interface.
3. Use of Design Patterns:
   * Employ design patterns that naturally adhere to ISP, such as the Adapter pattern, to manage complexity.
*/

/*: # Conclusion:
 By understanding and applying the Interface Segregation Principle thoughtfully, you can create more maintainable, understandable, and flexible software. Ensuring that clients only depend on the interfaces they use promotes better software design and enhances the overall quality of the codebase.
*/
