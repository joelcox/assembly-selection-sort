	.intel_syntax noprefix
	.code32
	.text
	.globl _my_selection_sort
	.include "macros.s"
 		
_my_selection_sort:
	push	ebp
	mov	ebp, esp
	# [ebp+8] contains the address to array elements
	# [ebp+12] contains the array length

	push	esi
	push	edi
	push	ebx
	# Modify below this line

	# Initialize our variables
	mov 	eax, 0		# Set 'i' to 0
	mov	ebx, 0		# Set 'result' to 0
	
	
ofor:	cmp	eax, [ebp + 12]	# SOF outer for loop
	jge	endofor

	# Skip this if i <= 12
	
	# Prep for inner for loop
	mov	ecx, eax	# Set 'min_i' to 'i'
	mov	edx, eax	# Set 'j' to 'i' + 1
	add 	edx, 1
	
ifor:	cmp	edx, [ebp + 12]	# SOF inner for loop
	jge	endifor
	
	# Skip this if j <= 12
	
	# Prep for the condition. The array element are still in RAM
	# so we need to get those into registers first.
	mov esi, [ebp + edx * 4 + 4] # Set 'ar_j'
	mov edi, [ebp + ecx * 4 + 4] # Set 'ar_min_i'

con:	cmp 	esi, edi
	jge	endcon
	
	# Skip this if ar_j < ar_min_i
	mov	ecx, edx

endcon: add	edx, 1
	jmp	ifor		# EOF condition, back to inner loop
	
endifor:
	# Switch ar_i with ar_min_i
	mov esi, [ebp + ecx * 4 + 4] # Set 'ar_min_i'
	mov edi, [ebp + eax * 4 + 4] # Set 'ar_i'
	mov [ebp + ecx * 4 + 4], esi # Move 'ar_min_i' to 'ar_i'
	mov [ebp + eax * 4 + 4], edi # Move 'ar_i' to 'ar_min_i'

	add	ebx, ecx	# Add 'min_i' to 'result'
	add 	eax, 1
	jmp 	ofor
	 
endofor:
	mov eax, ebx	# Put result on EAX
	# Modify above this line
	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret