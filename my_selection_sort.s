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
	
outer_for:	
	cmp	eax, [ebp + 12]	# SOF outer for loop
	jge	end_outer_for

	# Skip this if i > 12
	
	# Prep for inner for loop
	mov	ecx, eax	# Set 'min_i' to 'i'
	mov	edx, eax	# Set 'j' to 'i' + 1
	add 	edx, 1
	
inner_for:	
	cmp	edx, [ebp + 12]	# SOF inner for loop
	jge	end_inner_for
	
	# Skip this if j > 12
	
	# Prep for the condition. The array element are still in RAM
	# so we need to get those into registers first.
	mov	edi, [ebp + 8]
	mov 	esi, [edi + edx * 4] # Set 'ar_j'

condition:
	# We can have one value in RAM, the other in a register
	cmp 	esi, [edi + ecx * 4]
	jge	end_condition
	
	# Skip this if ar_j < ar_min_i
	mov	ecx, edx

end_condition: 
	add	edx, 1
	jmp	inner_for	# EOF condition, back to inner loop
	
end_inner_for:
	# Get the memory location of the array
	mov	edx, [ebp + 8]	# Reset 'j' for array start
	
	# Switch ar_i with ar_min_i
	mov esi, [edx + ecx * 4] # Set 'ar_min_i'
	mov edi, [edx + eax * 4] # Set 'ar_i'
	mov [edx + ecx * 4], edi # Move 'ar_min_i' to 'ar_i'
	mov [edx + eax * 4], esi # Move 'ar_i' to 'ar_min_i'

	add	ebx, ecx	# Add 'min_i' to 'result'
	add 	eax, 1
	jmp 	outer_for
	 
end_outer_for:
	mov eax, ebx	# Put result on EAX
	# Modify above this line
	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret