AC_PREREQ(2.59)
AC_INIT([b2l-material-editor],[0.1])

AC_CHECK_PROG(BISON,bison,bison)

AS_IF([test x$BISON != xbison],AC_MSG_ERROR([Could not find bison]))

AC_CHECK_PROG(FLEX,flex,flex)

AS_IF([test x$FLEX != xflex],AC_MSG_ERROR([Could not find flex]))

AC_MSG_CHECKING([if bison is new enough])
dir=`mktemp -d`
bison $srcdir/tests/test.y -o $dir/test.c || BISON=no
rm -r $dir
test $BISON = no && AC_MSG_ERROR([Bison version 3.0.4 or newer is required])
AC_MSG_RESULT([yes])

PKG_CHECK_MODULES(GLIB2,glib-2.0)
PKG_CHECK_MODULES(GTK3,gtk+-3.0)
PKG_CHECK_MODULES(GDKPIXBUF2,gdk-pixbuf-2.0)
PKG_CHECK_MODULES(GMODULE2,gmodule-2.0)
PKG_CHECK_MODULES(LIBFFI,libffi)
PKG_CHECK_MODULES(GOBJECT_INTROSPECTION,gobject-introspection-1.0)

AC_PROG_CC

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
