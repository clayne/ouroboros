#include "libouroboros.h"
#include "const-c.inc"

MODULE = Ouroboros	PACKAGE = Ouroboros

INCLUDE: autogenerated.inc
INCLUDE: const-xs.inc

BOOT:
	{
		HV *sizes = get_hv("Ouroboros::Size", GV_ADD);
#define SS(ty)  hv_store(sizes, #ty, strlen(#ty), newSVuv(sizeof(ty)), 0)
/* sizeof { */
		SS(bool);
		SS(svtype);
		SS(PADOFFSET);
		SS(Optype);
		SS(struct ouroboros_stack);
/* } */
#undef SS
	}
