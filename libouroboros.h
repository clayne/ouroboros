#ifndef OUROBOROS_H
#define OUROBOROS_H

#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

struct ouroboros_stack {
        SV **sp;
        SV **mark;
        int ax;
        int items;
};

typedef struct ouroboros_stack* ouroboros_stack_t;

/* functions { */
void ouroboros_stack_init(pTHX_ ouroboros_stack_t);
void ouroboros_stack_prepush(pTHX_ ouroboros_stack_t);
void ouroboros_stack_putback(pTHX_ ouroboros_stack_t);
SV* ouroboros_stack_fetch(pTHX_ ouroboros_stack_t, SSize_t);
void ouroboros_stack_store(pTHX_ ouroboros_stack_t, SSize_t, SV*);
void ouroboros_stack_xpush_sv(pTHX_ ouroboros_stack_t, SV*);
void ouroboros_stack_xpush_sv_mortal(pTHX_ ouroboros_stack_t, SV*);
void ouroboros_stack_xpush_iv(pTHX_ ouroboros_stack_t, IV);
void ouroboros_stack_xpush_uv(pTHX_ ouroboros_stack_t, UV);
void ouroboros_stack_xpush_nv(pTHX_ ouroboros_stack_t, NV);
void ouroboros_stack_xpush_pv(pTHX_ ouroboros_stack_t, const char*, STRLEN);
IV ouroboros_sv_iv(pTHX_ SV*);
UV ouroboros_sv_uv(pTHX_ SV*);
NV ouroboros_sv_nv(pTHX_ SV*);
U32 ouroboros_sv_rok(pTHX_ SV*);
SV* ouroboros_sv_rv(pTHX_ SV*);
IV ouroboros_sv_type(pTHX_ SV*);
U32 ouroboros_sv_refcnt(pTHX_ SV*);
SV* ouroboros_sv_refcnt_inc(pTHX_ SV*);
SV* ouroboros_sv_refcnt_inc_nn(pTHX_ SV*);
void ouroboros_sv_refcnt_inc_void(pTHX_ SV*);
void ouroboros_sv_refcnt_inc_void_nn(pTHX_ SV*);
void ouroboros_sv_refcnt_dec(pTHX_ SV*);
void ouroboros_sv_refcnt_dec_nn(pTHX_ SV*);
/* } */

#endif
