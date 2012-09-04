.PHONY: test clean

my_selection_sort: my_selection_sort.s selection_sort.c
	gcc -Os -m32 $^ -o $@

test: test_my_sort test_gcc_sort

test_my_sort: my_selection_sort.s selection_sort.c
	gcc -Os -m32 -D TEST -D MY_TEST $^ -o $@

test_gcc_sort: selection_sort.c
	gcc -Os -m32 -D TEST -D GCC_TEST $^ -o $@
