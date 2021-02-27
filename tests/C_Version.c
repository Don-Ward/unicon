/* Identify which C language standard is in use */
#include <stdio.h>
int main()
{
#ifdef __STDC_VERSION__
  /* Values taken from https://sourceforge.net/p/predef/wiki/Standards/ */
  switch (__STDC_VERSION__)
    {
    case 199409L: printf("C94\n"); break;
    case 199901L: printf("C99\n"); break;
    case 201112L: printf("C11\n"); break;
    case 201710L: printf("C18\n"); break;
    default:      printf("%ld\n", __STDC_VERSION__); break;
    }
#else
 #ifdef __STDC__
  printf("C89\n");
 #else
  printf("Unknown\n");
 #endif       /* __STDC__ */
#endif        /* __STDC_VERSION__ */
  return 0;
}

