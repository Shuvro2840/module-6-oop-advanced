import 'dart:core';

// ==========================================
// STEP 2: Practicing encapsulation with private fields
// ==========================================
class EncapsulatedUser {
  String _secretKey; // Private variable

  EncapsulatedUser(this._secretKey);

  // Public getter to read value
  String get secretKey => _secretKey;

  // Public setter to update value with validation
  set secretKey(String newKey) {
    if (newKey.length >= 6) {
      _secretKey = newKey;
    } else {
      print("Validation Failed: Key must be at least 6 characters long.");
    }
  }
}

// ==========================================
// STEP 3: Using static variables and methods
// ==========================================
class Car {
  String model;
  static int totalCarsCreated = 0; // Static variable shared among all objects

  Car(this.model) {
    totalCarsCreated++;
  }

  // Static method callable without creating an object
  static void displayTotalCars() {
    print("Total Car instances created: $totalCarsCreated");
  }
}

// ==========================================
// STEP 4 & 5: Factory constructors & Singleton pattern
// ==========================================
class DatabaseConnection {
  final String connectionString;
  static DatabaseConnection? _instance; // Single instance cache

  // Private constructor to control object creation
  DatabaseConnection._internal(this.connectionString);

  // Factory constructor that returns an existing instance or creates a new one
  factory DatabaseConnection(String connectionString) {
    _instance ??= DatabaseConnection._internal(connectionString);
    return _instance!;
  }
  
  /* Why factory constructors are useful:
   Unlike generative constructors, a factory constructor can return cached or existing 
   instances, control singletons, or even return specific subclasses based on the parameters passed.
  */
}

// ==========================================
// STEP 6: Using mixins for code reuse
// ==========================================
mixin LoggerMixin {
  void logAction(String action) {
    print("[LOG - ${DateTime.now()}]: $action");
  }
}

class OrderManager with LoggerMixin {
  void placeOrder() {
    logAction("Order placed successfully."); // Reusing mixin method
  }
}

// ==========================================
// STEP 7: Creating extensions
// ==========================================
extension IntExtensions on int {
  // Method to check if a number is even
  bool get isEvenNumber => this % 2 == 0;
}

// ==========================================
// STEP 8: Practicing operator overloading
// ==========================================
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  // Overriding == to compare objects properly
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point && runtimeType == other.runtimeType && x == other.x && y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  // Overriding toString() to print meaningful object info
  @override
  String toString() => "Point($x, $y)";
}

// ==========================================
// STEP 9: Implementing copy constructor concept
// ==========================================
class Student {
  String name;
  int grade;

  Student(this.name, this.grade);

  // Takes another object of the same class and copies its values
  factory Student.clone(Student source) {
    return Student(source.name, source.grade);
  }
}

// ==========================================
// STEP 10: Practicing class composition
// ==========================================
class Customer {
  String name;
  BankAccount account; // Composition: "has-a" relationship

  Customer(this.name, this.account);
}

// ==========================================
// STEP 11 & 12: Implementing the Bank Account System
// ==========================================
class BankAccount {
  final String accountHolder;
  double _balance; // Encapsulation for balance protection

  BankAccount(this.accountHolder, this._balance);

  // Getter for balance checking
  double get balance => _balance;

  // Deposit money
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print("Deposited: \$${amount.toStringAsFixed(2)}. New Balance: \$${_balance.toStringAsFixed(2)}");
    } else {
      print("Invalid deposit amount.");
    }
  }

  // Withdrawal money with validation
  void withdraw(double amount) {
    if (amount <= 0) {
      print("Withdrawal amount must be greater than zero.");
    } else if (amount > _balance) {
      print("Transaction Denied: Insufficient funds for withdrawal of \$${amount.toStringAsFixed(2)}.");
    } else {
      _balance -= amount;
      print("Withdrew: \$${amount.toStringAsFixed(2)}. Remaining Balance: \$${_balance.toStringAsFixed(2)}");
    }
  }
}

// ==========================================
// STEP 13: Testing the system
// ==========================================
void main() {
  print("=== STEP 2: ENCAPSULATION ===");
  var user = EncapsulatedUser("InitialKey123");
  user.secretKey = "abc"; // Trigger validation failure
  user.secretKey = "ValidNewKey"; // Pass validation
  print("Current key via getter: ${user.secretKey}\n");

  print("=== STEP 3: STATIC VARIABLES & METHODS ===");
  Car("Tesla Model S");
  Car("Toyota Prius");
  Car.displayTotalCars();
  print("");

  print("=== STEP 4 & 5: FACTORY CONSTRUCTORS & SINGLETON ===");
  var db1 = DatabaseConnection("DATABASE_URL_1");
  var db2 = DatabaseConnection("DATABASE_URL_2");
  print("Are db1 and db2 pointing to the exact same instance? ${identical(db1, db2)}\n");

  print("=== STEP 6: MIXINS ===");
  var order = OrderManager();
  order.placeOrder();
  print("");

  print("=== STEP 7: EXTENSIONS ===");
  int myNum = 14;
  print("Is $myNum an even number? ${myNum.isEvenNumber}\n");

  print("=== STEP 8: OPERATOR OVERLOADING ===");
  var p1 = Point(3, 5);
  var p2 = Point(3, 5);
  print("p1 details (toString): $p1");
  print("Does p1 == p2? ${p1 == p2}\n");

  print("=== STEP 9: COPY CONSTRUCTOR ===");
  var originalStudent = Student("Alice", 95);
  var copiedStudent = Student.clone(originalStudent);
  copiedStudent.name = "Bob"; // Modify copy to ensure independence
  print("Original Student: ${originalStudent.name}, Grade: ${originalStudent.grade}");
  print("Copied Student: ${copiedStudent.name}, Grade: ${copiedStudent.grade}\n");

  print("=== STEPS 11, 12 & 13: BANK ACCOUNT SYSTEM TESTS ===");
  var myAccount = BankAccount("Suvra Mazumdar", 500.0);
  var customer = Customer("Suvra Mazumdar", myAccount);

  print("Customer Account Owner: ${customer.account.accountHolder}");
  print("Initial Balance Check: \$${customer.account.balance}");
  
  customer.account.deposit(250.50);     // Test deposit
  customer.account.withdraw(100.00);    // Test successful withdrawal
  customer.account.withdraw(800.00);    // Test boundary invalid operation (overdraft checking)
  print("==================================================");
}