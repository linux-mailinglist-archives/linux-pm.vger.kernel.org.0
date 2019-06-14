Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2445ED0
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfFNNrm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 09:47:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfFNNrm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jun 2019 09:47:42 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0C82173C;
        Fri, 14 Jun 2019 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560520060;
        bh=WFBozKxYqQEonoT4h0aSSk2Zmh1qoKLPSOxNH5ODZ9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FYatgmTAcCkPXky//dCZs0Trtr0rqG3p6svkCrePUqAi+M5Zzof+VnnjbQd4DR5cY
         F6fS1cw7CnN9t1nUhYjjU6/8V/qpntZ/Dz/qWbUpSz3c6X8Fpd6vLOVJH7cK+H2z6m
         hS0cPX/f5+oyqjr+ea1I1ByLWAJGXcHI4XIQdr8A=
Received: by mail-lf1-f54.google.com with SMTP id a25so1801070lfg.2;
        Fri, 14 Jun 2019 06:47:40 -0700 (PDT)
X-Gm-Message-State: APjAAAUML4FTNlvb5fXPUnkbZGqGCDJLRRKJ2cMxvns/7EhTQOzsT+We
        RZ/WqCO3UGTCLSnkr7MJQxjQCoHHdkoj9AbS0QU=
X-Google-Smtp-Source: APXvYqx2ZETgwnfahYusNzjsSqNLovsXo1qYbm72cWLYRguPHT5ZcoKjFKqSKIXCs8HuPhTbNDMgWwrAtYJVmJPaVGI=
X-Received: by 2002:ac2:4891:: with SMTP id x17mr12871311lfc.60.1560520058567;
 Fri, 14 Jun 2019 06:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
 <20190614095309.24100-1-l.luba@partner.samsung.com> <20190614095309.24100-9-l.luba@partner.samsung.com>
In-Reply-To: <20190614095309.24100-9-l.luba@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 14 Jun 2019 15:47:27 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdjXhfcNRL-XMS6K1jrUQoqoNHXGirjXoeoL4GyXzarpg@mail.gmail.com>
Message-ID: <CAJKOXPdjXhfcNRL-XMS6K1jrUQoqoNHXGirjXoeoL4GyXzarpg@mail.gmail.com>
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for Exynos5422
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> This patch adds driver for Exynos5422 Dynamic Memory Controller.
> The driver provides support for dynamic frequency and voltage scaling for
> DMC and DRAM. It supports changing timings of DRAM running with different
> frequency. There is also an algorithm to calculate timigns based on
> memory description provided in DT.
> The patch also contains needed MAINTAINERS file update.
>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  MAINTAINERS                             |    8 +
>  drivers/memory/samsung/Kconfig          |   17 +
>  drivers/memory/samsung/Makefile         |    1 +
>  drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
>  4 files changed, 1288 insertions(+)
>  create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..6ffccfd95351 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3470,6 +3470,14 @@ S:       Maintained
>  F:     drivers/devfreq/exynos-bus.c
>  F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>
> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
> +M:     Lukasz Luba <l.luba@partner.samsung.com>
> +L:     linux-pm@vger.kernel.org
> +L:     linux-samsung-soc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/memory/samsung/exynos5422-dmc.c
> +F:     Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
> +
>  BUSLOGIC SCSI DRIVER
>  M:     Khalid Aziz <khalid@gonehiking.org>
>  L:     linux-scsi@vger.kernel.org
> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
> index 79ce7ea58903..c93baa029654 100644
> --- a/drivers/memory/samsung/Kconfig
> +++ b/drivers/memory/samsung/Kconfig
> @@ -5,6 +5,23 @@ config SAMSUNG_MC
>           Support for the Memory Controller (MC) devices found on
>           Samsung Exynos SoCs.
>
> +config ARM_EXYNOS5422_DMC
> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
> +       depends on ARCH_EXYNOS
> +       select DDR
> +       select PM_DEVFREQ
> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +       select DEVFREQ_GOV_USERSPACE
> +       select PM_DEVFREQ_EVENT
> +       select PM_OPP
> +       help
> +         This adds driver for Exynos5422 DMC (Dynamic Memory Controller).
> +         The driver provides support for Dynamic Voltage and Frequency Scaling in
> +         DMC and DRAM. It also supports changing timings of DRAM running with
> +         different frequency. The timings are calculated based on DT memory
> +         information.
> +
> +
>  if SAMSUNG_MC
>
>  config EXYNOS_SROM
> diff --git a/drivers/memory/samsung/Makefile b/drivers/memory/samsung/Makefile
> index 00587be66211..4f6e4383bab7 100644
> --- a/drivers/memory/samsung/Makefile
> +++ b/drivers/memory/samsung/Makefile
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ARM_EXYNOS5422_DMC)       += exynos5422-dmc.o
>  obj-$(CONFIG_EXYNOS_SROM)      += exynos-srom.o
> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
> new file mode 100644
> index 000000000000..b397efe0da57
> --- /dev/null
> +++ b/drivers/memory/samsung/exynos5422-dmc.c
> @@ -0,0 +1,1262 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/devfreq-event.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <memory/jedec_ddr.h>
> +#include "../of_memory.h"
> +
> +#define EXYNOS5_DREXI_TIMINGAREF               (0x0030)
> +#define EXYNOS5_DREXI_TIMINGROW0               (0x0034)
> +#define EXYNOS5_DREXI_TIMINGDATA0              (0x0038)
> +#define EXYNOS5_DREXI_TIMINGPOWER0             (0x003C)
> +#define EXYNOS5_DREXI_TIMINGROW1               (0x00E4)
> +#define EXYNOS5_DREXI_TIMINGDATA1              (0x00E8)
> +#define EXYNOS5_DREXI_TIMINGPOWER1             (0x00EC)
> +#define CDREX_PAUSE                            (0x2091c)
> +#define CDREX_LPDDR3PHY_CON3                   (0x20a20)
> +#define EXYNOS5_TIMING_SET_SWI                 (1UL << 28)
> +#define USE_MX_MSPLL_TIMINGS                   (1)
> +#define USE_BPLL_TIMINGS                       (0)
> +#define EXYNOS5_AREF_NORMAL                    (0x2e)
> +
> +/**
> + * struct dmc_opp_table - Operating level desciption
> + *
> + * Covers frequency and voltage settings of the DMC operating mode.
> + */
> +struct dmc_opp_table {
> +       u32 freq_hz;
> +       u32 volt_uv;
> +};
> +
> +/**
> + * struct exynos5_dmc - main structure describing DMC device
> + *
> + * The main structure for the Dynamic Memory Controller which covers clocks,
> + * memory regions, HW information, parameters and current operating mode.
> + */
> +struct exynos5_dmc {
> +       struct device *dev;
> +       struct devfreq *df;
> +       struct devfreq_simple_ondemand_data gov_data;
> +       void __iomem *base_drexi0;
> +       void __iomem *base_drexi1;
> +       struct regmap *clk_regmap;
> +       struct mutex lock;
> +       unsigned long curr_rate;
> +       unsigned long curr_volt;
> +       unsigned long bypass_rate;
> +       struct dmc_opp_table *opp;
> +       struct dmc_opp_table opp_bypass;
> +       int opp_count;
> +       u32 timings_arr_size;
> +       u32 *timing_row;
> +       u32 *timing_data;
> +       u32 *timing_power;
> +       const struct lpddr3_timings *timings;
> +       const struct lpddr3_min_tck *min_tck;
> +       u32 bypass_timing_row;
> +       u32 bypass_timing_data;
> +       u32 bypass_timing_power;
> +       struct regulator *vdd_mif;
> +       struct clk *fout_spll;
> +       struct clk *fout_bpll;
> +       struct clk *mout_spll;
> +       struct clk *mout_bpll;
> +       struct clk *mout_mclk_cdrex;
> +       struct clk *mout_mx_mspll_ccore;
> +       struct clk *mx_mspll_ccore_phy;
> +       struct clk *mout_mx_mspll_ccore_phy;
> +       struct devfreq_event_dev **counter;
> +       int num_counters;
> +};
> +
> +#define TIMING_FIELD(t_name, t_bit_beg, t_bit_end) \
> +       { .name = t_name, .bit_beg = t_bit_beg, .bit_end = t_bit_end }
> +
> +#define TIMING_VAL(timing_array, id, t_val)                    \
> +({                                                             \
> +               u32 __val;                              \
> +               __val = t_val << timing_array[id].bit_beg;      \
> +               __val;                                          \
> +})
> +
> +#define TIMING_VAL2REG(timing, t_val)                  \
> +({                                                             \
> +               u32 __val;                              \
> +               __val = t_val << timing->bit_beg;       \
> +               __val;                                          \
> +})
> +
> +#define TIMING_REG2VAL(reg, timing)                    \

It seems that only some of these defines are used. Please clean them up.
You have also a lot of checkpatch --strict suggestions:
    CHECK: Macro argument 'reg' may be better as '(reg)' to avoid
precedence issues
which seems to be valid.

While at it please also fix few other --strict errors:
CHECK: Please don't use multiple blank lines
CHECK: Alignment should match open parenthesis
CHECK: Prefer using the BIT macro
CHECK: struct mutex definition without comment

Best regards,
Krzysztof
