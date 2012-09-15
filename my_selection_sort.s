	.intel_syntax noprefix
	.code32
	.text
	.globl _my_selection_sort
	.include "macros.s"
 		
_my_selection_sort:
	push	ebp
	mov	ebp, esp
	# [ebp+8] contains the address to array elements
	# [ebp+12] contains the array lengt

	push	esi
	push	edi
	push	ebx
	# Modify below this line

	mov 	eax, 0		# Set 'i' to 0
	mov	ebx, 0		# Set 'result' to 0
	
ofor:	cmp	eax, [ebp + 12]	# SOF outer for loop
	jge	endofor
	
	# Skip this if i <= 12
	
	# Prep for inner for loop
	mov	ecx, eax	# Set 'min_i' to 'i'
	mov	edx, eax + 1	# Set 'j' to 'i' + 1
	
ifor:	cmp	edx, ebx + 12	# SOF inner for loop
	jge	endifor
	
	# Skip this if j <= 12
	
	# Prep for the condition. The array element are still in RAM
	# so we need to get those into registers first.
	#mov esi, [ebp + edx * 4 + 8] # Set 'ar_j'
	#mov edi, [ebp + ecx * 4 + 8] # Set 'ar_min_i'
	
con:	cmp esi, edi
	jg	endcon
	
	# Skip this if ar_j < ar_min_i
	mov	ecx, edx
	
endcon: add	edx, 1
	jmp	ifor		# EOF condition, back to inner loop
	
endifor:add	eax, 1		# EOF inner for loop
	# Switch ar_i with ar_min_i here
	add	ebx, ecx	# Add 'min_i' to 'result'
	jmp 	ofor

	# Put the function result on eax 
endofor:mov	eax, ebx

	# Modify above this line
	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret