#
# Copyright (c) 2005-2007 Igor Popov <igorpopov@newmail.ru>
#
# $Id$
#

NAME = myvhost
APACHE_MODULE = mod_myvhost.so
APXS = apxs
SRCS = mod_myvhost.c mod_myvhost_cache.c ap_hash.c escape_sql.c
OBJS = mod_myvhost.o mod_myvhost_cache.o ap_hash.o escape_sql.o

RM = rm -f
LN = ln -sf
CP = cp -f

MYSQLCPPFLAGS = `mysql_config --include`
MYSQLLDFLAGS  = `mysql_config --libs`

CFLAGS = -Wc,-Wall $(MYSQLCPPFLAGS)
CFLAGS+= -DWITH_PHP -DWITH_CACHE
#CFLAGS+= -DWITH_PHP -DWITH_CACHE -DWITH_UID_GID
CFLAGS+= -DDEBUG
LDFLAGS = -L/usr/local/lib/mysql -W,l$(MYSQLLDFLAGS)

default: all

all: $(APACHE_MODULE)

$(APACHE_MODULE): $(SRCS)
	$(APXS) -c $(CFLAGS) $(LDFLAGS) $(SRCS)

install: all
	$(APXS) -i -a -n $(NAME) $(APACHE_MODULE)

clean:
	$(RM) $(OBJS) $(APACHE_MODULE)
