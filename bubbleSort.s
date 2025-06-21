global _start

.data
array: .word 7, 3, 5, 2, 9

.text
_start:
    PUSH {LR} @saving return value
    LDR R5, =array @loading array into R5
    MOV R6, #0 @outer for loop, i = 0

bubbleSort: @starting of bubble sort function
    PUSH {R4-R12,LR} @saves the callee-saved registers and link register onto stack
    B outer_for_loop @goes to our first loop
    outer_for_loop: @first loop, i,
    CMP R6, #4 @i and 4(the array's size) compared
    BGE end @if i greater or equal to 4, goes to end (exit)
    MOV R7, #0 @inner for loop, j = 0

inner_for_loop: @second for loop, j
    CMP R7, #4 @j and 4 compared
    BGE outer_for_continue @if j greater or equal to 4, goes to outer_loop (if the second for loop ends, it will be back to first for loop)
    LSL R8, R7, #2 @multiplying r7 with 2^2=4 and saving the value to r8
    LDR R9, [R5, R8]@array[j]
    ADD R10, R7, #1 @adding r7(j) to 1 and storing it in r10
    LSL R11, R10, #2 @multiplying r10 with 4 and saving the value to r8
    LDR R12, [R5, R11] @array[j+1]
    CMP R9, R12 @compares array[j] and array[j+1]
    BLE no_swap @if r9 less or equal to r12, doesnt need to swap so goes to no_swap.

    /*If it isnt less or equal to, it will continue in this function*/
    STR R12, [R5, R8] @stores r5's r8th element (equal to r9) to r12
    STR R9, [R5, R11] @stores r5's r11th element (equal to r12) to r9

no_swap:
    ADD R7, R7, #1 @j++
    B inner_for_loop @repeat 

outer_for_continue: @for completing second for loop
    ADD R6, R6, #1 @i++
    B outer_for_loop @repeat

end:
    POP {LR} @restore
    BKPT #0 @stop