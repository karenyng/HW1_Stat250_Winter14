#include "csvSampler.h"
#include <R_ext/Rdynload.h>

static R_CallMethodDef CallEntries[] = {
     {"R_csv_sample", (DL_FUNC) &R_csv_sample, 2},
     {NULL, NULL, 0}
};

void  R_init_FastCSVSample(DllInfo *dll)
{
   R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
   R_useDynamicSymbols(dll, TRUE);
}
