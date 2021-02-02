Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A4630C965
	for <lists+linux-pm@lfdr.de>; Tue,  2 Feb 2021 19:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbhBBSRJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Feb 2021 13:17:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:23797 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238174AbhBBSO7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 Feb 2021 13:14:59 -0500
IronPort-SDR: nO3MWi2c5HpepWAFit8WMkE1kKPHrNg9WXTR8kc4kl20vIjInEIQlo6C5+olsK+jaBFhNnenX5
 4Gdwu7kYn6cQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160667871"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160667871"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:13:09 -0800
IronPort-SDR: xfs5Ukx/8WliZhVsiqfCjS9bS9YlsYP7xrXvZDKEgyUVZt/jXQBq8JnhVWs48VxTdxvc60l3uv
 sWKnZmD28cAg==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="433028733"
Received: from spandruv-mobl.amr.corp.intel.com ([10.212.187.200])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 10:13:08 -0800
Message-ID: <1c596a66407fc56ef5e079f9b47d58dc80af4bf2.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/2] thermal: Move therm_throt there from x86/mce
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Tony Luck <tony.luck@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Date:   Tue, 02 Feb 2021 10:13:08 -0800
In-Reply-To: <20210202121003.GD18075@zn.tnic>
References: <20210201142704.12495-1-bp@alien8.de>
         <20210201142704.12495-3-bp@alien8.de>
         <bcf48ba877acf7ae003672d5b7cf2effe004ca0e.camel@linux.intel.com>
         <20210202121003.GD18075@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2021-02-02 at 13:10 +0100, Borislav Petkov wrote:
> On Mon, Feb 01, 2021 at 11:10:29AM -0800, Srinivas Pandruvada wrote:
> > Only user of the above interface is in drivers/thermal/intel.
> > So why can't we move these to
> > drivers/thermal/intel/thermal_interrupt.h
> > or similar?
> 
> Sure, see below.
> 
Thanks.

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
> From: Borislav Petkov <bp@suse.de>
> Date: Thu, 7 Jan 2021 13:29:05 +0100
> Subject: [PATCH] thermal: Move therm_throt there from x86/mce
> 
> This functionality has nothing to do with MCE, move it to the thermal
> framework and untangle it from MCE.
> 
> Requested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/Kconfig                              |  4 ---
>  arch/x86/include/asm/mce.h                    | 16 ----------
>  arch/x86/include/asm/thermal.h                | 13 ++++++++
>  arch/x86/kernel/cpu/intel.c                   |  3 ++
>  arch/x86/kernel/cpu/mce/Makefile              |  2 --
>  arch/x86/kernel/cpu/mce/intel.c               |  1 -
>  arch/x86/kernel/irq.c                         | 21 ++++++++++++
>  drivers/thermal/intel/Kconfig                 |  4 +++
>  drivers/thermal/intel/Makefile                |  1 +
>  .../thermal/intel}/therm_throt.c              | 32 ++++++-----------
> --
>  drivers/thermal/intel/thermal_interrupt.h     | 15 +++++++++
>  drivers/thermal/intel/x86_pkg_temp_thermal.c  |  4 ++-
>  12 files changed, 69 insertions(+), 47 deletions(-)
>  create mode 100644 arch/x86/include/asm/thermal.h
>  rename {arch/x86/kernel/cpu/mce =>
> drivers/thermal/intel}/therm_throt.c (97%)
>  create mode 100644 drivers/thermal/intel/thermal_interrupt.h
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 21f851179ff0..9989db3a9bf5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1158,10 +1158,6 @@ config X86_MCE_INJECT
>  	  If you don't know what a machine check is and you don't do
> kernel
>  	  QA it is safe to say n.
>  
> -config X86_THERMAL_VECTOR
> -	def_bool y
> -	depends on X86_MCE_INTEL
> -
>  source "arch/x86/events/Kconfig"
>  
>  config X86_LEGACY_VM86
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index def9aa5e1fa4..ddfb3cad8dff 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -288,22 +288,6 @@ extern void (*mce_threshold_vector)(void);
>  /* Deferred error interrupt handler */
>  extern void (*deferred_error_int_vector)(void);
>  
> -/*
> - * Thermal handler
> - */
> -
> -void intel_init_thermal(struct cpuinfo_x86 *c);
> -
> -/* Interrupt Handler for core thermal thresholds */
> -extern int (*platform_thermal_notify)(__u64 msr_val);
> -
> -/* Interrupt Handler for package thermal thresholds */
> -extern int (*platform_thermal_package_notify)(__u64 msr_val);
> -
> -/* Callback support of rate control, return true, if
> - * callback has rate control */
> -extern bool (*platform_thermal_package_rate_control)(void);
> -
>  /*
>   * Used by APEI to report memory error via /dev/mcelog
>   */
> diff --git a/arch/x86/include/asm/thermal.h
> b/arch/x86/include/asm/thermal.h
> new file mode 100644
> index 000000000000..ddbdefd5b94f
> --- /dev/null
> +++ b/arch/x86/include/asm/thermal.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_THERMAL_H
> +#define _ASM_X86_THERMAL_H
> +
> +#ifdef CONFIG_X86_THERMAL_VECTOR
> +void intel_init_thermal(struct cpuinfo_x86 *c);
> +bool x86_thermal_enabled(void);
> +void intel_thermal_interrupt(void);
> +#else
> +static inline void intel_init_thermal(struct cpuinfo_x86 *c) { }
> +#endif
> +
> +#endif /* _ASM_X86_THERMAL_H */
> diff --git a/arch/x86/kernel/cpu/intel.c
> b/arch/x86/kernel/cpu/intel.c
> index 59a1e3ce3f14..71221af87cb1 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -24,6 +24,7 @@
>  #include <asm/traps.h>
>  #include <asm/resctrl.h>
>  #include <asm/numa.h>
> +#include <asm/thermal.h>
>  
>  #ifdef CONFIG_X86_64
>  #include <linux/topology.h>
> @@ -719,6 +720,8 @@ static void init_intel(struct cpuinfo_x86 *c)
>  		tsx_disable();
>  
>  	split_lock_init();
> +
> +	intel_init_thermal(c);
>  }
>  
>  #ifdef CONFIG_X86_32
> diff --git a/arch/x86/kernel/cpu/mce/Makefile
> b/arch/x86/kernel/cpu/mce/Makefile
> index 9f020c994154..015856abdbb1 100644
> --- a/arch/x86/kernel/cpu/mce/Makefile
> +++ b/arch/x86/kernel/cpu/mce/Makefile
> @@ -9,8 +9,6 @@ obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
>  mce-inject-y			:= inject.o
>  obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
>  
> -obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> -
>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>  
>  obj-$(CONFIG_X86_MCELOG_LEGACY)	+= dev-mcelog.o
> diff --git a/arch/x86/kernel/cpu/mce/intel.c
> b/arch/x86/kernel/cpu/mce/intel.c
> index c2476fe0682e..e309476743b7 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -531,7 +531,6 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
>  
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  {
> -	intel_init_thermal(c);
>  	intel_init_cmci();
>  	intel_init_lmce();
>  	intel_ppin_init(c);
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index c5dd50369e2f..d4ad344e80bf 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -21,6 +21,7 @@
>  #include <asm/hw_irq.h>
>  #include <asm/desc.h>
>  #include <asm/traps.h>
> +#include <asm/thermal.h>
>  
>  #define CREATE_TRACE_POINTS
>  #include <asm/trace/irq_vectors.h>
> @@ -374,3 +375,23 @@ void fixup_irqs(void)
>  	}
>  }
>  #endif
> +
> +#ifdef CONFIG_X86_THERMAL_VECTOR
> +static void smp_thermal_vector(void)
> +{
> +	if (x86_thermal_enabled())
> +		intel_thermal_interrupt();
> +	else
> +		pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
> +		       smp_processor_id());
> +}
> +
> +DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> +{
> +	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> +	inc_irq_stat(irq_thermal_count);
> +	smp_thermal_vector();
> +	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> +	ack_APIC_irq();
> +}
> +#endif
> diff --git a/drivers/thermal/intel/Kconfig
> b/drivers/thermal/intel/Kconfig
> index 8025b21f43fa..ce4f59213c7a 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -8,6 +8,10 @@ config INTEL_POWERCLAMP
>  	  enforce idle time which results in more package C-state
> residency. The
>  	  user interface is exposed via generic thermal framework.
>  
> +config X86_THERMAL_VECTOR
> +	def_bool y
> +	depends on X86 && CPU_SUP_INTEL && X86_LOCAL_APIC
> +
>  config X86_PKG_TEMP_THERMAL
>  	tristate "X86 package temperature thermal driver"
>  	depends on X86_THERMAL_VECTOR
> diff --git a/drivers/thermal/intel/Makefile
> b/drivers/thermal/intel/Makefile
> index 0d9736ced5d4..ff2ad30ef397 100644
> --- a/drivers/thermal/intel/Makefile
> +++ b/drivers/thermal/intel/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+=
> intel_quark_dts_thermal.o
>  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>  obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
>  obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
> +obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c
> b/drivers/thermal/intel/therm_throt.c
> similarity index 97%
> rename from arch/x86/kernel/cpu/mce/therm_throt.c
> rename to drivers/thermal/intel/therm_throt.c
> index 5b15d7cef1d1..f8e882592ba5 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -26,13 +26,13 @@
>  #include <linux/cpu.h>
>  
>  #include <asm/processor.h>
> +#include <asm/thermal.h>
>  #include <asm/traps.h>
>  #include <asm/apic.h>
> -#include <asm/mce.h>
> +#include <asm/irq.h>
>  #include <asm/msr.h>
> -#include <asm/trace/irq_vectors.h>
>  
> -#include "internal.h"
> +#include "thermal_interrupt.h"
>  
>  /* How long to wait between reporting thermal events */
>  #define CHECK_INTERVAL		(300 * HZ)
> @@ -570,7 +570,7 @@ static void notify_thresholds(__u64 msr_val)
>  }
>  
>  /* Thermal transition interrupt handler */
> -static void intel_thermal_interrupt(void)
> +void intel_thermal_interrupt(void)
>  {
>  	__u64 msr_val;
>  
> @@ -606,23 +606,6 @@ static void intel_thermal_interrupt(void)
>  	}
>  }
>  
> -static void unexpected_thermal_interrupt(void)
> -{
> -	pr_err("CPU%d: Unexpected LVT thermal interrupt!\n",
> -		smp_processor_id());
> -}
> -
> -static void (*smp_thermal_vector)(void) =
> unexpected_thermal_interrupt;
> -
> -DEFINE_IDTENTRY_SYSVEC(sysvec_thermal)
> -{
> -	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
> -	inc_irq_stat(irq_thermal_count);
> -	smp_thermal_vector();
> -	trace_thermal_apic_exit(THERMAL_APIC_VECTOR);
> -	ack_APIC_irq();
> -}
> -
>  /* Thermal monitoring depends on APIC, ACPI and clock modulation */
>  static int intel_thermal_supported(struct cpuinfo_x86 *c)
>  {
> @@ -633,6 +616,11 @@ static int intel_thermal_supported(struct
> cpuinfo_x86 *c)
>  	return 1;
>  }
>  
> +bool x86_thermal_enabled(void)
> +{
> +	return atomic_read(&therm_throt_en);
> +}
> +
>  void intel_init_thermal(struct cpuinfo_x86 *c)
>  {
>  	unsigned int cpu = smp_processor_id();
> @@ -719,8 +707,6 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
>  				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
>  	}
>  
> -	smp_thermal_vector = intel_thermal_interrupt;
> -
>  	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
>  	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
>  
> diff --git a/drivers/thermal/intel/thermal_interrupt.h
> b/drivers/thermal/intel/thermal_interrupt.h
> new file mode 100644
> index 000000000000..53f427bb58dc
> --- /dev/null
> +++ b/drivers/thermal/intel/thermal_interrupt.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _INTEL_THERMAL_INTERRUPT_H
> +#define _INTEL_THERMAL_INTERRUPT_H
> +
> +/* Interrupt Handler for package thermal thresholds */
> +extern int (*platform_thermal_package_notify)(__u64 msr_val);
> +
> +/* Interrupt Handler for core thermal thresholds */
> +extern int (*platform_thermal_notify)(__u64 msr_val);
> +
> +/* Callback support of rate control, return true, if
> + * callback has rate control */
> +extern bool (*platform_thermal_package_rate_control)(void);
> +
> +#endif /* _INTEL_THERMAL_INTERRUPT_H */
> diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> index b81c33202f41..295742e83960 100644
> --- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
> +++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
> @@ -17,8 +17,10 @@
>  #include <linux/pm.h>
>  #include <linux/thermal.h>
>  #include <linux/debugfs.h>
> +
>  #include <asm/cpu_device_id.h>
> -#include <asm/mce.h>
> +
> +#include "thermal_interrupt.h"
>  
>  /*
>  * Rate control delay: Idea is to introduce denounce effect
> -- 
> 2.29.2
> 

