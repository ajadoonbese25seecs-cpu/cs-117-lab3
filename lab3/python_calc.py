def calculator():
    print("Simple Calculator")
    print("Operations: +, -, *, /")
    
    try:
        num1 = float(input("Enter first number: "))
        op = input("Enter operation: ")
        num2 = float(input("Enter second number: "))
        
        if op == '+':
            result = num1 + num2
        elif op == '-':
            result = num1 - num2
        elif op == '*':
            result = num1 * num2
        elif op == '/':
            if num2 == 0:
                return "Error: Division by zero"
            result = num1 / num2
        else:
            return "Error: Invalid operation"
            
        return f"Result: {result}"
        
    except ValueError:
        return "Error: Invalid input"

if __name__ == "__main__":
    print(calculator())