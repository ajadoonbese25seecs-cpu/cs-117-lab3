1. Assembly Reflections

○ What did you notice about registers and instructions?

We noticed that registers are actually **temporary storage locations inside the CPU**. They hold data while computing.

○ How is coding in Assembly different from Python?

Instructions in assembly are low-level and correspond directly to machine code executed by the CPU.**For example:**
For moving data, we use "mov, push etc."

However,in **Python**, instructions are high-level and usually in the from of statements/expressions. **For example:**
Arithematic, we use "+, -, /, * "


2. Python Reflections
 
○ Why is Python easier/faster for building the same project?

Assembly language is a low-level programming language that is closely related to machine code. It allows for direct manipulation of hardware and memory, making it extremely efficient and fast.Assembly is used for high-performance tasks.

○ Which features of Python help abstraction (variables, functions, loops)?

In Python, abstraction is achieved using abstract classes and abstract methods.

3. Comparison Table

 Comparison Table
  | Feature | Assembly Example | Python Example | Notes |
  |---------|------------------|----------------|-------|
  |Variable storage|Register(eax)| x=5 |For python, a variable is stored directly by writing the variable name (x, y, z etc.).
---------------------------------------|Whereas in assembly, a register of type EAX (in this case) is used to store the variable
|
  |Printing Output|int 0x80| print()| ..|
  |Arithmetic|add ax, bx | x+y | ..|
  
