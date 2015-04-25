.SUFFIXES :

.SUFFIXES : .f90 .o

SHELL = /bin/sh

CPP = /lib/cpp

FFLAGS =

CFLAGS =

OPTIMIZ = -O 2
$(info OPTIMIZ is ${OPTIMIZ})

CPPFLAGS = 

include version.inc
VER = $(subst ",,$(VOIR_VERSION))

LIBRMN = rmn

default: absolu

FDECKS= voir.F90

absolu: $(FDECKS)
	s.f90 -o voir_$(VER)-$(BASE_ARCH) -l$(LIBRMN) $(FDECKS)
        
clean:
	rm *.o voir_$(VER)-$(BASE_ARCH)
