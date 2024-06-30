/*: [Previous](@previous)                                   [Home](Introduction)                                        [Next](@next)*/
/*: # Definition
The Open/Close Principle is the second principle in the Solid Design Principle.
1. Software entities should be open for extension but closed for modification.
*/
//: **Today Will discuss about discount calculator system.**

/*: # Voilating OCP:*/

enum DiscountType {
    case seasonal
    case loyalty
    case nodiscount
}

class DiscountCalculator {
    func calculateDiscount(discountType: DiscountType, amount: Double) -> Double {
        switch discountType {
        case .seasonal:
            return amount * 0.1
        case .loyalty:
            return amount * 0.15
        case .nodiscount:
            return 0
//        Including a default case can handle unexpected cases but won't prompt Xcode to show an error or warning if a new DiscountType is added later. This means new cases could be missed without any compile-time notifications.
        default:
            return 0
        }
    }
}

// usage
let discountCalcualtor = DiscountCalculator()
discountCalcualtor.calculateDiscount(discountType: .seasonal, amount: 100)
discountCalcualtor.calculateDiscount(discountType: .loyalty, amount: 100)
discountCalcualtor.calculateDiscount(discountType: .nodiscount, amount: 100)


/*: # Issues with Violating OCP:
1. Hard to Extend:
   * Adding new discount required modification of the function `calculateDiscount`.
2. Increase Complexity:
   * `calculateDiscount` becomes complex with multiple discount types.
3. Difficult Maintenance:
   * Changes in discount logic require updates to `calculateDiscount`.
*/

/*: # Adhering to OCP
To Adhere to OCP, Use Protocol to confirm the contract between different type of discounts in the application.
*/

protocol Discount {
    func apply(amount: Double) -> Double
}

class SeasonalDiscount: Discount {
    func apply(amount: Double) -> Double {
        return amount * 0.1
    }
}

class LoyaltyDiscount: Discount {
    func apply(amount: Double) -> Double {
        return amount * 0.15
    }
}

class DiscountCalculatorOCP {
    private var discounts: [Discount]
    
    init(discounts: [Discount]) {
        self.discounts = discounts
    }
    
    func calculateTotalDiscount(amount: Double) -> Double {
        var totalDiscount = 0.0
        for discount in discounts {
            totalDiscount += discount.apply(amount: amount)
        }
        return totalDiscount
    }
}

// usage
let seasonalDiscount = SeasonalDiscount()
let loyaltyDiscount = LoyaltyDiscount()
let discountCalculatorOCP = DiscountCalculatorOCP(discounts: [seasonalDiscount, loyaltyDiscount])
discountCalculatorOCP.calculateTotalDiscount(amount: 100)

/*: # Benefits of Adhering to OCP:
1. Improved Maintainability:
   * Adding New Discount types doesn't require modifying exising code.
2. Enhanced Flexibility:
   * Easily extendable with new discount class.
3. Greater Reusability:
   * Discount logic is reusable across different parts of the application.
*/

/*: # Drawbacks:
1. More Classes:
   * Can lead to many small classes.
2. Complex Dependency Management:
   * More dependencies to manage.
3. Design and Refactoring Overhead:
   * Requires more effort to design and refactor.
*/

/*: # Mitigating Drawbacks:
1. Balanced Approach:
   * Apply OCP judiciously, balancing simplicity and extensibility.
2. Effective Documentation:
   * Clear documentation helps navigate the codebase and understand class responsibilities.
3. Use Patterns and Frameworks:
   * Design patterns (like Strategy) and dependency management tools can help.
4. Team Alignment:
   * Ensure the team has a shared understanding of OCP and consistent practices.
5. Performance Profiling:
   * Profile and optimize performance to manage any overhead introduced by adhering to OCP.
*/

/*: # Conclusion
By understanding and applying the Open/Closed Principle thoughtfully, you can create more maintainable, understandable, and flexible software.
*/


