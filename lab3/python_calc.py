while True:
    print("\n=== Simple Calculator ===")
    print("Select an operation:")
    print("+ for Addition")
    print("- for Subtraction")
    print("* for Multiplication")
    print("/ for Division")
    print("e for Even/Odd check")
    print("% for Percentage")
    print("q to Exit")
    choice = input("Enter your choice: ")
    if choice == 'q':
        print("Exiting the calculator. Goodbye!")
        break
    if choice in ['+', '-', '*', '/', '%']:
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
    if choice == '+':
        result = num1 + num2
        print("Result:", result)
    elif choice == '-':
        result = num1 - num2
        print("Result:", result)
    elif choice == '*':
        result = num1 * num2
        print("Result:", result)
    elif choice == '/':
        if num2 != 0:
            result = num1 / num2
            print("Result:", result)
        else:
            print("Error! Cannot divide by zero.")
    elif choice == '%':
        if num2 != 0:
            result = (num1 / num2) * 100
            print("Percentage:", result, "%")
        else:
            print("Error! Cannot divide by zero.")
    elif choice == 'e':
        num = int(input("Enter a number: "))
        if num % 2 == 0:
            print(num, "is Even")
        else:
            print(num, "is Odd")
    else:
        print("Invalid choice! Try again.")
