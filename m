Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2807935D4FD
	for <lists+linux-pm@lfdr.de>; Tue, 13 Apr 2021 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbhDMBwg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Apr 2021 21:52:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:14309 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244390AbhDMBwd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Apr 2021 21:52:33 -0400
IronPort-SDR: pfcJcWkYQz/vewru/G+2jvGIoJbkISESsA9TGrG8RwSe1p3Nm0VcWlkrGyVNT10uXYlai7O4dT
 wEFhK9xJ/8Og==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="255640916"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="255640916"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:52:13 -0700
IronPort-SDR: yl/osd/QaAioqeQDjCAh4KcmGgKqK7FDq9vTFmaShOdoaHjKiv7d6KXYwUEXZ/VXMuXXD7TgZq
 UdDAvoBPt4jw==
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="424047406"
Received: from luli1-mobl1.ccr.corp.intel.com ([10.255.29.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 18:52:11 -0700
Message-ID: <92cf1421e5f0642980b2daed81e57f18ffee40ba.camel@intel.com>
Subject: Re: [PATCH V2] thermal: intel: introduce tcc cooling driver
From:   Zhang Rui <rui.zhang@intel.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        srinivas.pandruvada@linux.intel.com
Date:   Tue, 13 Apr 2021 09:52:08 +0800
In-Reply-To: <CAAYoRsVJt72GacaZ-ZqvHrOcVK+jLRZG5KQJiP1hsA5eoDDhWA@mail.gmail.com>
References: <20210411142613.9584-1-rui.zhang@intel.com>
         <CAAYoRsVJt72GacaZ-ZqvHrOcVK+jLRZG5KQJiP1hsA5eoDDhWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 2021-04-11 at 10:12 -0700, Doug Smythies wrote:
> Hi Rui,
> Thank you for your V2.
> 
> On Sun, Apr 11, 2021 at 7:15 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > On Intel processors, the core frequency can be reduced below OS
> > request,
> > when the current temperature reaches the TCC (Thermal Control
> > Circuit)
> > activation temperature.
> > 
> > The default TCC activation temperature is specified by
> > MSR_IA32_TEMPERATURE_TARGET. However, it can be adjusted by
> > specifying an
> > offset in degrees C, using the TCC Offset bits in the same MSR
> > register.
> > 
> > This patch introduces a cooling devices driver that utilizes the
> > TCC
> > Offset feature. The bigger the current cooling state is, the lower
> > the
> > effective TCC activation temperature is, so that the processors can
> > be
> > throttled earlier before system critical overheats.
> > 
> > Note that, on different platforms, the behavior might be different
> > on
> > how fast the setting takes effect, and how much the CPU frequency
> > is
> > reduced.
> > 
> > This patch has been tested on a KBL mobile platform.
> 
> V1 was also tested on what I think was a Coffee Lake (i5-9600K)

I didn't include this in patch V3 because Coffee Lake is not supported
by this version of patch. Please feel free to send a patch on top if
you have confirmed that it works.

> This V2 was tested on a Comet Lake (i5-10600K), with an additional
> match patch added. See below.
> 
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Tested by: Doug Smythies <dsmythies@telus.net>
> 
And thanks for your test.

-rui
> > ---
> > V2:
> >   Add a note in both Kconfig description and changelog, to clarify
> > that
> >   the behavior might not be consistent cross platforms.
> > ---
> >  drivers/thermal/intel/Kconfig             |  11 ++
> >  drivers/thermal/intel/Makefile            |   1 +
> >  drivers/thermal/intel/intel_tcc_cooling.c | 128
> > ++++++++++++++++++++++
> >  3 files changed, 140 insertions(+)
> >  create mode 100644 drivers/thermal/intel/intel_tcc_cooling.c
> > 
> > diff --git a/drivers/thermal/intel/Kconfig
> > b/drivers/thermal/intel/Kconfig
> > index ce4f59213c7a..e4299ca3423c 100644
> > --- a/drivers/thermal/intel/Kconfig
> > +++ b/drivers/thermal/intel/Kconfig
> > @@ -79,3 +79,14 @@ config INTEL_PCH_THERMAL
> >           Enable this to support thermal reporting on certain intel
> > PCHs.
> >           Thermal reporting device will provide temperature
> > reading,
> >           programmable trip points and other information.
> > +
> > +config INTEL_TCC_COOLING
> > +       tristate "Intel TCC offset cooling Driver"
> > +       depends on X86
> > +       help
> > +         Enable this to support system cooling by adjusting the
> > effective TCC
> > +         activation temperature via the TCC Offset register, which
> > is widely
> > +         supported on modern Intel platforms.
> > +         Note that, on different platforms, the behavior might be
> > different
> > +         on how fast the setting takes effect, and how much the
> > CPU frequency
> > +         is reduced.
> > diff --git a/drivers/thermal/intel/Makefile
> > b/drivers/thermal/intel/Makefile
> > index ff2ad30ef397..5ff2afa388f7 100644
> > --- a/drivers/thermal/intel/Makefile
> > +++ b/drivers/thermal/intel/Makefile
> > @@ -10,4 +10,5 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL) +=
> > intel_quark_dts_thermal.o
> >  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
> >  obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
> >  obj-$(CONFIG_INTEL_PCH_THERMAL)        += intel_pch_thermal.o
> > +obj-$(CONFIG_INTEL_TCC_COOLING)        += intel_tcc_cooling.o
> >  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> > diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
> > b/drivers/thermal/intel/intel_tcc_cooling.c
> > new file mode 100644
> > index 000000000000..aa6bbb9ba898
> > --- /dev/null
> > +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * cooling device driver that activates the processor throttling
> > by
> > + * programming the TCC Offset register.
> > + * Copyright (c) 2021, Intel Corporation.
> > + */
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/thermal.h>
> > +#include <asm/cpu_device_id.h>
> > +
> > +#define TCC_SHIFT 24
> > +#define TCC_MASK       (0x3fULL<<24)
> > +#define TCC_PROGRAMMABLE       BIT(30)
> > +
> > +static struct thermal_cooling_device *tcc_cdev;
> > +
> > +static int tcc_get_max_state(struct thermal_cooling_device *cdev,
> > unsigned long
> > +                            *state)
> > +{
> > +       *state = TCC_MASK >> TCC_SHIFT;
> > +       return 0;
> > +}
> > +
> > +static int tcc_offset_update(int tcc)
> > +{
> > +       u64 val;
> > +       int err;
> > +
> > +       err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> > +       if (err)
> > +               return err;
> > +
> > +       val &= ~TCC_MASK;
> > +       val |= tcc << TCC_SHIFT;
> > +
> > +       err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> > +       if (err)
> > +               return err;
> > +
> > +       return 0;
> > +}
> > +
> > +static int tcc_get_cur_state(struct thermal_cooling_device *cdev,
> > unsigned long
> > +                            *state)
> > +{
> > +       u64 val;
> > +       int err;
> > +
> > +       err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> > +       if (err)
> > +               return err;
> > +
> > +       *state = (val & TCC_MASK) >> TCC_SHIFT;
> > +       return 0;
> > +}
> > +
> > +static int tcc_set_cur_state(struct thermal_cooling_device *cdev,
> > unsigned long
> > +                            state)
> > +{
> > +       return tcc_offset_update(state);
> > +}
> > +
> > +static const struct thermal_cooling_device_ops tcc_cooling_ops = {
> > +       .get_max_state = tcc_get_max_state,
> > +       .get_cur_state = tcc_get_cur_state,
> > +       .set_cur_state = tcc_set_cur_state,
> > +};
> > +
> > +static const struct x86_cpu_id tcc_ids[] __initconst = {
> > +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> > +       {}
> 
> Suggest the starting supported list be expanded. I only did what I
> had to:
> 
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
> b/drivers/thermal/intel/intel_tcc_cooling.c
> index aa6bbb9ba898..8ec10d55d421 100644
> --- a/drivers/thermal/intel/intel_tcc_cooling.c
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -78,6 +78,7 @@ static const struct x86_cpu_id tcc_ids[]
> __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
>         X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
>         {}
>  };
> 
> 
> > +};
> > +
> > +MODULE_DEVICE_TABLE(x86cpu, tcc_ids);
> > +
> > +static int __init tcc_cooling_init(void)
> > +{
> > +       int ret;
> > +       u64 val;
> > +       const struct x86_cpu_id *id;
> > +
> > +       int err;
> > +
> > +       id = x86_match_cpu(tcc_ids);
> > +       if (!id)
> > +               return -ENODEV;
> > +
> > +       err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!(val & TCC_PROGRAMMABLE))
> > +               return -ENODEV;
> > +
> > +       pr_info("Programmable TCC Offset detected\n");
> > +
> > +       tcc_cdev =
> > +           thermal_cooling_device_register("TCC Offset", NULL,
> > +                                           &tcc_cooling_ops);
> > +       if (IS_ERR(tcc_cdev)) {
> > +               ret = PTR_ERR(tcc_cdev);
> > +               return ret;
> > +       }
> > +       return 0;
> > +}
> > +
> > +module_init(tcc_cooling_init)
> > +
> > +static void __exit tcc_cooling_exit(void)
> > +{
> > +       thermal_cooling_device_unregister(tcc_cdev);
> > +}
> > +
> > +module_exit(tcc_cooling_exit)
> > +
> > +MODULE_DESCRIPTION("TCC offset cooling device Driver");
> > +MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
> > 

