/* $Id: GHTTP.xs,v 1.2 2000/11/21 19:59:27 matt Exp $ */

#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ghttp.h"
#ifdef __cplusplus
}
#endif

MODULE = HTTP::GHTTP         PACKAGE = HTTP::GHTTP

ghttp_request *
_new(CLASS)
        char * CLASS
    CODE:
        RETVAL = ghttp_request_new();
        if (RETVAL == NULL) {
            warn("Unable to allocate ghttp_request");
            XSRETURN_UNDEF;
        }
        /* sv_bless(RETVAL, gv_stash_pv(CLASS, 1)); */
    OUTPUT:
        RETVAL

void
DESTROY(self)
        ghttp_request *self
    CODE:
        ghttp_request_destroy(self);

int
set_uri(self, uri)
        ghttp_request *self
        char *uri
    CODE:
        if(ghttp_set_uri(self, uri) == -1) {
            XSRETURN_UNDEF;
        }
        RETVAL = 1;
    OUTPUT:
        RETVAL

int
set_proxy(self, proxy)
        ghttp_request *self
        char *proxy
    CODE:
        RETVAL = ghttp_set_proxy(self, proxy);
    OUTPUT:
        RETVAL

void
set_header(self, hdr, val)
        ghttp_request *self
        const char *hdr
        const char *val
    CODE:
        ghttp_set_header(self, hdr, val);

void
process_request(self)
        ghttp_request *self
    CODE:
        ghttp_prepare(self);
        ghttp_process(self);

const char*
get_header(self, hdr)
        ghttp_request *self
        const char *hdr
    CODE:
        RETVAL = ghttp_get_header(self, hdr);
    OUTPUT:
        RETVAL

int
close(self)
        ghttp_request *self
    CODE:
        RETVAL = ghttp_close(self);
    OUTPUT:
        RETVAL

SV *
get_body(self)
        ghttp_request *self
    PREINIT:
        SV* buffer;
    CODE:
        buffer = NEWSV(0, 0);
        sv_catpvf(buffer, "%s", ghttp_get_body(self));
        RETVAL = buffer;
    OUTPUT:
        RETVAL

const char *
get_error(self)
        ghttp_request *self
    CODE:
        RETVAL = ghttp_get_error(self);
    OUTPUT:
        RETVAL

int
set_authinfo(self, user, pass)
        ghttp_request *self
        const char *user
        const char *pass
    CODE:
        RETVAL = ghttp_set_authinfo(self, user, pass);
    OUTPUT:
        RETVAL

int
set_proxy_authinfo(self, user, pass)
        ghttp_request *self
        const char *user
        const char *pass
    CODE:
        RETVAL = ghttp_set_proxy_authinfo(self, user, pass);
    OUTPUT:
        RETVAL
