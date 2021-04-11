Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1537A35B64B
	for <lists+linux-pm@lfdr.de>; Sun, 11 Apr 2021 19:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbhDKRNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Apr 2021 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKRNQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Apr 2021 13:13:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABDC061574
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 10:12:58 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id c3so2892634ils.5
        for <linux-pm@vger.kernel.org>; Sun, 11 Apr 2021 10:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WF8P/Ds5ZtJ0kGaXRVdZuuO5dzrTSfPt2r496P39yY8=;
        b=QxjYUVYj6U3+PUxb8npc11DhfsH2Bfs7NpVDXry2FCp1sgLUIK5lf/pMKzI6rOB1UN
         8alqY40znUlAajxw1TBEmnH3kw/IaDmYoMXoeDdHUC2hsxIM+4nPB5SeHtG6qFkqtVRb
         a6X60MzgvcVayKcgD7o/Dr74bEu9puXlvMbR37SaM69WgTFaJcSY3oTDjTLcwc0ix3vc
         bBOxiaJOf8+SHlwpUmvZE3T0MzpiZSfP5L0tGBPq3uF8oeQ7Rs3zi1YujGl07Bnhdkye
         UP4+fMe74JWkM/fmwCsWnwnAkoY4amDs/KURXX2JXM81ju0qDoPQO4kyhUx5n4TywV0B
         GCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WF8P/Ds5ZtJ0kGaXRVdZuuO5dzrTSfPt2r496P39yY8=;
        b=WPlEtymoquE7RHVVrq2iEqUcPUt1hPQ9+/jTYl3CaULDx2VoxUa1tuBH6KOZKUwajl
         KfIhfbaPDZIewSHJxWzv/D61DTX5mwDn3sm3koKqvjr2XRUwy7/LxzKxns7jBez2gYdq
         aRXiNPi7T+u2lf+s90sw9WqS6vnOEkLUfoqCt6qo56Ytli2jPTRRYTKMu1c8IItUcIA7
         88J/K14Or8aqYg9UygTMAd1dHtzc0kmxlHsmqNcSGu3eVGtgQO4gOCepPVlLUWnPfgaN
         krF5sE8K7zflPK6OyBJvLfc8wmySi/QQhFvmRb0F9NJslyEMhziR0pbeICrXUqzThEeb
         p/FA==
X-Gm-Message-State: AOAM533yxju8NVC1slKY7QOc2CBw8KUKkdw1HDUOMsehqBBqhVXZLLo4
        M37Pjjc1p7eP2NRms/xNteSyJumu7Uwy+Ag+bSYS7g==
X-Google-Smtp-Source: ABdhPJyRu9tyuXP8ZbORrHN9YS+Sbz96r43b9/Pqy4XZyyh0mYmcoAjOjUtN+01vhZ4zKN5mVwuJ/F5M3SOXCP7HSX0=
X-Received: by 2002:a05:6e02:1a81:: with SMTP id k1mr10095682ilv.18.1618161177845;
 Sun, 11 Apr 2021 10:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210411142613.9584-1-rui.zhang@intel.com>
In-Reply-To: <20210411142613.9584-1-rui.zhang@intel.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sun, 11 Apr 2021 10:12:47 -0700
Message-ID: <CAAYoRsVJt72GacaZ-ZqvHrOcVK+jLRZG5KQJiP1hsA5eoDDhWA@mail.gmail.com>
Subject: Re: [PATCH V2] thermal: intel: introduce tcc cooling driver
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        srinivas.pandruvada@linux.intel.com,
        dsmythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rui,
Thank you for your V2.

On Sun, Apr 11, 2021 at 7:15 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On Intel processors, the core frequency can be reduced below OS request,
> when the current temperature reaches the TCC (Thermal Control Circuit)
> activation temperature.
>
> The default TCC activation temperature is specified by
> MSR_IA32_TEMPERATURE_TARGET. However, it can be adjusted by specifying an
> offset in degrees C, using the TCC Offset bits in the same MSR register.
>
> This patch introduces a cooling devices driver that utilizes the TCC
> Offset feature. The bigger the current cooling state is, the lower the
> effective TCC activation temperature is, so that the processors can be
> throttled earlier before system critical overheats.
>
> Note that, on different platforms, the behavior might be different on
> how fast the setting takes effect, and how much the CPU frequency is
> reduced.
>
> This patch has been tested on a KBL mobile platform.

V1 was also tested on what I think was a Coffee Lake (i5-9600K)
This V2 was tested on a Comet Lake (i5-10600K), with an additional
match patch added. See below.

>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Tested by: Doug Smythies <dsmythies@telus.net>

> ---
> V2:
>   Add a note in both Kconfig description and changelog, to clarify that
>   the behavior might not be consistent cross platforms.
> ---
>  drivers/thermal/intel/Kconfig             |  11 ++
>  drivers/thermal/intel/Makefile            |   1 +
>  drivers/thermal/intel/intel_tcc_cooling.c | 128 ++++++++++++++++++++++
>  3 files changed, 140 insertions(+)
>  create mode 100644 drivers/thermal/intel/intel_tcc_cooling.c
>
> diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
> index ce4f59213c7a..e4299ca3423c 100644
> --- a/drivers/thermal/intel/Kconfig
> +++ b/drivers/thermal/intel/Kconfig
> @@ -79,3 +79,14 @@ config INTEL_PCH_THERMAL
>           Enable this to support thermal reporting on certain intel PCHs.
>           Thermal reporting device will provide temperature reading,
>           programmable trip points and other information.
> +
> +config INTEL_TCC_COOLING
> +       tristate "Intel TCC offset cooling Driver"
> +       depends on X86
> +       help
> +         Enable this to support system cooling by adjusting the effective TCC
> +         activation temperature via the TCC Offset register, which is widely
> +         supported on modern Intel platforms.
> +         Note that, on different platforms, the behavior might be different
> +         on how fast the setting takes effect, and how much the CPU frequency
> +         is reduced.
> diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
> index ff2ad30ef397..5ff2afa388f7 100644
> --- a/drivers/thermal/intel/Makefile
> +++ b/drivers/thermal/intel/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL) += intel_quark_dts_thermal.o
>  obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
>  obj-$(CONFIG_INTEL_BXT_PMIC_THERMAL) += intel_bxt_pmic_thermal.o
>  obj-$(CONFIG_INTEL_PCH_THERMAL)        += intel_pch_thermal.o
> +obj-$(CONFIG_INTEL_TCC_COOLING)        += intel_tcc_cooling.o
>  obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
> diff --git a/drivers/thermal/intel/intel_tcc_cooling.c b/drivers/thermal/intel/intel_tcc_cooling.c
> new file mode 100644
> index 000000000000..aa6bbb9ba898
> --- /dev/null
> +++ b/drivers/thermal/intel/intel_tcc_cooling.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cooling device driver that activates the processor throttling by
> + * programming the TCC Offset register.
> + * Copyright (c) 2021, Intel Corporation.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/thermal.h>
> +#include <asm/cpu_device_id.h>
> +
> +#define TCC_SHIFT 24
> +#define TCC_MASK       (0x3fULL<<24)
> +#define TCC_PROGRAMMABLE       BIT(30)
> +
> +static struct thermal_cooling_device *tcc_cdev;
> +
> +static int tcc_get_max_state(struct thermal_cooling_device *cdev, unsigned long
> +                            *state)
> +{
> +       *state = TCC_MASK >> TCC_SHIFT;
> +       return 0;
> +}
> +
> +static int tcc_offset_update(int tcc)
> +{
> +       u64 val;
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> +       if (err)
> +               return err;
> +
> +       val &= ~TCC_MASK;
> +       val |= tcc << TCC_SHIFT;
> +
> +       err = wrmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, val);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int tcc_get_cur_state(struct thermal_cooling_device *cdev, unsigned long
> +                            *state)
> +{
> +       u64 val;
> +       int err;
> +
> +       err = rdmsrl_safe(MSR_IA32_TEMPERATURE_TARGET, &val);
> +       if (err)
> +               return err;
> +
> +       *state = (val & TCC_MASK) >> TCC_SHIFT;
> +       return 0;
> +}
> +
> +static int tcc_set_cur_state(struct thermal_cooling_device *cdev, unsigned long
> +                            state)
> +{
> +       return tcc_offset_update(state);
> +}
> +
> +static const struct thermal_cooling_device_ops tcc_cooling_ops = {
> +       .get_max_state = tcc_get_max_state,
> +       .get_cur_state = tcc_get_cur_state,
> +       .set_cur_state = tcc_set_cur_state,
> +};
> +
> +static const struct x86_cpu_id tcc_ids[] __initconst = {
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> +       {}

Suggest the starting supported list be expanded. I only did what I had to:

diff --git a/drivers/thermal/intel/intel_tcc_cooling.c
b/drivers/thermal/intel/intel_tcc_cooling.c
index aa6bbb9ba898..8ec10d55d421 100644
--- a/drivers/thermal/intel/intel_tcc_cooling.c
+++ b/drivers/thermal/intel/intel_tcc_cooling.c
@@ -78,6 +78,7 @@ static const struct x86_cpu_id tcc_ids[] __initconst = {
        X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L, NULL),
        X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
        X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
+       X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE, NULL),
        {}
 };


> +};
> +
> +MODULE_DEVICE_TABLE(x86cpu, tcc_ids);
> +
> +static int __init tcc_cooling_init(void)
> +{
> +       int ret;
> +       u64 val;
> +       const struct x86_cpu_id *id;
> +
> +       int err;
> +
> +       id = x86_match_cpu(tcc_ids);
> +       if (!id)
> +               return -ENODEV;
> +
> +       err = rdmsrl_safe(MSR_PLATFORM_INFO, &val);
> +       if (err)
> +               return err;
> +
> +       if (!(val & TCC_PROGRAMMABLE))
> +               return -ENODEV;
> +
> +       pr_info("Programmable TCC Offset detected\n");
> +
> +       tcc_cdev =
> +           thermal_cooling_device_register("TCC Offset", NULL,
> +                                           &tcc_cooling_ops);
> +       if (IS_ERR(tcc_cdev)) {
> +               ret = PTR_ERR(tcc_cdev);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +module_init(tcc_cooling_init)
> +
> +static void __exit tcc_cooling_exit(void)
> +{
> +       thermal_cooling_device_unregister(tcc_cdev);
> +}
> +
> +module_exit(tcc_cooling_exit)
> +
> +MODULE_DESCRIPTION("TCC offset cooling device Driver");
> +MODULE_AUTHOR("Zhang Rui <rui.zhang@intel.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.17.1
>
