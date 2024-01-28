#!/bin/bash

# Step 1: Compile all .c files
for file in *.c; do
    gcc -pedantic -Wall -Wextra -Werror -O2 -o "${file%.c}.co" -c "$file"
done

# Step 2: Compile all .s files
for file in *.s; do
    gcc -pedantic -Wall -Wextra -Werror -O2 -o "${file%.s}.so" -c "$file"
done

# Step 3: Compile all .cpp files
for file in *.cpp; do
    g++ -pedantic -Wall -Wextra -Werror -O2 -o "${file%.cpp}.cppo" -c "$file"
done

# Step 4: Combine all compiled files
g++ -pedantic -Wall -Wextra -Werror -O2 -o run *.co *.so *.cppo

# Step 5: Run the compiled output file
./run
