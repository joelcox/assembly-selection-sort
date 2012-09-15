#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#ifdef TEST
#	define LENGTH 50000
#endif

/* prototype for the assembly implementation: */
int my_selection_sort(int ar[], int length);

/* C implementation: */
int selection_sort (int ar[], int length) {
	int i, i_min, j, result, temp;

	result = 0;
	for ( i = 0 ; i < length ; i++ ) {
		i_min = i;
		for ( j = i+1 ; j < length ; j++ ) {
			if ( ar[i_min] > ar[j] )
				i_min = j;
		}
		temp = ar[i];
		ar[i] = ar[i_min];
		ar[i_min] = temp;
		result += i_min;
	}
	return result;
}

/* print the array contents with a comment: */
void printArray (char s[], int ar[], int length) {
	int i;

	printf("%s",s);
        if ( length < 14 )
                for ( i = 0 ; i < length ; ++i )
                        printf(" %4d", ar[i]);
        else {
                for ( i = 0 ; i < 6 ; ++i )
                        printf(" %4d", ar[i]);
                printf(" ...");
                for ( i = length - 6 ; i < length ; ++i )
                        printf(" %4d", ar[i]);
        }
	printf("\n");
}

/* generates a pseudo-random array: */
void randomArray (int ar[], int length) {
	int i;

	for ( i = 0 ; i < length ; ++i )
		ar[i] = rand() % 10999 - 999;
}

/* copies array source into array target */
void copyArray (int target[], int source[], int length) {
	int i;

	for ( i = 0 ; i < length ; ++i )
		target[i] = source[i];
}

/* checks whether the two arrays contain the same elements.
   ar2 is assumed to be sorted so that binary search is possible.
   The function returns 0 if the array contents are different. */
int compare (int ar1[], int ar2[], int length) {
	int i, min, max, mid, found, *foundeach;

	foundeach = calloc(length, sizeof(int));
	for ( i = 0 ; i < length ; ++i ) {
		found = length;
		min = 0, max = length - 1;
		while ( min <= max ) {
			mid = (max + min) / 2;
			if ( ar2[mid] < ar1[i] )
				min = mid + 1;
			else {
				if ( ar2[mid] == ar1[i] )
					found = mid;
				max = mid - 1;
			}
		}
		if ( found < length ) {
			while ( foundeach[found] && ++found < length )
				if ( ar2[found] != ar1[i] ) {
					found = length;
					break;
				}
		}
		if ( found >= length ) {
			printf("%d niet meer gevonden\n", ar1[i]);
			free(foundeach);
			return 0;
		}
		foundeach[found] = 1;
	}
	free(foundeach);
	return 1;
}

/* runs the selection sort routine and the tests on an array with length elements.
   */
void run(int length) {
        int *ar, *old, n_gcc, n_asm;
	clock_t start_time, stop_time;

	if ( 1 == length )
		printf("\nTest met 1 element\n");
	else
	        printf("\nTest met %d elementen\n", length);
        /* allocate two elements extra, so that we can check whether the
           elements just before and after the array are handled correctly. */
        ar = calloc(length + 2, sizeof(int));
        old = calloc(length + 2, sizeof(int));

	randomArray(ar, length + 2);
	copyArray(old, ar, length + 2);
        printArray("Voor sorteren:", &ar[1], length);
	start_time = clock();

	n_gcc = selection_sort(&ar[1], length);
	n_asm = my_selection_sort(&ar[1], length);

	stop_time = clock();
        printArray("Na sorteren:  ", &ar[1], length);
	printf("Resultaat van de functie volgens GCC: %d\n", n_gcc);
	printf("Resultaat van de functie volgens ASM: %d\n", n_asm);

	printf("Verstreken tijd: %g seconden\n",
		(stop_time - start_time) * (1.0 / CLOCKS_PER_SEC));

        /* Is the array ordered correctly? */
        int i;

	for ( i = 1 ; i < length ; ++i )
		if ( ar[i] > ar[i+1] ) {
			printf("Fout: de array is niet goed gesorteerd!\n"
                                "element(%d) = %d > element(%d) = %d\n\n",
                                i-1, ar[i], i, ar[i+1]);
                        free(ar);
                        free(old);
			return;
		}

        if ( old[0] != ar[0] )
                printf("Fout: het element voor de array is veranderd!\n");
        else if ( old[length + 1] != ar[length + 1] )
                printf("Fout: het element na de array is veranderd!\n");
	else if ( ! compare(&old[1], &ar[1], length) )
		printf("Fout: de array bevat opeens andere elementen!\n");
#ifndef GCC_TEST
        else if ( n_asm != selection_sort(&old[1], length) )
                printf("Fout: het resultaat van de functie is verkeerd!\n");
#endif

        free(ar);
        free(old);
	putchar('\n');
        return;
}

int main (void) {
#ifndef TEST
	srand((unsigned) time(NULL));
        run(2);
        run(10);
        run(25);
        run(1);
        run(0);
#else
        srand(100);
        run(LENGTH);
#endif
	return 0;
}
