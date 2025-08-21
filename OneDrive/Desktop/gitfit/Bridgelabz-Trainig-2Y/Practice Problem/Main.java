public class HelloWorld{
    public static void main(String[] args) {
        System.out.println("Welcome to Bridgelabz!");
    }
}
import java.util.Scanner;

public class HelloWorld {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter first number: ");
        double num1 = sc.nextDouble();
        System.out.print("Enter second number: ");
        double num2 = sc.nextDouble();
        double sum = num1 + num2;
        System.out.println("Sum = " + sum);
        sc.close();
    }
}

import java.util.Scanner;

public class CelsiusToFahrenheit {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter temperature in Celsius: ");
        double celsius = sc.nextDouble();
        double fahrenheit = (celsius * 9 / 5) + 32;
        System.out.println("Temperature in Fahrenheit: " + fahrenheit);
        sc.close();
    }
}

import java.util.Scanner;

public class AreaOfCircle {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter radius: ");
        double radius = sc.nextDouble();
        double area = Math.PI * radius * radius;
        System.out.println("Area of circle = " + area);
        sc.close();
    }
}

import java.util.Scanner;

public class VolumeOfCylinder {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int radius = sc.nextint();
		
    }
}

	
import java.util.Scanner;

public class BasicPrograms {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Enter Principal: ");
        double principal = sc.nextDouble();
        System.out.println("Enter Rate: ");
        double rate = sc.nextDouble();
        System.out.println("Enter Time (in years): ");
        double time = sc.nextDouble();
        double simpleInterest = (principal * rate * time) / 100;
System.out.println("Simple Interest = " + simpleInterest);}}
import java.util.Scanner;

public class BasicPrograms {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("\nEnter Length of Rectangle: ");
        double length = sc.nextDouble();
        System.out.println("Enter Width of Rectangle: ");
        double width = sc.nextDouble();
        double perimeter = 2 * (length + width);
System.out.println("Perimeter of Rectangle = " + perimeter);}}
import java.util.Scanner;

public class BasicPrograms {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("\nEnter Base: ");
        double base = sc.nextDouble();
        System.out.println("Enter Exponent: ");
        double exponent = sc.nextDouble();
        double power = Math.pow(base, exponent);
System.out.println(base + " raised to the power " + exponent + " = " + power);}}
import java.util.Scanner;

public class BasicPrograms {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

 
        System.out.println("\nEnter first number: ");
        double num1 = sc.nextDouble();
        System.out.println("Enter second number: ");
        double num2 = sc.nextDouble();
        System.out.println("Enter third number: ");
        double num3 = sc.nextDouble();
        double average = (num1 + num2 + num3) / 3;
System.out.println("Average = " + average);}}
import java.util.Scanner;

public class BasicPrograms {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

     
        System.out.println("\nEnter distance in Kilometers: ");
        double kilometers = sc.nextDouble();
        double miles = kilometers * 0.621371;
        System.out.println(kilometers + " km in miles = " + miles);

        sc.close();
    }
}

