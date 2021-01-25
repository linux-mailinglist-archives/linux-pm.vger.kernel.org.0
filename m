Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609033028E5
	for <lists+linux-pm@lfdr.de>; Mon, 25 Jan 2021 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbhAYRQF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 25 Jan 2021 12:16:05 -0500
Received: from mga11.intel.com ([192.55.52.93]:29258 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730887AbhAYRP6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 25 Jan 2021 12:15:58 -0500
IronPort-SDR: 3DZ9VSWIxdjFh7xyngcvtnT92NYMMNA2e2QVZ5FT5EtWmZi4nGvFIKBTb/fqYTwoPux7wDb1ef
 S8CN0LdpcR/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="176252273"
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="176252273"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 09:14:36 -0800
IronPort-SDR: WZk5WFxrkUlzRj6509R43aAzJJnI+kkAsea9bDRPrdKwpOdf1cQI69cxvFmCGavp+cbrLYJfRb
 Mk5zDXJxsmWA==
X-IronPort-AV: E=Sophos;i="5.79,374,1602572400"; 
   d="scan'208";a="361585930"
Received: from nhawacha-mobl1.amr.corp.intel.com ([10.209.73.20])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 09:14:36 -0800
Message-ID: <9ee4051f627dd91020139b1d077a1fb01565d670.camel@linux.intel.com>
Subject: Re: [PATCH v2 2/2] thermal: Move therm_throt there from x86/mce
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 25 Jan 2021 09:14:35 -0800
In-Reply-To: <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
References: <20210125130533.19938-1-bp@alien8.de>
         <20210125130533.19938-3-bp@alien8.de>
         <b0e54fbb8c8b9fea38152bbf179135a6434340d7.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

On Mon, 2021-01-25 at 23:42 +0800, Zhang Rui wrote:
> Hi, Borislav,
> 
> Thanks for the patch. CC Srinivas.
> 
Thanks for adding me.


> On Mon, 2021-01-25 at 14:05 +0100, Borislav Petkov wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > This functionality has nothing to do with MCE, move it to the
> > thermal(unfortunately)
> > framework and untangle it from MCE.
> > 
Agreed.

But I have a question on how we should handle some new features.

Although interrupt handled in this code is called  "Thermal interrupt",
this interrupt is also used for notification for some other power
/energy efficiency optimization events via IA32_THERM_STATUS and
IA32_PACKAGE_THERM_STATUS.

For example (From SDM):
IA32_PACKAGE_THERM_STATUS
Bit 26:	Hardware Feedback Interface Structure Change Status

Can the handler, processing architectural features via thermal
interrupt, reside in arch/x86 folder or need to be
drivers/thermal/intel?


> Agreed.
> 
> just one question,
> there are many overlaps between this kernel thermal throttling code
> and
> the x86_pkg_temp_thermal driver, is it possible to combine these two
> pieces of code altogether?
May not be a good idea as the events are not just for temperature
notifications.

Thanks,
Srinivas

> 
> thanks,
> rui
> 
> 
> > Have thermal_set_handler() check the build-time assigned default
> > handler
> > stub was the one used before therm_throt assigns a new one.
> > 
> > Requested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > ---
> >  arch/x86/Kconfig                              |  4 ---
> >  arch/x86/include/asm/irq.h                    |  4 +++
> >  arch/x86/include/asm/mce.h                    | 16 ----------
> >  arch/x86/include/asm/thermal.h                | 21 ++++++++++++++
> >  arch/x86/kernel/cpu/intel.c                   |  3 ++
> >  arch/x86/kernel/cpu/mce/Makefile              |  2 --
> >  arch/x86/kernel/cpu/mce/intel.c               |  1 -
> >  arch/x86/kernel/irq.c                         | 29
> > +++++++++++++++++++
> >  drivers/thermal/intel/Kconfig                 |  4 +++
> >  drivers/thermal/intel/Makefile                |  1 +
> >  .../thermal/intel}/therm_throt.c              | 25 ++-------------
> > -
> >  drivers/thermal/intel/x86_pkg_temp_thermal.c  |  3 +-
> >  12 files changed, 67 insertions(+), 46 deletions(-)
> >  create mode 100644 arch/x86/include/asm/thermal.h
> >  rename {arch/x86/kernel/cpu/mce =>
> > drivers/thermal/intel}/therm_throt.c (97%)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 21f851179ff0..9989db3a9bf5 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1158,10 +1158,6 @@ config X86_MCE_INJECT
> >  	  If you don't know what a machine check is and you don't do
> > kernel
> >  	  QA it is safe to say n.
> >  
> > -config X86_THERMAL_VECTOR
> > -	def_bool y
> > -	depends on X86_MCE_INTEL
> > -
> >  source "arch/x86/events/Kconfig"
> >  
> >  config X86_LEGACY_VM86
> > diff --git a/arch/x86/include/asm/irq.h
> > b/arch/x86/include/asm/irq.h
> > index 528c8a71fe7f..ad65fe7dceb1 100644
> > --- a/arch/x86/include/asm/irq.h
> > +++ b/arch/x86/include/asm/irq.h
> > @@ -53,4 +53,8 @@ void arch_trigger_cpumask_backtrace(const struct
> > cpumask *mask,
> >  #define arch_trigger_cpumask_backtrace
> > arch_trigger_cpumask_backtrace
> >  #endif
> >  
> > +#ifdef CONFIG_X86_THERMAL_VECTOR
> > +void thermal_set_handler(void (*handler)(void));
> > +#endif
> > +
> >  #endif /* _ASM_X86_IRQ_H */
> > diff --git a/arch/x86/include/asm/mce.h
> > b/arch/x86/include/asm/mce.h
> > index def9aa5e1fa4..ddfb3cad8dff 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -288,22 +288,6 @@ extern void (*mce_threshold_vector)(void);
> >  /* Deferred error interrupt handler */
> >  extern void (*deferred_error_int_vector)(void);
> >  
> > -/*
> > - * Thermal handler
> > - */
> > -
> > -void intel_init_thermal(struct cpuinfo_x86 *c);
> > -
> > -/* Interrupt Handler for core thermal thresholds */
> > -extern int (*platform_thermal_notify)(__u64 msr_val);
> > -
> > -/* Interrupt Handler for package thermal thresholds */
> > -extern int (*platform_thermal_package_notify)(__u64 msr_val);
> > -
> > -/* Callback support of rate control, return true, if
> > - * callback has rate control */
> > -extern bool (*platform_thermal_package_rate_control)(void);
> > -
> >  /*
> >   * Used by APEI to report memory error via /dev/mcelog
> >   */
> > diff --git a/arch/x86/include/asm/thermal.h
> > b/arch/x86/include/asm/thermal.h
> > new file mode 100644
> > index 000000000000..58b0e0a4af6e
> > --- /dev/null
> > +++ b/arch/x86/include/asm/thermal.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _ASM_X86_THERMAL_H
> > +#define _ASM_X86_THERMAL_H
> > +
> > +/* Interrupt Handler for package thermal thresholds */
> > +extern int (*platform_thermal_package_notify)(__u64 msr_val);
> > +
> > +/* Interrupt Handler for core thermal thresholds */
> > +extern int (*platform_thermal_notify)(__u64 msr_val);
> > +
> > +/* Callback support of rate control, return true, if
> > + * callback has rate control */
> > +extern bool (*platform_thermal_package_rate_control)(void);
> > +
> > +#ifdef CONFIG_X86_THERMAL_VECTOR
> > +void intel_init_thermal(struct cpuinfo_x86 *c);
> > +#else
> > +static inline void intel_init_thermal(struct cpuinfo_x86 *c) { }
> > +#endif
> > +
> > +#endif /* _ASM_X86_THERMAL_H */
> > diff --git a/arch/x86/kernel/cpu/intel.c
> > b/arch/x86/kernel/cpu/intel.c
> > index 59a1e3ce3f14..71221af87cb1 100644
> > --- a/arch/x86/kernel/cpu/intel.c
> > +++ b/arch/x86/kernel/cpu/intel.c
> > @@ -24,6 +24,7 @@
> >  #include <asm/traps.h>
> >  #include <asm/resctrl.h>
> >  #include <asm/numa.h>
> > +#include <asm/thermal.h>
> >  
> >  #ifdef CONFIG_X86_64
> >  #include <linux/topology.h>
> > @@ -719,6 +720,8 @@ static void init_intel(struct cpuinfo_x86 *c)
> >  		tsx_disable();
> >  
> >  	split_lock_init();
> > +
> > +	intel_init_thermal(c);
> >  }
> >  
> >  #ifdef CONFIG_X86_32
> > diff --git a/arch/x86/kernel/cpu/mce/Makefile
> > b/arch/x86/kernel/cpu/mce/Makefile
> > index 9f020c994154..015856abdbb1 100644
> > --- a/arch/x86/kernel/cpu/mce/Makefile
> > +++ b/arch/x86/kernel/cpu/mce/Makefile
> > @@ -9,8 +9,6 @@ obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
> >  mce-inject-y			:= inject.o
> >  obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
> >  
> > -obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> > -
> >  obj-$(CONFIG_ACPI_APEI)		+= apei.o
> >  
> >  obj-$(CONFIG_X86_MCELOG_LEGACY)	+= dev-mcelog.o
> > diff --git a/arch/x86/kernel/cpu/mce/intel.c
> > b/arch/x86/kernel/cpu/mce/intel.c
> > index c2476fe0682e..e309476743b7 100644
> > --- a/arch/x86/kernel/cpu/mce/intel.c
> > +++ b/arch/x86/kernel/cpu/mce/intel.c
> > @@ -531,7 +531,6 @@ static void intel_imc_init(struct cpuinfo_x86
> > *c)
> >  
> >  void mce_intel_feature_init(struct cpuinfo_x86 *c)
> >  {
> > -	intel_init_thermal(c);
> >  	intel_init_cmci();
> >  	intel_init_lmce();
> >  	intel_ppin_init(c);
> > diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> > index c5dd50369e2f..523fa5266d3e 100644
> > --- a/arch/x86/kernel/irq.c
> > +++ b/arch/x86/kernel/irq.c
> > @@ -374,3 +374,32 @@ void fixup_irqs(void)
> >  	}
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_X86_THERMAL_VECTOR
> > +static void unexpected_thermal_interrupt(void)
> > +{
> > +	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
> > +		smp_processor_id());
> > +}
> > +
> > +static void (*smp_thermal_vector)(void) =
> > unexpected_thermal_interrupt;
> > +
> > +void thermal_set_handler(void (*handler)(void))
> > +{
> > +	if (handler) {
> > +		WARN_ON(smp_thermal_vector !=
> > unexpected_thermal_interrupt);
> > +		smp_thermal_vector = handler;
> > +	} else {
> > +		smp_thermal_vector = unexpected_thermal_interrupt;
> > +	}
> > +}
> > +
> > +DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> > +{
> > +	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> > +	inc_irq_stat(irq_thermal_count);
> > +	smp_thermal_vector();
> > +	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> > +	ack_APIC_irq();
> > +}
> > +#endif
> > diff --git a/drivers/thermal/intel/Kconfig
> > b/drivers/thermal/intel/Kconfig
> > index 8025b21f43fa..ce4f59213c7a 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -8,6 +8,10 @@ config INTEL_POWERCLAMP
> >  	  enforce idle time which results in more package C-state
> > residency. The
> >  	  user interface is exposed via generic thermal framework.
> >  
> > +config X86_THERMAL_VECTOR
> > +	def_bool y
> > +	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
> > +
> >  config X86_PKG_TEMP_THERMAL
> >  	tristate "X86 package temperature thermal driver"
> >  	depends on X86_THERMAL_VECTOR
> > diff --git a/drivers/thermal/intel/Makefile
> > b/drivers/thermal/intel/Makefile
> > index 0d9736ced5d4..ff2ad30ef397 100644
> > --- a/drivers/thermal/intel/Makefile
> > +++ b/drivers/thermal/intel/Makefile
> > @@ -10,3 +10,4 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+=
> > intel_quark_dts_thermal.o
> >  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
> >  obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
> >  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
> > +obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> > diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> > b/drivers/thermal/intel/therm_throt.c
> > similarity index 97%
> > rename from arch/x86/kernel/cpu/mce/therm_throt.c
> > rename to drivers/thermal/intel/therm_throt.c
> > index 5b1aa0f30655..4f12fcd0e40a 100644
> > --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> > +++ b/drivers/thermal/intel/therm_throt.c
> > @@ -26,13 +26,11 @@
> >  #include <linux/cpu.h>
> >  
> >  #include <asm/processor.h>
> > +#include <asm/thermal.h>
> >  #include <asm/traps.h>
> >  #include <asm/apic.h>
> > -#include <asm/mce.h>
> > +#include <asm/irq.h>
> >  #include <asm/msr.h>
> > -#include <asm/trace/irq_vectors.h>
> > -
> > -#include "internal.h"
> >  
> >  /* How long to wait between reporting thermal events */
> >  #define CHECK_INTERVAL		(300 * HZ)
> > @@ -606,23 +604,6 @@ static void intel_thermal_interrupt(void)
> >  	}
> >  }
> >  
> > -static void unexpected_thermal_interrupt(void)
> > -{
> > -	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
> > -		smp_processor_id());
> > -}
> > -
> > -static void (*smp_thermal_vector)(void) =
> > unexpected_thermal_interrupt;
> > -
> > -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> > -{
> > -	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> > -	inc_irq_stat(irq_thermal_count);
> > -	smp_thermal_vector();
> > -	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> > -	ack_APIC_irq();
> > -}
> > -
> >  /* Thermal monitoring depends on APIC, ACPI and clock modulation
> > */
> >  static int intel_thermal_supported(struct cpuinfo_x86 *c)
> >  {
> > @@ -718,7 +699,7 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
> >  				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
> >  	}
> >  
> > -	smp_thermal_vector = intel_thermal_interrupt;
> > +	thermal_set_handler(intel_thermal_interrupt);
> >  
> >  	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
> >  	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
> > diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > index b81c33202f41..090f9176ba62 100644
> > --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> > @@ -17,8 +17,9 @@
> >  #include <linux/pm.h>
> >  #include <linux/thermal.h>
> >  #include <linux/debugfs.h>
> > +
> >  #include <asm/cpu_device_id.h>
> > -#include <asm/mce.h>
> > +#include <asm/thermal.h>
> >  
> >  /*
> >  * Rate control delay: Idea is to introduce denounce effect

