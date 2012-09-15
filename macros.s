	.macro	jmp
		.att_syntax
		.macros_off
		jmp	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jg
		.att_syntax
		.macros_off
		jg	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jge
		.att_syntax
		.macros_off
		jge	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jl
		.att_syntax
		.macros_off
		jl	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jle
		.att_syntax
		.macros_off
		jle	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jz
		.att_syntax
		.macros_off
		je	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jnz
		.att_syntax
		.macros_off
		jne	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	je
		.att_syntax
		.macros_off
		je	$0
		.macros_on
		.intel_syntax
	.endm
	.macro	jne
		.att_syntax
		.macros_off
		jne	$0
		.macros_on
		.intel_syntax
	.endm
