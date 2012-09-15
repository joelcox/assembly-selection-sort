	.intel_syntax noprefix
	.code32
	.text
	.globl _my_selection_sort
	.include "macros.s"
_my_selection_sort:
	push	ebp
	mov		ebp, esp
	# In [ebp+8] staat nu het adres van ar
	# In [ebp+12] staat nu length

	push	esi
	push	edi
	push	ebx
	# Het is niet nodig iets aan de instructies hierboven te
	# veranderen. Voeg je programma hieronder in.



	# zet eax op het resultaat van de functie
	#mov	eax, ...

	# Het is niet nodig iets aan de instructies hieronder te
	# veranderen.
	pop		ebx
	pop		edi
	pop		esi
	pop		ebp
	ret
