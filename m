Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2200C3ED12C
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 11:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhHPJnO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 05:43:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:47659 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231673AbhHPJnO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Aug 2021 05:43:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10077"; a="279571825"
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="279571825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 02:42:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="519589901"
Received: from pwang16-mobl10.ccr.corp.intel.com ([10.255.29.15])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 02:42:39 -0700
Message-ID: <830b7bb290268ac4a4ba8f9c5542b3fa36aff415.camel@intel.com>
Subject: Re: [PATCH] thermal/drivers/intel: Move intel_menlow to thermal
 drivers
From:   Zhang Rui <rui.zhang@intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        hpa@redhat.com, mgross@linux.intel.com, alex.hung@canonical.com,
        sujith.thomas@intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 16 Aug 2021 17:42:37 +0800
In-Reply-To: <144b2a35-bd24-2a88-c538-5c7c4a6c4fd1@linaro.org>
References: <20210816035356.1955982-1-srinivas.pandruvada@linux.intel.com>
         <4d1c20ab-6c81-8e9f-6d0f-180ecaa92812@redhat.com>
         <144b2a35-bd24-2a88-c538-5c7c4a6c4fd1@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2021-08-16 at 10:05 +0200, Daniel Lezcano wrote:
> Hi Hans,
> 
> On 16/08/2021 09:55, Hans de Goede wrote:
> > Hi,
> > 
> > On 8/16/21 5:53 AM, Srinivas Pandruvada wrote:
> > > Moved drivers/platform/x86/intel_menlow.c to
> > > drivers/thermal/intel.
> > > 
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> > 
> > Thank you.
> > 
> > Rui, with this upcoming patch-series:
> > 
> > 
https://lore.kernel.org/platform-driver-x86/c6a90704-5080-d479-0022-58e5d106c026@infradead.org/T/#t
> > 
> > drivers/platform/x86/Kconfig + Makefile
> > 
> > Are going to see quite a bit of churn, is it ok if I merge this
> > patch
> > through the pdx86 tree to avoid conflicts with all those changes?
> > 
> > Rui, if this is ok, may I have your ack for this then ?
> 
> As co-maintainer:
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Done, thanks for the reminder.

-rui

> 
> 
> 
> > > ---
> > >  MAINTAINERS                                            |  4 ++--
> > >  drivers/platform/x86/Kconfig                           | 10 ----
> > > ------
> > >  drivers/platform/x86/Makefile                          |  1 -
> > >  drivers/thermal/intel/Kconfig                          |  9
> > > +++++++++
> > >  drivers/thermal/intel/Makefile                         |  1 +
> > >  drivers/{platform/x86 => thermal/intel}/intel_menlow.c |  0
> > >  6 files changed, 12 insertions(+), 13 deletions(-)
> > >  rename drivers/{platform/x86 => thermal/intel}/intel_menlow.c
> > > (100%)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index fd25e4ecf0b9..4231aea31a6f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9459,10 +9459,10 @@ F:	include/linux/mfd/intel-m10-
> > > bmc.h
> > >  
> > >  INTEL MENLOW THERMAL DRIVER
> > >  M:	Sujith Thomas <sujith.thomas@intel.com>
> > > -L:	platform-driver-x86@vger.kernel.org
> > > +L:	linux-pm@vger.kernel.org
> > >  S:	Supported
> > >  W:	https://01.org/linux-acpi
> > > -F:	drivers/platform/x86/intel_menlow.c
> > > +F:	drivers/thermal/intel/intel_menlow.c
> > >  
> > >  INTEL P-Unit IPC DRIVER
> > >  M:	Zha Qipeng <qipeng.zha@intel.com>
> > > diff --git a/drivers/platform/x86/Kconfig
> > > b/drivers/platform/x86/Kconfig
> > > index d12db6c316ea..da312426b4a5 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -720,16 +720,6 @@ config INTEL_INT0002_VGPIO
> > >  	  To compile this driver as a module, choose M here: the module
> > > will
> > >  	  be called intel_int0002_vgpio.
> > >  
> > > -config INTEL_MENLOW
> > > -	tristate "Thermal Management driver for Intel menlow platform"
> > > -	depends on ACPI_THERMAL
> > > -	select THERMAL
> > > -	help
> > > -	  ACPI thermal management enhancement driver on
> > > -	  Intel Menlow platform.
> > > -
> > > -	  If unsure, say N.
> > > -
> > >  config INTEL_OAKTRAIL
> > >  	tristate "Intel Oaktrail Platform Extras"
> > >  	depends on ACPI
> > > diff --git a/drivers/platform/x86/Makefile
> > > b/drivers/platform/x86/Makefile
> > > index 7ee369aab10d..0d3af23f1186 100644
> > > --- a/drivers/platform/x86/Makefile
> > > +++ b/drivers/platform/x86/Makefile
> > > @@ -72,7 +72,6 @@ obj-$(CONFIG_INTEL_ATOMISP2_LED)	+=
> > > intel_atomisp2_led.o
> > >  obj-$(CONFIG_INTEL_ATOMISP2_PM)		+= intel_atomisp2_pm.o
> > >  obj-$(CONFIG_INTEL_HID_EVENT)		+= intel-hid.o
> > >  obj-$(CONFIG_INTEL_INT0002_VGPIO)	+=
> > > intel_int0002_vgpio.o
> > > -obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
> > >  obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
> > >  obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
> > >  
> > > diff --git a/drivers/thermal/intel/Kconfig
> > > b/drivers/thermal/intel/Kconfig
> > > index e4299ca3423c..c83ea5d04a1d 100644
> > > --- a/drivers/thermal/intel/Kconfig
> > > +++ b/drivers/thermal/intel/Kconfig
> > > @@ -90,3 +90,12 @@ config INTEL_TCC_COOLING
> > >  	  Note that, on different platforms, the behavior might be
> > > different
> > >  	  on how fast the setting takes effect, and how much the CPU
> > > frequency
> > >  	  is reduced.
> > > +
> > > +config INTEL_MENLOW
> > > +	tristate "Thermal Management driver for Intel menlow platform"
> > > +	depends on ACPI_THERMAL
> > > +	help
> > > +	  ACPI thermal management enhancement driver on
> > > +	  Intel Menlow platform.
> > > +
> > > +	  If unsure, say N.
> > > diff --git a/drivers/thermal/intel/Makefile
> > > b/drivers/thermal/intel/Makefile
> > > index 5ff2afa388f7..960b56268b4a 100644
> > > --- a/drivers/thermal/intel/Makefile
> > > +++ b/drivers/thermal/intel/Makefile
> > > @@ -12,3 +12,4 @@ obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) +=
> > > intel_bxt_pmic_thermal.o
> > >  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
> > >  obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
> > >  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> > > +obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
> > > diff --git a/drivers/platform/x86/intel_menlow.c
> > > b/drivers/thermal/intel/intel_menlow.c
> > > similarity index 100%
> > > rename from drivers/platform/x86/intel_menlow.c
> > > rename to drivers/thermal/intel/intel_menlow.c
> > > 
> 
> 

