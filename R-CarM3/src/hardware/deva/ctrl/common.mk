ifndef QCONFIG
QCONFIG=qconfig.mk
endif
include $(QCONFIG)

ifndef CLASS
CLASS=ctrl
endif

NAME=deva-$(CLASS)-$(SECTION)
USEFILE=$(PROJECT_ROOT)/$(SECTION)/$(NAME).use
EXTRA_SILENT_VARIANTS+=$(SECTION)
EXTRA_SRCVPATH += $(EXTRA_SRCVPATH_$(SECTION))

ifneq ($(DEBUG),)
ifneq ($(origin DEBUG),undefined)
CCFLAGS += -DADO_DEBUG=1 
endif
endif

EXTRA_INCVPATH =  $(PRODUCT_ROOT)/../../services/audio/public/include 

ifneq ($(origin DEBUG),undefined)
EXTRA_INCVPATH+= $(AUDIO_ROOT)/public/include

endif

EXTRA_INCVPATH+= $(EXTRA_INCVPATH_$(SECTION))
EXTRA_LIBVPATH += $(EXTRA_LIBVPATH_$(SECTION))
EXTRA_LIBVPATH += $(DMA_ROOT)

LIBS_mx += drvr
LIBS += $(LIBS_$(SECTION))

define PINFO
PINFO DESCRIPTION=
endef

include $(MKFILES_ROOT)/qmacros.mk
-include $(PROJECT_ROOT)/roots.mk
ifndef AUDIO_ROOT
AUDIO_ROOT=$(PRODUCT_ROOT)
endif
ifndef DMA_ROOT
DMA_ROOT=$(PRODUCT_ROOT)../../../../lib/dma/
endif
include $(PROJECT_ROOT)/$(SECTION)/pinfo.mk
#Removes the default -Wl,-Bsymbolic from the link commandline
LDVFLAG_dll= -L.

#####AUTO-GENERATED by packaging script... do not checkin#####
   INSTALL_ROOT_nto = $(PROJECT_ROOT)/../../../../install
   USE_INSTALL_ROOT=1
##############################################################

include $(MKFILES_ROOT)/qtargets.mk


CCFLAGS += -Werror

ifeq ($(filter dll, $(VARIANTS)),)
CCFLAGS += -Dctrl_version=ctrl_version_$(SECTION)
CCFLAGS += -Dctrl_init=ctrl_init_$(SECTION)
CCFLAGS += -Dctrl_destroy=ctrl_destroy_$(SECTION)
endif
