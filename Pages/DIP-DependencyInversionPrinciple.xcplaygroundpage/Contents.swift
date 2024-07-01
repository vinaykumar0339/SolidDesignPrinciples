/*: [Previous](@previous)                                   [Home](Introduction)                                        [Next](@next)*/
/*: # Definition
The Dependency Inversion Principle is the fifth priciple in the Solid Design Principles.
1. High-Level Modules should not depends on Low-Level Modules. Both Should depends on abstraction.
2. Abstraction should not depends on details. Details should depend on Abstraction.
 
### High-Level Modules.
1. High-Level Module contains important policy decisions and business logic.
2. They Should not be effected by changing in Low-Level Modules.
 
### Low-Level Modules.
1. Low-Level Modules contains implementation details.
2. Changes in Low-Level Module should not affect High-Level Modules.
 
### Abstractions
1. Use Interfaces or Abstraction class to create abtraction Layer.
2. High-level modules depend on this abstraction, allowing low-level module changes without affecting high-level logic.
*/

//: # Violating DIP

class FileLogger {
    func log(message: String) {
        print("Loggin Message to file: \(message)")
    }
}

class UserService {
    private let logger = FileLogger()
    
    func createUser(name: String) {
        logger.log(message: "User \(name) Created.")
    }
}

// usage
let userService = UserService()
userService.createUser(name: "Vinay Kumar")


/*: # Issues with Violating DIP:
1. Tight Coupling:
   * UserService is tightly coupled to FileLogger, making it difficult to change the logging mechanism without modifying UserService.
2. Reduced Flexibility:
   * Switching to a different logging method (e.g., database logger, cloud logger) requires changing UserService.
3. Hard to Test:
   * Testing UserService requires an actual FileLogger, making it harder to isolate and test.
*/

/*: # Adhering to DIP:
Using Protocol We can adher to DIP.
*/

protocol Logger {
    func log(message: String)
}

class FileLoggerDIP: Logger {
    func log(message: String) {
        print("Logging message to file: \(message)")
    }
}

class ConsoleLogger: Logger {
    func log(message: String) {
        print("Logging message to console: \(message)")
    }
}

class UserServiceDIP {
    let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func createUser(name: String) {
        self.logger.log(message: "User \(name) Created")
    }
}

// usage
let fileLoggerDIP = FileLoggerDIP()
let consoleLogger = ConsoleLogger()
let userServiceDIPUsingFileLogger = UserServiceDIP(logger: fileLoggerDIP)
let userServiceDIPUsingConsoleLogger = UserServiceDIP(logger: consoleLogger)

userServiceDIPUsingFileLogger.createUser(name: "Vinay Kumar DIP FileLogger")
userServiceDIPUsingConsoleLogger.createUser(name: "Vinay Kumar DIP ConsoleLogger")

/*: # Benefits of Adhering to DIP:
1. Improved Maintainability:
   * Changes in low-level modules (like FileLogger) do not affect high-level modules (like UserService).
2. Enhanced Flexibility:
   * Easily switch between different logging mechanisms without changing the high-level module.
3. Increased Testability:
   * High-level modules can be tested with mock implementations of abstractions.
*/

/*: # Drawbacks of Adhering to DIP:
1. Increased Complexity:
   * Requires creating additional interfaces or abstract classes.
2. More Boilerplate Code:
   * More code is needed to set up the abstractions.
*/

/*: # Mitigating Drawbacks:
1. Balanced Approach:
   * Apply DIP where it provides significant benefits, balancing simplicity and extensibility.
2. Clear Documentation:
   * Maintain clear documentation to help developers understand the dependencies.
3. Use of Dependency Injection Frameworks:
   * Use frameworks to manage dependencies efficiently.
*/

/*: # Conclusion:
 By understanding and applying the Dependency Inversion Principle thoughtfully, you can create more maintainable, understandable, and flexible software. Ensuring that high-level modules depend on abstractions rather than low-level details promotes better software design and enhances the overall quality of the codebase.
*/

