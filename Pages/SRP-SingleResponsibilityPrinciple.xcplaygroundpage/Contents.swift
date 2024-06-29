/*: [Previous](@previous)                                   [Home](Introduction)                                        [Next](@next)*/
/*: # Definition
 The Single Responsibility Principle is the first principle in the Solid Principles framework.
 1. A class should have only one reason to change.
 2. Each class should focus on a single job or responsibility.
 
 # Benifits
 1. Improved Readability:
    * Easier to understand what each class does.
 2. Enhanced Maintainability:
    * Changed affect only one class.
 3. Increased Reusability:
    * Single-Purpose classes can be used in different parts of the application.
 4. Simplified Testing:
    * Easier to test classes with a limited scope of functionality.
*/

//: # Voilating SRP:

class BankAccount {
    var accountNumber: String
    var balance: Double
    
    init(accountNumber: String, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount). New balance is \(balance)")
    }
    
    func withDraw(amount: Double) {
        if (balance >= amount) {
            balance -= amount
            print("Withdrew \(amount). New balance is \(balance)")
        } else {
            print("Handling the insufficient balance.")
        }
    }
    
    func printStatement() {
        print("Account Statement for \(accountNumber): Balance is \(balance)")
    }
    
    func notifyUser() {
        print("Notifying user of transaction for account \(accountNumber)")
    }
}

// Usage
print("Before Applying SRP:")
let bankAccount = BankAccount(accountNumber: "BANK123", balance: 1000)
bankAccount.deposit(amount: 100)
bankAccount.withDraw(amount: 500)
bankAccount.withDraw(amount: 3000)
bankAccount.printStatement()
bankAccount.notifyUser()
/*: # Issues with Violating SRP:
 1. Multiple Responsibilities:
    * The `BankAccount` class handles multiple responsibilities: managing account balance, printing statements, and notifying the user.
    * This violates the single responsibiliy principle because the class has more than one reason to change.
 
 2. Increased Complexity:
    * The class becomes more complex as it handles more than one job.
    * Changes to notification logic or statement printing might inadvertently affect the core functionality of the account.
 
 3. Difficult Maintenance:
    * Maintaining and updating the class becomes harder as any change requires thorough testing of unrelated functionalities.
    * Debugging becomes more challenging as it’s not clear which part of the class should handle a particular issue.
 
 4. Reduced Reusability:
    * The tightly coupled methods reduce the reusability of the class components.
    * Functions like printStatement and notifyUser might be needed elsewhere but cannot be reused independently.
*/
/*: # Adhering to SRP
 To adhere to SRP, separate the responsibilities into different classes:
*/

class BankAccountWithSRP {
    var accountNumber: String
    var balance: Double
    
    init(accountNumber: String, balance: Double) {
        self.accountNumber = accountNumber
        self.balance = balance
    }
    
    func deposit(amount: Double) {
        balance += amount
        print("Deposited \(amount). New balance is \(balance)")
    }
    
    func withDraw(amount: Double) {
        if (balance >= amount) {
            balance -= amount
            print("Withdrew \(amount). New balance is \(balance)")
        } else {
            print("Handling the insufficient balance.")
        }
    }
}

class StatementPrinter {
    func printStatement(for account: BankAccountWithSRP) {
        print("Account Statement for \(account.accountNumber): Balance is \(account.balance)")
    }
}

class NotificationService {
    func notifyUser(for account: BankAccountWithSRP) {
        print("Notifying user of transaction for account \(account.accountNumber)")
    }
}

// Usage
print("\n\nAfter Applying SRP:")
let bankAccountSRP = BankAccountWithSRP(accountNumber: "BANK123", balance: 1000)
bankAccountSRP.deposit(amount: 500)
bankAccountSRP.withDraw(amount: 700)
bankAccountSRP.withDraw(amount: 3000)

let statementPrinter = StatementPrinter()
let notificationService = NotificationService()

statementPrinter.printStatement(for: bankAccountSRP)
notificationService.notifyUser(for: bankAccountSRP)

/*: # Benefits of Adhering to SRP:
 1. Improved Readability:
    * Each class has a clear and focused responsibility, making the code easier to understand.
 2. Enhanced Maintainability:
    * Changes to statement printing or notification logic do not affect the BankAccount class.
 3. Increased Reusability:
    * The StatementPrinter and NotificationService classes can be reused independently in other parts of the application.
 4. Simplified Testing:
    * Each class can be tested independently, making unit testing more straightforward.
*/

/*: # Drawbacks:
 1. More Classes:
    * Can lead to many small classes.
 2. Complex Dependency Management:
    * More dependencies to manage.
 3. Design and Refactoring Overhead:
    * Requires more effort to design and refactor.
 4. Risk of Over-Engineering:
    * Can make simple problems overly complex.
 5. Performance Considerations:
    * More object creation and method calls.
*/

/*: # Mitigating Drawbacks:
 1. Balanced Approach:
    * Apply SRP judiciously.
 2. Effective Documentation:
    * Clear Documentation helps navigate the codebase.
 3. Use Patterns and Frameworks:
    * Design patterns and dependency management tools can help.
 4. Team Alignment:
    * Ensure the team has a shared understanding of SRP.
 5. Performance Profiling:
    * Profile and optimize performance as needed.
*/


/*: # Conclusion
 By understanding and applying the Single Responsibility Principle thoughtfully, you can create more maintainable, understandable, and flexible software.
*/
