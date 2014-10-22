/* $Id: GHTTP.xs,v 1.3 2000/11/22 11:59:19 matt Exp $ */

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
        sv_catpvn(buffer, ghttp_get_body(self), ghttp_get_body_len(self));
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

int
set_type(self, type)
        ghttp_request *self
        int type
    CODE:
        RETVAL = ghttp_set_type(self, type);
    OUTPUT:
        RETVAL

int
set_body(self, body)
        ghttp_request *self
        SV *body
    PREINIT:
        STRLEN len;
        char * str;
    CODE:
        str = SvPV(body, len);
        RETVAL = ghttp_set_body(self, str, len);
    OUTPUT:
        RETVAL

int
_get_socket(self)
        ghttp_request *self
    CODE:
        RETVAL = ghttp_get_socket(self);
    OUTPUT:
        RETVAL

void
get_status(self)
        ghttp_request *self
    PREINIT:
        int code;
        const char *reason;
    PPCODE:
        code = ghttp_status_code(self);
        reason = ghttp_reason_phrase(self);
        EXTEND(SP, 2);
        PUSHs(sv_2mortal(newSViv(code)));
        PUSHs(sv_2mortal(newSVpv((char*)reason, 0)));


 #
 # CONSTANTS
 #

int
METHOD_GET()
    CODE:
        RETVAL = ghttp_type_get;
    OUTPUT:
        RETVAL

int
METHOD_OPTIONS()
    CODE:
        RETVAL = ghttp_type_options;
    OUTPUT:
        RETVAL

int
METHOD_HEAD()
    CODE:
        RETVAL = ghttp_type_head;
    OUTPUT:
        RETVAL

int
METHOD_POST()
    CODE:
        RETVAL = ghttp_type_post;
    OUTPUT:
        RETVAL

int
METHOD_PUT()
    CODE:
        RETVAL = ghttp_type_put;
    OUTPUT:
        RETVAL

int
METHOD_DELETE()
    CODE:
        RETVAL = ghttp_type_delete;
    OUTPUT:
        RETVAL

int
METHOD_TRACE()
    CODE:
        RETVAL = ghttp_type_trace;
    OUTPUT:
        RETVAL

int
METHOD_CONNECT()
    CODE:
        RETVAL = ghttp_type_connect;
    OUTPUT:
        RETVAL

int
METHOD_PROPFIND()
    CODE:
        RETVAL = ghttp_type_propfind;
    OUTPUT:
        RETVAL

int
METHOD_PROPPATCH()
    CODE:
        RETVAL = ghttp_type_proppatch;
    OUTPUT:
        RETVAL

int
METHOD_MKCOL()
    CODE:
        RETVAL = ghttp_type_mkcol;
    OUTPUT:
        RETVAL

int
METHOD_COPY()
    CODE:
        RETVAL = ghttp_type_copy;
    OUTPUT:
        RETVAL

int
METHOD_MOVE()
    CODE:
        RETVAL = ghttp_type_move;
    OUTPUT:
        RETVAL

int
METHOD_LOCK()
    CODE:
        RETVAL = ghttp_type_lock;
    OUTPUT:
        RETVAL

int
METHOD_UNLOCK()
    CODE:
        RETVAL = ghttp_type_unlock;
    OUTPUT:
        RETVAL
