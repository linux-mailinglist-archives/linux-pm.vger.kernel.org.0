Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51E45C6E8
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 15:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbhKXOPQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 09:15:16 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35412 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348352AbhKXOMl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Nov 2021 09:12:41 -0500
Received: by mail-oi1-f176.google.com with SMTP id m6so5600479oim.2;
        Wed, 24 Nov 2021 06:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxvgDaZzG6aG91Oqp/cEC4dselvfNvYAb6e+YILhPB8=;
        b=maHYdHR67f4PJOxqGpF6udDyWWIpl3gv3zlsirL+M8CEGq9JzAmcoAaPVqqSOpNP8d
         uvDBsK+05vhwBbeB8UQn6EZBm6+Z1Q7FPnHb/f0vpAIHL+F491+rbeARma/uGe+8/SJE
         p0bXCRk6r9SGtnMI9ivVeAmENo/0aCUwLBoqMR7wBPrpCaJbfsyLsjL2iGu1r18xhzf0
         G6s6AkKvvdG7oeVqrV69PIC7rd3mvxBor1wn5iRMZqRmUeaY/rftMThwdj9G0UQ1EUEZ
         ZojgaC3rzKHO/b86FkMMFd2OIPMRU0dgqFuviZPbgmaC5QeOOsekJMlSO7T+t0bbmzDC
         H32w==
X-Gm-Message-State: AOAM530r6VZko7gRCktZpuO26IG/K832JeD4pB0e90pfCdOhyk0bWahi
        eO8W/cJcyL+eQyEBtIAcTAF102M3HYytCduXgijaje9H97o=
X-Google-Smtp-Source: ABdhPJzl6qxVbY+a4lKLhxm1ZCLL3A7A0CpTaQYSnChhkCuOgY1kMkoowp9B3YxLS0ze1jpI0YVGN6hgHZWC0x0+oBU=
X-Received: by 2002:a05:6808:14c3:: with SMTP id f3mr6372368oiw.51.1637762971351;
 Wed, 24 Nov 2021 06:09:31 -0800 (PST)
MIME-Version: 1.0
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com> <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
In-Reply-To: <20211106013312.26698-4-ricardo.neri-calderon@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 15:09:20 +0100
Message-ID: <CAJZ5v0gd5ZAs4nkbMA4ONt=9ULnrTPqxe_+3M78t9ZC9upEiXw@mail.gmail.com>
Subject: Re: [PATCH 3/7] thermal: intel: hfi: Minimally initialize the
 Hardware Feedback Interface
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 6, 2021 at 2:34 AM Ricardo Neri
<ricardo.neri-calderon@linux.intel.com> wrote:
>
> The Intel Hardware Feedback Interface provides guidance to the operating
> system about the performance and energy efficiency capabilities of each
> CPU in the system. Capabilities are numbers between 0 and 255 where a
> higher number represents a higher capability. For each CPU, energy
> efficiency and performance are reported as separate capabilities.
>
> Hardware computes these capabilities based on the operating conditions of
> the system such as power and thermal limits. These capabilities are shared
> with the operating system in a table resident in memory. Each package in
> the system has its own HFI instance. Every logical CPU in the package is
> represented in the table. More than one logical CPUs may be represented in
> a single table entry. When the hardware updates the table, it generates a
> package-level thermal interrupt.
>
> The size and format of the HFI table depend on the supported features and
> can only be determined at runtime. To minimally initialize the HFI, parse
> its features and allocate one instance per package of a data structure with
> the necessary parameters to read and navigate individual HFI tables.
>
> A subsequent changeset will provide per-CPU initialization and interrupt
> handling.
>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Aubrey Li <aubrey.li@linux.intel.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Co-developed by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
>  drivers/thermal/intel/Kconfig       |  12 +++
>  drivers/thermal/intel/Makefile      |   1 +
>  drivers/thermal/intel/intel_hfi.c   | 155 ++++++++++++++++++++++++++++
>  drivers/thermal/intel/intel_hfi.h   |  34 ++++++
>  drivers/thermal/intel/therm_throt.c |   3 +
>  5 files changed, 205 insertions(+)
>  create mode 100644 drivers/thermal/intel/intel_hfi.c
>  create mode 100644 drivers/thermal/intel/intel_hfi.h
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index c83ea5d04a1d..d4c6bdcacddb 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -99,3 +99,15 @@ config INTEL_MENLOW
>           Intel Menlow platform.
>
>           If unsure, say N.
> +
> +config INTEL_HFI
> +       bool "Intel Hardware Feedback Interface"
> +       depends on CPU_SUP_INTEL
> +       depends on SCHED_MC && X86_THERMAL_VECTOR
> +       help
> +         Select this option to enable the Hardware Feedback Interface. If
> +         selected, hardware provides guidance to the operating system on
> +         the performance and energy efficiency capabilities of each CPU.
> +         These capabilities may change as a result of changes in the operating
> +         conditions of the system such power and thermal limits. If selected,
> +         the kernel relays updates in CPUs' capabilities to userspace.
> diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
> index 960b56268b4a..1a80bffcd699 100644
> --- a/drivers/thermal/intel/Makefile
> +++ b/drivers/thermal/intel/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_INTEL_PCH_THERMAL)       += intel_pch_thermal.o
>  obj-$(CONFIG_INTEL_TCC_COOLING)        += intel_tcc_cooling.o
>  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
>  obj-$(CONFIG_INTEL_MENLOW)     += intel_menlow.o
> +obj-$(CONFIG_INTEL_HFI) += intel_hfi.o
> diff --git a/drivers/thermal/intel/intel_hfi.c b/drivers/thermal/intel/intel_hfi.c
> new file mode 100644
> index 000000000000..edfe343507b3
> --- /dev/null
> +++ b/drivers/thermal/intel/intel_hfi.c
> @@ -0,0 +1,155 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Hardware Feedback Interface Driver
> + *
> + * Copyright (c) 2021, Intel Corporation.
> + *
> + * Authors: Aubrey Li <aubrey.li@linux.intel.com>
> + *          Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> + *
> + *
> + * The Hardware Feedback Interface provides a performance and energy efficiency
> + * capability information for each CPU in the system. Depending on the processor
> + * model, hardware may periodically update these capabilities as a result of
> + * changes in the operating conditions (e.g., power limits or thermal
> + * constraints). On other processor models, there is a single HFI update
> + * at boot.
> + *
> + * This file provides functionality to process HFI updates and relay these
> + * updates to userspace.
> + */
> +
> +#define pr_fmt(fmt)  "intel-hfi: " fmt
> +
> +#include <linux/slab.h>
> +
> +#include "intel_hfi.h"
> +
> +/**
> + * struct hfi_cpu_data - HFI capabilities per CPU
> + * @perf_cap:          Performance capability
> + * @ee_cap:            Energy efficiency capability
> + *
> + * Capabilities of a logical processor in the HFI table. These capabilities are
> + * unitless.
> + */
> +struct hfi_cpu_data {
> +       u8      perf_cap;
> +       u8      ee_cap;
> +} __packed;
> +
> +/**
> + * struct hfi_hdr - Header of the HFI table
> + * @perf_updated:      Hardware updated performance capabilities
> + * @ee_updated:                Hardware updated energy efficiency capabilities
> + *
> + * Properties of the data in an HFI table.
> + */
> +struct hfi_hdr {
> +       u8 perf_updated;
> +       u8 ee_updated;
> +} __packed;
> +
> +/**
> + * struct hfi_instance - Representation of an HFI instance (i.e., a table)
> + * @ts_counter:                Time stamp of the last update of the table
> + * @hdr:               Base address of the table header
> + * @data:              Base address of the table data
> + *
> + * A set of parameters to parse and navigate a specific HFI table.
> + */
> +struct hfi_instance {
> +       u64                     *ts_counter;
> +       void                    *hdr;
> +       void                    *data;
> +};
> +
> +/**
> + * struct hfi_features - Supported HFI features
> + * @capabilities:      Bitmask of supported capabilities
> + * @nr_table_pages:    Size of the HFI table in 4KB pages
> + * @cpu_stride:                Stride size to locate capability data of a logical
> + *                     processor within the table (i.e., row stride)
> + * @hdr_size:          Size of table header
> + * @parsed:            True if HFI features have been parsed
> + *
> + * Parameters and supported features that are common to all HFI instances
> + */
> +struct hfi_features {
> +       unsigned long   capabilities;
> +       unsigned int    nr_table_pages;
> +       unsigned int    cpu_stride;
> +       unsigned int    hdr_size;
> +       bool            parsed;

I'm not sure why this field is needed.

It looks like it is only checked by hfi_parse_features() which is only
called by intel_hfi_init() which is invoked by
thermal_throttle_init_device() which can happen only once if I'm not
mistaken.

> +};
> +
> +static int max_hfi_instances;
> +static struct hfi_instance *hfi_instances;
> +
> +static struct hfi_features hfi_features;
> +
> +static __init int hfi_parse_features(void)
> +{
> +       unsigned int nr_capabilities, reg;
> +
> +       if (!boot_cpu_has(X86_FEATURE_INTEL_HFI))
> +               return -ENODEV;
> +
> +       if (hfi_features.parsed)
> +               return 0;
> +
> +       /*
> +        * If we are here we know that CPUID_HFI_LEAF exists. Parse the
> +        * supported capabilities and the size of the HFI table.
> +        */
> +       reg = cpuid_edx(CPUID_HFI_LEAF);
> +
> +       hfi_features.capabilities = reg & HFI_CAPABILITIES_MASK;
> +       if (!(hfi_features.capabilities & HFI_CAPABILITIES_PERFORMANCE)) {
> +               pr_err("Performance reporting not supported! Not using HFI\n");

This doesn't need to be pr_err().

> +               return -ENODEV;
> +       }
> +
> +       /* The number of 4KB pages required by the table */
> +       hfi_features.nr_table_pages = ((reg & CPUID_HFI_TABLE_SIZE_MASK) >>
> +                                     CPUID_HFI_TABLE_SIZE_SHIFT) + 1;
> +
> +       /*
> +        * The number of supported capabilities determines the number of
> +        * columns in the HFI table.
> +        */
> +       nr_capabilities = bitmap_weight(&hfi_features.capabilities,
> +                                       HFI_CAPABILITIES_NR);
> +
> +       /*
> +        * The header contains change indications for each supported feature.
> +        * The size of the table header is rounded up to be a multiple of 8
> +        * bytes.
> +        */
> +       hfi_features.hdr_size = DIV_ROUND_UP(nr_capabilities, 8) * 8;
> +
> +       /*
> +        * Data of each logical processor is also rounded up to be a multiple
> +        * of 8 bytes.
> +        */
> +       hfi_features.cpu_stride = DIV_ROUND_UP(nr_capabilities, 8) * 8;
> +
> +       hfi_features.parsed = true;
> +       return 0;
> +}
> +
> +void __init intel_hfi_init(void)
> +{
> +       if (hfi_parse_features())
> +               return;
> +
> +       max_hfi_instances = topology_max_packages() *
> +                           topology_max_die_per_package();
> +
> +       /*
> +        * This allocation may fail. CPU hotplug callbacks must check
> +        * for a null pointer.
> +        */
> +       hfi_instances = kcalloc(max_hfi_instances, sizeof(*hfi_instances),
> +                               GFP_KERNEL);
> +}
> diff --git a/drivers/thermal/intel/intel_hfi.h b/drivers/thermal/intel/intel_hfi.h
> new file mode 100644
> index 000000000000..42529d3ac92d
> --- /dev/null
> +++ b/drivers/thermal/intel/intel_hfi.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _INTEL_HFI_H
> +#define _INTEL_HFI_H
> +
> +#include <linux/bits.h>
> +
> +/* Hardware Feedback Interface Enumeration */
> +#define CPUID_HFI_LEAF                 6
> +#define CPUID_HFI_CAP_MASK             0xff
> +#define CPUID_HFI_TABLE_SIZE_MASK      0x0f00
> +#define CPUID_HFI_TABLE_SIZE_SHIFT     8
> +#define CPUID_HFI_CPU_INDEX_MASK       0xffff0000
> +#define CPUID_HFI_CPU_INDEX_SHIFT      16
> +
> +/* Hardware Feedback Interface Pointer */
> +#define HFI_PTR_VALID_BIT              BIT(0)
> +#define HFI_PTR_ADDR_SHIFT             12
> +
> +/* Hardware Feedback Interface Configuration */
> +#define HFI_CONFIG_ENABLE_BIT          BIT(0)
> +
> +/* Hardware Feedback Interface Capabilities */
> +#define HFI_CAPABILITIES_MASK          0xff
> +#define HFI_CAPABILITIES_NR            8
> +#define HFI_CAPABILITIES_PERFORMANCE   BIT(0)
> +#define HFI_CAPABILITIES_ENERGY_EFF    BIT(1)
> +
> +#if defined(CONFIG_INTEL_HFI)
> +void __init intel_hfi_init(void);
> +#else
> +static inline void intel_hfi_init(void) { }
> +#endif
> +
> +#endif /* _INTEL_HFI_H */
> diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
> index dab7e8fb1059..ac408714d52b 100644
> --- a/drivers/thermal/intel/therm_throt.c
> +++ b/drivers/thermal/intel/therm_throt.c
> @@ -32,6 +32,7 @@
>  #include <asm/irq.h>
>  #include <asm/msr.h>
>
> +#include "intel_hfi.h"
>  #include "thermal_interrupt.h"
>
>  /* How long to wait between reporting thermal events */
> @@ -509,6 +510,8 @@ static __init int thermal_throttle_init_device(void)
>         if (!atomic_read(&therm_throt_en))
>                 return 0;
>
> +       intel_hfi_init();
> +
>         ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/therm:online",
>                                 thermal_throttle_online,
>                                 thermal_throttle_offline);
> --
> 2.17.1
>
