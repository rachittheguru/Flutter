import 'dart:io';

class Employee {
  String employeeId = "";
  String employeeName = "";
  String department = "";

  void displayEmployeeInfo() {
    print("Employee ID : $employeeId");
    print("Name        : $employeeName");
    print("Department  : $department");
  }
}

class Salary extends Employee {
  double basicSalary = 0;
  double hra = 0;
  double da = 0;
  double bonus = 0;

  double grossSalary = 0;
  double tax = 0;
  double netSalary = 0;

  void calculateGrossSalary() {
    grossSalary = basicSalary + hra + da + bonus;
  }

  void calculateTax() {
    if (grossSalary > 80000) {
      tax = grossSalary * 0.20;
    } else if (grossSalary > 50000) {
      tax = grossSalary * 0.10;
    } else {
      tax = 0;
    }
  }

  void calculateNetSalary() {
    netSalary = grossSalary - tax;
  }

  void displaySalarySlip() {
    displayEmployeeInfo();

    print("\nBasic Salary : ₹$basicSalary");
    print("HRA          : ₹$hra");
    print("DA           : ₹$da");
    print("Bonus        : ₹$bonus");

    print("\nGross Salary : ₹${grossSalary.toStringAsFixed(2)}");
    print("Tax          : ₹${tax.toStringAsFixed(2)}");
    print("Net Salary   : ₹${netSalary.toStringAsFixed(2)}");
  }
}

class Manager extends Salary {
  double performanceIncentive = 0;

  @override
  void calculateGrossSalary() {
    grossSalary =
        basicSalary + hra + da + bonus + performanceIncentive;
  }
}

void main() {
  Manager emp = Manager();

  print("Enter Employee ID:");
  emp.employeeId = stdin.readLineSync()!;

  print("Enter Employee Name:");
  emp.employeeName = stdin.readLineSync()!;

  print("Enter Department:");
  emp.department = stdin.readLineSync()!;

  print("Enter Basic Salary:");
  emp.basicSalary = double.parse(stdin.readLineSync()!);

  print("Enter HRA:");
  emp.hra = double.parse(stdin.readLineSync()!);

  print("Enter DA:");
  emp.da = double.parse(stdin.readLineSync()!);

  print("Enter Bonus:");
  emp.bonus = double.parse(stdin.readLineSync()!);

  print("Enter Performance Incentive:");
  emp.performanceIncentive = double.parse(stdin.readLineSync()!);

  emp.calculateGrossSalary();
  emp.calculateTax();
  emp.calculateNetSalary();
  emp.displaySalarySlip();
}