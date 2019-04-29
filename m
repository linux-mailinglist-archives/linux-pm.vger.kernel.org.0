Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFFBE561
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2019 16:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbfD2Ovk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 10:51:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:34594 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728408AbfD2Ovk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 10:51:40 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190429145136euoutp012669da42b8a87180ab0f7ea3d38c521a~Z_YUuIK-t2461124611euoutp01C
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2019 14:51:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190429145136euoutp012669da42b8a87180ab0f7ea3d38c521a~Z_YUuIK-t2461124611euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556549496;
        bh=cIEkYf10LMbnM0T5Otye/IvlXOOB6jjjXja4PVJQOwk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qcpuPok4uyDPbdq3Sra1lG1KnTlz9rwte/cb2628UbYdGFfognw7aWkwlutxpUVTF
         O4ruRzxEz2oWXjmeI6oWjET4UUGbzFgpH8blwgt2dIFWHmvyMHjDt4km9G5d+yIufO
         aGnkJ/sAwdRbBRFbuBu5F/T5ni2DxBBlNQS0ssVQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190429145135eucas1p26164d14022a944b46f0be87d8a252362~Z_YUAloA30549805498eucas1p2I;
        Mon, 29 Apr 2019 14:51:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EE.1C.04298.77F07CC5; Mon, 29
        Apr 2019 15:51:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190429145135eucas1p2323cb523e9bc0137edd4d0532d9e1257~Z_YTSpyH10549805498eucas1p2H;
        Mon, 29 Apr 2019 14:51:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190429145134eusmtrp2c4449b9df88abf284606d343d78a3ffb~Z_YTEcKbn2982929829eusmtrp2J;
        Mon, 29 Apr 2019 14:51:34 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-78-5cc70f77d17b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.A3.04146.67F07CC5; Mon, 29
        Apr 2019 15:51:34 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190429145133eusmtip1120f92ffd21ed40de29a53de415d52a2~Z_YSMwMCH0684406844eusmtip1W;
        Mon, 29 Apr 2019 14:51:33 +0000 (GMT)
Subject: Re: [PATCH v6 07/10] drivers: memory: add DMC driver for Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <4c955c85-4f36-ff96-cbcd-f97c60c519a3@partner.samsung.com>
Date:   Mon, 29 Apr 2019 16:51:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcXtw4RZph=qABJfeu-hPL=DLMt3dZs0C_yn+FeOgpp-g@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0yNcRjH/c57OW9H5/h1Qs+kbO9cWxKL/TZmLJd35g/Mxmjj0Cumc3De
        LigcWUU6hBwcJbIp0Tpd1t0t6VQo91rHPcZKNo5qhuLtDf332ff5fvc83+3hKH0nM4bbYooS
        zSZDJM9q6NK6701TY0c4w4J/vBlPCk8XMKTl2weGZNU2MeTKl3ZETjRmqsi9w0ZytL2TIs3N
        DjW5n/BJTR5XZrDEba1F5HTzdRXJr32hJq79uSy5/SmZITeeLCGuHzrSU/8WzdMLPd3HaeGs
        5SEtVNhfqIWivEOsYD3wmRWOlOQhofhunOAu8l/GrdHMCRcjt8SI5mlz12s229L76e0v6+md
        1/uSGAt6kkalIA8OcAiU9yfTKUjD6XEugstnf7LyQI+/IXB2eCvsRtCWzP8LOG6qlEAOghzb
        88FAFwJHzwB746XQUdwywCPxFGj51cvIAQoX0lBWXqlOQRzH4iAoz9she7R4EWS6WxiZaTwB
        cqotAzwKr4ZXdQ5G8XhBw5l3tMweeDmkt6WqZaawD7S9y1IpPA7KujIoeRfgMxzklnaplasX
        wNOkRlZhb+hwlgzqY6G/QgkDlsBivYAUjof2o5mDntlw2/mQkW+m/pQpqJymyPMhsSBfJcuA
        ddDa5aWcoIPjpacoRdbCwSS94p4MJakPBheNhpyrNnUa4u1DitmHlLEPKWP/v/c8ovOQjxgt
        GSNEabpJjA2SDEYp2hQRtHGbsQj9ecG7fc6v5aj70YYahDnEe2qFz3VhesYQI+0y1iDgKH6k
        VnDeCdNrww27dovmbevM0ZGiVIN8OZr30cYNe71WjyMMUeJWUdwumv9OVZzHGAvKZscZLwbv
        CWgK9juQpQt3TQ2ZtSnwWFXIyhjP2L1avuDGvVV+w/tG1IY2Bb5ZscN0KXRrfFHaDN1CY1Ti
        kbd2Kbs4vZcK1TT8vGVbktrqmpRRPSPh3M6Vkfv8rEkn38e5J3YvjuZjbdews6ozMH5mWesD
        fw+r/50GT/f7Z18++rocPC1tNkwPoMyS4Tcvnrf2fgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42I5/e/4Xd0y/uMxBos+6VlsnLGe1eL6l+es
        FvOPnGO1WP3xMaPF5FNzmSzOdOda9D9+zWxx/vwGdouzTW/YLS7vmsNm8bn3CKPFjPP7mCzW
        HrnLbnG7cQWbxeE37awW+694Wdz+zWfx7cQjRgchj29fJ7F4zG64yOKxc9Zddo9NqzrZPHqb
        37F59G1Zxeix+XS1x+dNcgEcUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK
        +nY2Kak5mWWpRfp2CXoZ06b8Zym4d4KlYt+/NtYGxisTmLsYOTkkBEwkdmw4wARiCwksZZSY
        8VIBIi4mMWnfdnYIW1jiz7UuNoia14wSk0+bgtjCAj4SrzZfB4uLCGhKXP/7nbWLkYuDWWAj
        i8TFV71MII6QwDImiZ5/q4AyHBxsAnoSO1YVgjTwCrhJzP18nRXEZhFQlVi+pwHMFhWIkDjz
        fgULRI2gxMmZT8BsToFAiSm3esAOYhYwk5i3+SEzhC0ucevJfCYIW15i+9s5zBMYhWYhaZ+F
        pGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIz9bcd+bt7BeGlj8CFGAQ5G
        JR5ej3fHYoRYE8uKK3MPMUpwMCuJ8HocPxojxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnA
        tJRXEm9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoExc1HRxvlzJnfq
        b4s46u9g3mJ388rXaxpTe/xT0xX2SgnsmyPkL99Z/v7Yj7lRH3yrVI23PM+5WsTulhOqvcrz
        gHDevK+n20OuZ8WdYb2keN/zYk1+w4N7S1Yxf+/fxvlEeUbY3S2uVhy6Gy3e9POE2LZtY4+P
        efRFfP0sqfvZRzU3vVm64Vq1EktxRqKhFnNRcSIAUIUQWRMDAAA=
X-CMS-MailID: 20190429145135eucas1p2323cb523e9bc0137edd4d0532d9e1257
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190419141949eucas1p2a3ca13166210b6bc5741808055650e04
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190419141949eucas1p2a3ca13166210b6bc5741808055650e04
References: <CGME20190419141949eucas1p2a3ca13166210b6bc5741808055650e04@eucas1p2.samsung.com>
        <1555683568-20882-1-git-send-email-l.luba@partner.samsung.com>
        <1555683568-20882-8-git-send-email-l.luba@partner.samsung.com>
        <CAJKOXPcXtw4RZph=qABJfeu-hPL=DLMt3dZs0C_yn+FeOgpp-g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 4/23/19 1:27 PM, Krzysztof Kozlowski wrote:
> On Fri, 19 Apr 2019 at 16:19, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds driver for Exynos5422 Dynamic Memory Controller.
>> The driver provides support for dynamic frequency and voltage scaling for
>> DMC and DRAM. It supports changing timings of DRAM running with different
>> frequency. There is also an algorithm to calculate timigns based on
>> memory description provided in DT.
>> The patch also contains needed MAINTAINERS file update.
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   MAINTAINERS                             |    8 +
>>   drivers/memory/samsung/Kconfig          |   17 +
>>   drivers/memory/samsung/Makefile         |    1 +
>>   drivers/memory/samsung/exynos5422-dmc.c | 1793 +++++++++++++++++++++++++++++++
>>   4 files changed, 1819 insertions(+)
>>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1ba4b9b..07e257d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3395,6 +3395,14 @@ S:       Maintained
>>   F:     drivers/devfreq/exynos-bus.c
>>   F:     Documentation/devicetree/bindings/devfreq/exynos-bus.txt
>>
>> +DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
>> +M:     Lukasz Luba <l.luba@partner.samsung.com>
>> +L:     linux-pm@vger.kernel.org
>> +L:     linux-samsung-soc@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/memory/samsung/exynos5422-dmc.c
>> +F:     Documentation/devicetree/bindings/memory-controllers/exynos5422-dmc.txt
>> +
>>   BUSLOGIC SCSI DRIVER
>>   M:     Khalid Aziz <khalid@gonehiking.org>
>>   L:     linux-scsi@vger.kernel.org
>> diff --git a/drivers/memory/samsung/Kconfig b/drivers/memory/samsung/Kconfig
>> index 79ce7ea..202972b 100644
>> --- a/drivers/memory/samsung/Kconfig
>> +++ b/drivers/memory/samsung/Kconfig
>> @@ -5,6 +5,23 @@ config SAMSUNG_MC
>>            Support for the Memory Controller (MC) devices found on
>>            Samsung Exynos SoCs.
>>
>> +config ARM_EXYNOS5422_DMC
>> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
>> +       depends on ARCH_EXYNOS || COMPILE_TEST
>> +       select DDR
>> +       select PM_DEVFREQ
>> +       select DEVFREQ_GOV_SIMPLE_ONDEMAND
>> +       select DEVFREQ_GOV_USERSPACE
>> +       select PM_DEVFREQ_EVENT
>> +       select PM_OPP
>> +       help
>> +         This adds driver for Exynos5422 DMC (Dynamic Memory Controller).
>> +         The driver provides support for Dynamic Voltage and Frequency Scaling in
>> +         DMC and DRAM. It also supports changing timings of DRAM running with
>> +         different frequency. The timings are calculated based on DT memory
>> +         information.
>> +
>> +
>>   if SAMSUNG_MC
>>
>>   config EXYNOS_SROM
>> diff --git a/drivers/memory/samsung/Makefile b/drivers/memory/samsung/Makefile
>> index 00587be..4f6e438 100644
>> --- a/drivers/memory/samsung/Makefile
>> +++ b/drivers/memory/samsung/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_ARM_EXYNOS5422_DMC)       += exynos5422-dmc.o
>>   obj-$(CONFIG_EXYNOS_SROM)      += exynos-srom.o
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> new file mode 100644
>> index 0000000..fa4cd4c
>> --- /dev/null
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -0,0 +1,1793 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/delay.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/devfreq-event.h>
>> +#include <linux/device.h>
>> +#include <linux/export.h>
> 
> Do you use it?
Good point, I have deleted some code but forgot to check includes.
> 
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/seq_file.h>
>> +#include <linux/slab.h>
>> +#include <memory/jedec_ddr.h>
>> +#include "../of_memory.h"
>> +
>> +#define EXYNOS5_DREXI_TIMINGAREF               (0x0030)
>> +#define EXYNOS5_DREXI_TIMINGROW0               (0x0034)
>> +#define EXYNOS5_DREXI_TIMINGDATA0              (0x0038)
>> +#define EXYNOS5_DREXI_TIMINGPOWER0             (0x003C)
>> +#define EXYNOS5_DREXI_TIMINGROW1               (0x00E4)
>> +#define EXYNOS5_DREXI_TIMINGDATA1              (0x00E8)
>> +#define EXYNOS5_DREXI_TIMINGPOWER1             (0x00EC)
>> +#define CDREX_PAUSE                            (0x91c)
>> +#define CDREX_LPDDR3PHY_CON3                   (0xa20)
>> +#define EXYNOS5_TIMING_SET_SWI                  (1UL << 28)
>> +#define USE_MX_MSPLL_TIMINGS                   (1)
>> +#define USE_BPLL_TIMINGS                       (0)
>> +
>> +#define EXYNOS5_AREF_NORMAL                    (0x2e)
>> +
>> +#define IS_MEM_2GB(val) \
>> +       (                                               \
>> +        (((val) & 0xf0) & 0x20) ? 1 :                  \
>> +               (((val) & 0xf0) & 0x30) ? 1 : 0         \
>> +       )
>> +
>> +#define EXYNOS5_POP_OPTIONS(val)       (((val >> 4) & 0x3UL) << 4)
>> +#define EXYNOS5_DDR_TYPE(val)          (((val >> 14) & 0x1UL))
> 
> I would prefer to split out this and code related to chipid to chipid
> driver. Sylwester was adding similar parts for ASV so please unify it
> consistently. IOW, if you need data from chipid I would prefer to get
> it from chipid driver. This way we keep given feature only in one
> driver - less code duplication, less logic spread all over, no need to
> map the same region in multiple drivers.
Right, I have talked with Sylwester and I will align to the common code.
It will use regmap to access the register. In DT there will be phandle
to the 'chipid' node in memory-controller.
> 
>> +
>> +#define EXYNOS5_CHIP_PROD_ID           (0)
>> +#define EXYNOS5_CHIP_PKG_ID            (4)
>> +
>> +#define PPMU_PMCNT_CONST_RATIO_MUL     15
>> +#define PPMU_PMCNT_CONST_RATIO_DIV     10
>> +
>> +#define AXI_BUS_WIDTH_BYTES (128 >> 3)
>> +
>> +/**
>> + * enum dmc_slot_id - An enum with slots in DMC
> 
> The comment copies the name so please remove it. Comment should bring
> new information, not copy the source code.
Comment will be removed.
> 
>> + */
>> +enum dmc_slot_id {
>> +       DMC0_0,
>> +       DMC0_1,
>> +       DMC1_0,
>> +       DMC1_1,
>> +       DMC_SLOTS_END
>> +};
>> +
>> +/**
>> + * struct dmc_slot_info - Describes DMC's slot
>> + *
>> + * The structure holds DMC's slot name which is part of the device name
>> + * provided in DT. Each slot has particular share of the DMC bandwidth.
>> + * To abstract the model performance and values in performance counters,
>> + * fields 'ratio_mul' and 'ratio_div' are used in calculation algorithm
>> + * for each slot. Please check the corresponding function with the algorithm,
>> + * to see how these variables are used.
>> + */
>> +struct dmc_slot_info {
>> +       char *name;
>> +       int id;
>> +       int ratio_mul;
>> +       int ratio_div;
>> +};
>> +
>> +/**
>> + * struct dmc_opp_table - Operating level desciption
>> + *
>> + * Covers frequency and voltage settings of the DMC operating mode.
>> + */
>> +struct dmc_opp_table {
>> +       u32 freq_hz;
>> +       u32 volt_uv;
>> +};
>> +
>> +/**
>> + * struct exynos5_dmc - main structure describing DMC device
>> + *
>> + * The main structure for the Dynamic Memory Controller which covers clocks,
>> + * memory regions, HW information, parameters and current operating mode.
>> + */
>> +struct exynos5_dmc {
>> +       struct device *dev;
>> +       struct devfreq *df;
>> +       struct devfreq_simple_ondemand_data gov_data;
>> +       void __iomem *base_drexi0;
>> +       void __iomem *base_drexi1;
>> +       void __iomem *chip_id;
>> +       struct regmap *clk_regmap;
>> +       struct mutex lock;
>> +       unsigned long curr_rate;
>> +       unsigned long curr_volt;
>> +       unsigned long bypass_rate;
>> +       struct dmc_opp_table *opp;
>> +       struct dmc_opp_table opp_bypass;
>> +       int opp_count;
>> +       u32 timings_arr_size;
>> +       u32 *timing_row;
>> +       u32 *timing_data;
>> +       u32 *timing_power;
>> +       const struct lpddr3_timings *timings;
>> +       const struct lpddr3_min_tck *min_tck;
>> +       u32 bypass_timing_row;
>> +       u32 bypass_timing_data;
>> +       u32 bypass_timing_power;
>> +       unsigned int prod_rev;
>> +       unsigned int pkg_rev;
>> +       unsigned int mem_info;
>> +       struct regulator *vdd_mif;
>> +       struct clk *fout_spll;
>> +       struct clk *fout_bpll;
>> +       struct clk *mout_spll;
>> +       struct clk *mout_bpll;
>> +       struct clk *mout_mclk_cdrex;
>> +       struct clk *dout_clk2x_phy0;
>> +       struct clk *mout_mx_mspll_ccore;
>> +       struct clk *mx_mspll_ccore_phy;
>> +       struct clk *mout_mx_mspll_ccore_phy;
>> +       struct devfreq_event_dev **counter;
>> +       int num_counters;
>> +       bool counters_enabled;
>> +#ifdef CONFIG_DEBUG_FS
>> +       struct dentry *dbg_root;
>> +#endif
>> +};
>> +
>> +#define TIMING_FIELD(t_name, t_bit_beg, t_bit_end) \
>> +       { .name = t_name, .bit_beg = t_bit_beg, .bit_end = t_bit_end }
>> +
>> +#define TIMING_VAL(timing_array, id, t_val)                    \
>> +({                                                             \
>> +               u32 __val;                              \
>> +               __val = t_val << timing_array[id].bit_beg;      \
>> +               __val;                                          \
>> +})
>> +
>> +#define TIMING_VAL2REG(timing, t_val)                  \
>> +({                                                             \
>> +               u32 __val;                              \
>> +               __val = t_val << timing->bit_beg;       \
>> +               __val;                                          \
>> +})
>> +
>> +#define TIMING_REG2VAL(reg, timing)                    \
>> +({                                                             \
>> +               u32 __val;                              \
>> +               reg <<= (31 - timing->bit_end);         \
>> +               reg >>= (31 - timing->bit_end);         \
>> +               __val = reg >> timing->bit_beg; \
>> +               __val;                                          \
>> +})
>> +
>> +struct timing_reg {
>> +       char *name;
>> +       int bit_beg;
>> +       int bit_end;
>> +       unsigned int val;
>> +};
>> +
>> +static struct timing_reg timing_row[] = {
>> +       TIMING_FIELD("tRFC", 24, 31),
>> +       TIMING_FIELD("tRRD", 20, 23),
>> +       TIMING_FIELD("tRP", 16, 19),
>> +       TIMING_FIELD("tRCD", 12, 15),
>> +       TIMING_FIELD("tRC", 6, 11),
>> +       TIMING_FIELD("tRAS", 0, 5),
>> +};
>> +
>> +static struct timing_reg timing_data[] = {
>> +       TIMING_FIELD("tWTR", 28, 31),
>> +       TIMING_FIELD("tWR", 24, 27),
>> +       TIMING_FIELD("tRTP", 20, 23),
>> +       TIMING_FIELD("tW2W-C2C", 14, 14),
>> +       TIMING_FIELD("tR2R-C2C", 12, 12),
>> +       TIMING_FIELD("WL", 8, 11),
>> +       TIMING_FIELD("tDQSCK", 4, 7),
>> +       TIMING_FIELD("RL", 0, 3),
>> +};
>> +
>> +static struct timing_reg timing_power[] = {
> 
> All these looks like const. At least I could not see any writes to them.
They will be changed to const.
> 
>> +       TIMING_FIELD("tFAW", 26, 31),
>> +       TIMING_FIELD("tXSR", 16, 25),
>> +       TIMING_FIELD("tXP", 8, 15),
>> +       TIMING_FIELD("tCKE", 4, 7),
>> +       TIMING_FIELD("tMRD", 0, 3),
>> +};
>> +
>> +#define TIMING_COUNT (ARRAY_SIZE(timing_row) + ARRAY_SIZE(timing_data) + \
>> +                     ARRAY_SIZE(timing_power))
>> +
>> +/**
>> + * exynos5_counters_fname() - Macro generating function for event devices
>> + * @f:         function name suffix
>> + *
>> + * Macro which generates needed function for manipulation of event devices.
>> + * It aims to avoid code duplication relaying on similar prefix and function
>> + * parameters in the devfreq event device framework functions.
>> + */
>> +#define exynos5_counters_fname(f)                              \
>> +static int exynos5_counters_##f(struct exynos5_dmc *dmc)       \
>> +{                                                              \
>> +       int i, ret;                                             \
>> +                                                               \
>> +       for (i = 0; i < dmc->num_counters; i++) {               \
>> +               if (!dmc->counter[i])                           \
>> +                       continue;                               \
>> +               ret = devfreq_event_##f(dmc->counter[i]);       \
>> +               if (ret < 0)                                    \
>> +                       return ret;                             \
>> +       }                                                       \
>> +       return 0;                                               \
>> +}
>> +
>> +/* Declarations for the function generated by the macro above. */
>> +static int exynos5_counters_set_event(struct exynos5_dmc *dmc);
>> +static int exynos5_counters_enable_edev(struct exynos5_dmc *dmc);
>> +static int exynos5_counters_disable_edev(struct exynos5_dmc *dmc);
> 
> You save some lines of code but make it more difficult to follow and
> understand. I do not think it is worth the effort especially that
> duplicated code is not difficult... so I prefer duplication than
> obfuscation in such case. Define regular functions.
I agree, these functions will be written in normal way.
> 
>> +
>> +/* Generate needed functions for managing event device. */
>> +exynos5_counters_fname(set_event);
>> +exynos5_counters_fname(enable_edev);
>> +exynos5_counters_fname(disable_edev);
>> +
>> +/* Event names to DMC channel and slot with proper data count type */
>> +static const char *event_name[] = {
>> +       /* Counters for DMC0 slot 0 */
>> +       "ppmu-event0-dmc0_0",
>> +       "DMC0_0-Read",
>> +       "ppmu-event1-dmc0_0",
>> +       "DMC0_0-Write",
>> +       "ppmu-event3-dmc0_0",
>> +       "DMC0_0-Read+Write",
>> +       /* Counters for DMC0 slot 1 */
>> +       "ppmu-event0-dmc0_1",
>> +       "DMC0_1-Read",
>> +       "ppmu-event1-dmc0_1",
>> +       "DMC0_1-Write",
>> +       "ppmu-event3-dmc0_1",
>> +       "DMC0_1-Read+Write",
>> +       /* Counters for DMC1 slot 0 */
>> +       "ppmu-event0-dmc1_0",
>> +       "DMC1_0-Read",
>> +       "ppmu-event1-dmc1_0",
>> +       "DMC1_0-Write",
>> +       "ppmu-event3-dmc1_0",
>> +       "DMC1_0-Read+Write",
>> +       /* Counters for DMC1 slot 0 */
>> +       "ppmu-event0-dmc1_1",
>> +       "DMC1_1-Read",
>> +       "ppmu-event1-dmc1_1",
>> +       "DMC1_1-Write",
>> +       "ppmu-event3-dmc1_1",
>> +       "DMC1_1-Read+Write",
>> +};
>> +
>> +/**
>> + * find_target_freq_id() - Finds requested frequency in local DMC configuration
>> + * @dmc:       device for which the information is checked
>> + * @target_rate:       requested frequency in KHz
>> + *
>> + * Seeks in the local DMC driver structure for the requested frequency value
>> + * and returns index or error value.
>> + */
>> +static int find_target_freq_idx(struct exynos5_dmc *dmc,
>> +                               unsigned long target_rate)
>> +{
>> +       int i;
>> +
>> +       for (i = dmc->opp_count - 1; i >= 0; i--)
>> +               if (dmc->opp[i].freq_hz <= target_rate)
>> +                       return i;
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_chip_revision_settings() - Chooses proper DMC's configuration
>> + * @dmc:       device for which is going to be checked and configured
>> + *
>> + * Function checks the HW product information in order to choose proper
>> + * configuration for DMC frequency, voltage and DRAM timings.
>> + */
>> +static int exynos5_dmc_chip_revision_settings(struct exynos5_dmc *dmc)
>> +{
>> +       unsigned int val;
>> +
>> +       val = readl(dmc->chip_id + EXYNOS5_CHIP_PROD_ID);
>> +       dmc->prod_rev = val;
>> +
>> +       val = readl(dmc->chip_id + EXYNOS5_CHIP_PKG_ID);
>> +       dmc->pkg_rev = val;
>> +
>> +       dmc->mem_info = EXYNOS5_POP_OPTIONS(val);
>> +       dmc->mem_info |= EXYNOS5_DDR_TYPE(val);
>> +
>> +       if (!IS_MEM_2GB(dmc->mem_info)) {
>> +               dev_warn(dmc->dev, "DRAM memory type not supported\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_switch_timing_regs() - Changes bank register set for DRAM timings
>> + * @dmc:       device for which the new settings is going to be applied
>> + * @set:       boolean variable passing set value
>> + *
>> + * Changes the register set, which holds timing parameters.
>> + * There is two register sets: 0 and 1. The register set 0
>> + * is used in normal operation when the clock is provided from main PLL.
>> + * The bank register set 1 is used when the main PLL frequency is going to be
>> + * changed and the clock is taken from alternative, stable source.
>> + * This function switches between these banks according to the
>> + * currently used clock source.
>> + */
>> +static void exynos5_switch_timing_regs(struct exynos5_dmc *dmc, bool set)
>> +{
>> +       unsigned int reg;
>> +       int ret;
>> +
>> +       ret = regmap_read(dmc->clk_regmap, CDREX_LPDDR3PHY_CON3, &reg);
>> +
>> +       if (set)
>> +               reg |= EXYNOS5_TIMING_SET_SWI;
>> +       else
>> +               reg &= ~EXYNOS5_TIMING_SET_SWI;
>> +
>> +       regmap_write(dmc->clk_regmap, CDREX_LPDDR3PHY_CON3, reg);
>> +}
>> +
>> +/**
>> + * exynos5_init_freq_table() - Initialized PM OPP framework
>> + * @dev:       devfreq device for which the OPP table is going to be
>> + *             initialized
>> + * @dmc:       DMC device for which the frequencies are used for OPP init
>> + * @profile:   devfreq device's profile
>> + *
>> + * Populate the devfreq device's OPP table based on current frequency, voltage.
>> + */
>> +static int exynos5_init_freq_table(struct device *dev, struct exynos5_dmc *dmc,
>> +                                  struct devfreq_dev_profile *profile)
>> +{
>> +       int i, ret;
>> +       int idx;
>> +       unsigned long freq;
>> +
>> +       ret = dev_pm_opp_of_add_table(dev);
>> +       if (ret < 0) {
>> +               dev_err(dev, "Failed to get OPP table\n");
>> +               return ret;
>> +       }
>> +
>> +       dmc->opp_count = dev_pm_opp_get_opp_count(dev);
>> +
>> +       dmc->opp = devm_kmalloc_array(dmc->dev, dmc->opp_count,
>> +                                     sizeof(struct dmc_opp_table), GFP_KERNEL);
>> +       if (!dmc->opp)
>> +               goto err_opp;
>> +
>> +       idx = dmc->opp_count - 1;
>> +       for (i = 0, freq = ULONG_MAX; i < dmc->opp_count; i++, freq--) {
>> +               struct dev_pm_opp *opp;
>> +
>> +               opp = dev_pm_opp_find_freq_floor(dev, &freq);
>> +               if (IS_ERR(opp))
>> +                       goto err_free_tables;
>> +
>> +               dmc->opp[idx - i].freq_hz = freq;
>> +               dmc->opp[idx - i].volt_uv = dev_pm_opp_get_voltage(opp);
>> +
>> +               dev_pm_opp_put(opp);
>> +       }
>> +
>> +       return 0;
>> +
>> +err_free_tables:
>> +       kfree(dmc->opp);
>> +err_opp:
>> +       dev_pm_opp_of_remove_table(dev);
>> +
>> +       return -EINVAL;
>> +}
>> +
>> +/**
>> + * exynos5_set_bypass_dram_timings() - Low-level changes of the DRAM timings
>> + * @dmc:       device for which the new settings is going to be applied
>> + * @param:     DRAM parameters which passes timing data
>> + *
>> + * Low-level function for changing timings for DRAM memory clocking from
>> + * 'bypass' clock source (fixed frequency @400MHz).
>> + * It uses timing bank registers set 1.
>> + */
>> +static void exynos5_set_bypass_dram_timings(struct exynos5_dmc *dmc)
>> +{
>> +       writel(EXYNOS5_AREF_NORMAL,
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
>> +
>> +       writel(dmc->bypass_timing_row,
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW1);
>> +       writel(dmc->bypass_timing_row,
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW1);
>> +       writel(dmc->bypass_timing_data,
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA1);
>> +       writel(dmc->bypass_timing_data,
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA1);
>> +       writel(dmc->bypass_timing_power,
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER1);
>> +       writel(dmc->bypass_timing_power,
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER1);
>> +}
>> +
>> +/**
>> + * exynos5_dram_change_timings() - Low-level changes of the DRAM final timings
>> + * @dmc:       device for which the new settings is going to be applied
>> + * @target_rate:       target frequency of the DMC
>> + *
>> + * Low-level function for changing timings for DRAM memory operating from main
>> + * clock source (BPLL), which can have different frequencies. Thus, each
>> + * frequency must have corresponding timings register values in order to keep
>> + * the needed delays.
>> + * It uses timing bank registers set 0.
>> + */
>> +static int exynos5_dram_change_timings(struct exynos5_dmc *dmc,
>> +                                      unsigned long target_rate)
>> +{
>> +       int idx;
>> +
>> +       for (idx = dmc->opp_count - 1; idx >= 0; idx--)
>> +               if (dmc->opp[idx].freq_hz <= target_rate)
>> +                       break;
>> +
>> +       if (idx < 0)
>> +               return -EINVAL;
>> +
>> +       writel(EXYNOS5_AREF_NORMAL,
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGAREF);
>> +
>> +       writel(dmc->timing_row[idx],
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGROW0);
>> +       writel(dmc->timing_row[idx],
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGROW0);
>> +       writel(dmc->timing_data[idx],
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGDATA0);
>> +       writel(dmc->timing_data[idx],
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGDATA0);
>> +       writel(dmc->timing_power[idx],
>> +              dmc->base_drexi0 + EXYNOS5_DREXI_TIMINGPOWER0);
>> +       writel(dmc->timing_power[idx],
>> +              dmc->base_drexi1 + EXYNOS5_DREXI_TIMINGPOWER0);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_align_target_voltage() - Sets the final voltage for the DMC
>> + * @dmc:       device for which it is going to be set
>> + * @target_volt:       new voltage which is chosen to be final
>> + *
>> + * Function tries to align voltage to the safe level for 'normal' mode.
>> + * It checks the need of higher voltage and changes the value. The target
>> + * voltage might be lower that currently set and still the system will be
>> + * stable.
>> + */
>> +static int exynos5_dmc_align_target_voltage(struct exynos5_dmc *dmc,
>> +                                           unsigned long target_volt)
>> +{
>> +       int ret = 0;
>> +
>> +       if (dmc->curr_volt > target_volt) {
>> +               ret = regulator_set_voltage(dmc->vdd_mif, target_volt,
>> +                                           target_volt);
>> +               if (!ret)
>> +                       dmc->curr_volt = target_volt;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_align_bypass_voltage() - Sets the voltage for the DMC
>> + * @dmc:       device for which it is going to be set
>> + * @target_volt:       new voltage which is chosen to be final
>> + *
>> + * Function tries to align voltage to the safe level for the 'bypass' mode.
>> + * It checks the need of higher voltage and changes the value.
>> + * The target voltage must not be less than currently needed, because
>> + * for current frequency the device might become unstable.
>> + */
>> +static int exynos5_dmc_align_bypass_voltage(struct exynos5_dmc *dmc,
>> +                                           unsigned long target_volt)
>> +{
>> +       int ret = 0;
>> +       unsigned long bypass_volt = dmc->opp_bypass.volt_uv;
>> +
>> +       target_volt = max(bypass_volt, target_volt);
>> +
>> +       if (dmc->curr_volt >= target_volt)
>> +               return 0;
>> +
>> +       ret = regulator_set_voltage(dmc->vdd_mif, target_volt,
>> +                                   target_volt);
>> +       if (!ret)
>> +               dmc->curr_volt = target_volt;
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_align_bypass_dram_timings() - Chooses and sets DRAM timings
>> + * @dmc:       device for which it is going to be set
>> + * @target_rate:       new frequency which is chosen to be final
>> + *
>> + * Function changes the DRAM timings for the temporary 'bypass' mode.
>> + */
>> +static int exynos5_dmc_align_bypass_dram_timings(struct exynos5_dmc *dmc,
>> +                                                unsigned long target_rate)
>> +{
>> +       int idx = find_target_freq_idx(dmc, target_rate);
>> +
>> +       if (idx < 0)
>> +               return -EINVAL;
>> +
>> +       exynos5_set_bypass_dram_timings(dmc);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_switch_to_bypass_configuration() - Switching to temporary clock
>> + * @dmc:       DMC device for which the switching is going to happen
>> + * @target_rate:       new frequency which is going to be set as a final
>> + * @target_volt:       new voltage which is going to be set as a final
>> + *
>> + * Function configures DMC and clocks for operating in temporary 'bypass' mode.
>> + * This mode is used only temporary but if required, changes voltage and timings
>> + * for DRAM chips. It switches the main clock to stable clock source for the
>> + * period of the main PLL reconfiguration.
>> + */
>> +static int exynos5_dmc_switch_to_bypass_configuration(struct exynos5_dmc *dmc,
>> +                                  unsigned long target_rate,
>> +                                  unsigned long target_volt)
>> +{
>> +       int ret;
>> +
>> +       /*
>> +        * Having higher voltage for a particular frequency does not harm
>> +        * the chip. Use it for the temporary frequency change when one
>> +        * voltage manipulation might be avoided.
>> +        */
>> +       ret = exynos5_dmc_align_bypass_voltage(dmc, target_volt);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /*
>> +        * Longer delays for DRAM does not cause crash, the opposite does.
>> +        */
>> +       ret = exynos5_dmc_align_bypass_dram_timings(dmc, target_rate);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /*
>> +        * Delays are long enough, so use them for the new coming clock.
>> +        */
>> +       exynos5_switch_timing_regs(dmc, USE_MX_MSPLL_TIMINGS);
>> +
>> +       /*
>> +        * Voltage is set at least to a level needed for this frequency,
>> +        * so switching clock source is safe now.
>> +        */
>> +       clk_prepare_enable(dmc->fout_spll);
>> +       clk_prepare_enable(dmc->mout_spll);
>> +       clk_prepare_enable(dmc->mout_mx_mspll_ccore);
> 
> Move the clock handling to the same function when you disable them. It
> makes it easy to review whether you have unbalanced enable/disable.
OK, I will move it below this function call.
> 
>> +
>> +       ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_mx_mspll_ccore);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_change_freq_and_volt() - Changes voltage and frequency of the DMC
>> + * using safe procedure
>> + * @dmc:       device for which the frequency is going to be changed
>> + * @target_rate:       requested new frequency
>> + * @target_volt:       requested voltage which corresponds to the new frequency
>> + *
>> + * The DMC frequency change procedure requires a few steps.
>> + * The main requirement is to change the clock source in the clk mux
>> + * for the time of main clock PLL locking. The assumption is that the
>> + * alternative clock source set as parent is stable.
>> + * The second parent's clock frequency is fixed to 400MHz, it is named 'bypass'
>> + * clock. This requires alignment in DRAM timing parameters for the new
>> + * T-period. There is two bank sets for keeping DRAM
>> + * timings: set 0 and set 1. The set 0 is used when main clock source is
>> + * chosen. The 2nd set of regs is used for 'bypass' clock. Switching between
>> + * the two bank sets is part of the process.
>> + * The voltage must also be aligned to the minimum required level. There is
>> + * this intermediate step with switching to 'bypass' parent clock source.
>> + * if the old voltage is lower, it requires an increase of the voltage level.
>> + * The complexity of the voltage manipulation is hidden in low level function.
>> + * In this function there is last alignment of the voltage level at the end.
>> + */
>> +static int
>> +exynos5_dmc_change_freq_and_volt(struct exynos5_dmc *dmc,
>> +                                unsigned long target_rate,
>> +                                unsigned long target_volt)
>> +{
>> +       int ret;
>> +
>> +       ret = exynos5_dmc_switch_to_bypass_configuration(dmc, target_rate,
>> +                                                        target_volt);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* We are safe to increase the timings for current bypass frequency.
> 
> Start with /* alone.
OK
> 
>> +        * Thanks to this the settings we be ready for the upcoming clock source
>> +        * change.
>> +        */
>> +       exynos5_dram_change_timings(dmc, target_rate);
>> +
>> +       clk_set_rate(dmc->fout_bpll, target_rate);
>> +
>> +       exynos5_switch_timing_regs(dmc, USE_BPLL_TIMINGS);
>> +
>> +       ret = clk_set_parent(dmc->mout_mclk_cdrex, dmc->mout_bpll);
>> +       if (ret)
>> +               return ret;
>> +
>> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
>> +       clk_disable_unprepare(dmc->mout_spll);
>> +       clk_disable_unprepare(dmc->fout_spll);
>> +       /* Make sure if the voltage is not from 'bypass' settings and align to
>> +        * the right level for power efficiency.
>> +        */
>> +       ret = exynos5_dmc_align_target_voltage(dmc, target_volt);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_get_volt_freq() - Gets the frequency and voltage from the OPP
>> + * table.
>> + * @dev:       device for which the frequency is going to be changed
>> + * @freq:       requested frequency in KHz
>> + * @target_rate:       returned frequency which is the same or lower than
>> + *                     requested
>> + * @target_volt:       returned voltage which corresponds to the returned
>> + *                     frequency
>> + *
>> + * Function gets requested frequency and checks OPP framework for needed
>> + * frequency and voltage. It populates the values 'target_rate' and
>> + * 'target_volt' or returns error value when OPP framework fails.
>> + */
>> +static int exynos5_dmc_get_volt_freq(struct device *dev, unsigned long *freq,
>> +                                    unsigned long *target_rate,
>> +                                    unsigned long *target_volt, u32 flags)
>> +{
>> +       struct dev_pm_opp *opp;
>> +
>> +       opp = devfreq_recommended_opp(dev, freq, flags);
>> +       if (IS_ERR(opp))
>> +               return PTR_ERR(opp);
>> +
>> +       *target_rate = dev_pm_opp_get_freq(opp);
>> +       *target_volt = dev_pm_opp_get_voltage(opp);
>> +       dev_pm_opp_put(opp);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_target() - Function responsible for changing frequency of DMC
>> + * @dev:       device for which the frequency is going to be changed
>> + * @freq:      requested frequency in KHz
>> + * @flags:     flags provided for this frequency change request
>> + *
>> + * An entry function provided to the devfreq framework which provides frequency
>> + * change of the DMC. The function gets the possible rate from OPP table based
>> + * on requested frequency. It calls the next function responsible for the
>> + * frequency and voltage change. In case of failure, does not set 'curr_rate'
>> + * and returns error value to the framework.
>> + */
>> +static int exynos5_dmc_target(struct device *dev, unsigned long *freq,
>> +                             u32 flags)
>> +{
>> +       struct exynos5_dmc *dmc = dev_get_drvdata(dev);
>> +       unsigned long target_rate = 0;
>> +       unsigned long target_volt = 0;
>> +       int ret;
>> +
>> +       ret = exynos5_dmc_get_volt_freq(dev, freq, &target_rate, &target_volt,
>> +                                       flags);
>> +
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (target_rate == dmc->curr_rate)
>> +               return 0;
>> +
>> +       mutex_lock(&dmc->lock);
>> +
>> +       ret = exynos5_dmc_change_freq_and_volt(dmc, target_rate, target_volt);
>> +
>> +       if (ret) {
>> +               mutex_unlock(&dmc->lock);
>> +               return ret;
>> +       }
>> +
>> +       dmc->curr_rate = target_rate;
>> +
>> +       mutex_unlock(&dmc->lock);
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_counters_get() - Gets the performance counters values.
>> + * @dmc:       device for which the counters are going to be checked
>> + * @load_count:        variable which is populated with counter value
>> + * @total_count:       variable which is used as 'wall clock' reference
>> + *
>> + * Function which provides performance counters values. It sums up counters for
>> + * two DMC channels. The 'total_count' is used as a reference and max value.
>> + * The ratio 'load_count/total_count' shows the busy percentage [0%, 100%].
>> + */
>> +static int exynos5_counters_get(struct exynos5_dmc *dmc,
>> +                               unsigned long *load_count,
>> +                               unsigned long *total_count)
>> +{
>> +       unsigned long total = 0;
>> +       struct devfreq_event_data event;
>> +       int ret, i;
>> +
>> +       *load_count = 0;
>> +
>> +       /* Take into account only read+write counters, but stop all */
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               if (!dmc->counter[i])
>> +                       continue;
>> +
>> +               ret = devfreq_event_get_event(dmc->counter[i], &event);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               if (i % 3 != 2)
>> +                       continue;
>> +
>> +               *load_count += event.load_count;
>> +
>> +               if (total < event.total_count)
>> +                       total = event.total_count;
>> +       }
>> +
>> +       *total_count = total;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_get_status() - Read current DMC performance statistics.
>> + * @dev:       device for which the statistics are requested
>> + * @stat:      structure which has statistic fields
>> + *
>> + * Function reads the DMC performance counters and calculates 'busy_time'
>> + * and 'total_time'. To protect from overflow, the values are shifted right
>> + * by 10. After read out the counters are setup to count again.
>> + */
>> +static int exynos5_dmc_get_status(struct device *dev,
>> +                                 struct devfreq_dev_status *stat)
>> +{
>> +       struct exynos5_dmc *dmc = dev_get_drvdata(dev);
>> +       unsigned long load, total;
>> +       int ret;
>> +       bool cnt_en;
>> +
>> +       mutex_lock(&dmc->lock);
>> +       cnt_en = dmc->counters_enabled;
>> +       mutex_unlock(&dmc->lock);
>> +       if (!cnt_en) {
>> +               dev_warn(dev, "performance counters needed, but not present\n");
>> +               return -EAGAIN;
>> +       }
>> +
>> +       ret = exynos5_counters_get(dmc, &load, &total);
>> +       if (ret < 0)
>> +               return -EINVAL;
>> +
>> +       /* To protect from overflow in calculation ratios, divide by 1024 */
>> +       stat->busy_time = load >> 10;
>> +       stat->total_time = total >> 10;
>> +
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not set event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_get_cur_freq() - Function returns current DMC frequency
>> + * @dev:       device for which the framework checks operating frequency
>> + * @freq:      returned frequency value
>> + *
>> + * It returns the currently used frequency of the DMC. The real operating
>> + * frequency might be lower when the clock source value could not be divided
>> + * to the requested value.
>> + */
>> +static int exynos5_dmc_get_cur_freq(struct device *dev, unsigned long *freq)
>> +{
>> +       struct exynos5_dmc *dmc = dev_get_drvdata(dev);
>> +
>> +       mutex_lock(&dmc->lock);
>> +       *freq = dmc->curr_rate;
>> +       mutex_unlock(&dmc->lock);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_df_profile - Devfreq governor's profile structure
>> + *
>> + * It provides to the devfreq framework needed functions and polling period.
>> + */
>> +static struct devfreq_dev_profile exynos5_dmc_df_profile = {
>> +       .polling_ms = 500,
>> +       .target = exynos5_dmc_target,
>> +       .get_dev_status = exynos5_dmc_get_status,
>> +       .get_cur_freq = exynos5_dmc_get_cur_freq,
>> +};
>> +
>> +/**
>> + * exynos5_dmc_align_initial_frequency() - Align initial frequency value
>> + * @dmc:       device for which the frequency is going to be set
>> + * @bootloader_init_freq:      initial frequency set by the bootloader in KHz
>> + *
>> + * The initial bootloader frequency, which is present during boot, might be
>> + * different that supported frequency values in the driver. It is possible
>> + * due to different PLL settings or used PLL as a source.
>> + * This function provides the 'initial_freq' for the devfreq framework
>> + * statistics engine which supports only registered values. Thus, some alignment
>> + * must be made.
>> + */
>> +unsigned long
>> +exynos5_dmc_align_init_freq(struct exynos5_dmc *dmc,
>> +                           unsigned long bootloader_init_freq)
>> +{
>> +       unsigned long aligned_freq;
>> +       int idx;
>> +
>> +       idx = find_target_freq_idx(dmc, bootloader_init_freq);
>> +       if (idx >= 0)
>> +               aligned_freq = dmc->opp[idx].freq_hz;
>> +       else
>> +               aligned_freq = dmc->opp[dmc->opp_count - 1].freq_hz;
>> +
>> +       return aligned_freq;
>> +}
>> +
>> +/**
>> + * create_timings_aligned() - Create register values and align with standard
>> + * @dmc:       device for which the frequency is going to be set
>> + * @idx:       speed bin in the OPP table
>> + * @clk_period_ps:     the period of the clock, known as tCK
>> + *
>> + * The function calculates timings and creates a register value ready for
>> + * a frequency transition. The register contains a few timings. They are
>> + * shifted by a known offset. The timing value is calculated based on memory
>> + * specyfication: minimal time required and minimal cycles required.
>> + */
>> +static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
>> +                                 u32 *reg_timing_data, u32 *reg_timing_power,
>> +                                 u32 clk_period_ps)
>> +{
>> +       u32 val;
>> +       struct timing_reg *reg;
>> +
>> +       if (clk_period_ps == 0)
>> +               return -EINVAL;
>> +
>> +       *reg_timing_row = 0;
>> +       *reg_timing_data = 0;
>> +       *reg_timing_power = 0;
>> +
>> +       val = dmc->timings->tRFC / clk_period_ps;
>> +       val += dmc->timings->tRFC % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRFC);
>> +       reg = &timing_row[0];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRRD / clk_period_ps;
>> +       val += dmc->timings->tRRD % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRRD);
>> +       reg = &timing_row[1];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRPab / clk_period_ps;
>> +       val += dmc->timings->tRPab % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRPab);
>> +       reg = &timing_row[2];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRCD / clk_period_ps;
>> +       val += dmc->timings->tRCD % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRCD);
>> +       reg = &timing_row[3];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRC / clk_period_ps;
>> +       val += dmc->timings->tRC % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRC);
>> +       reg = &timing_row[4];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRAS / clk_period_ps;
>> +       val += dmc->timings->tRAS % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRAS);
>> +       reg = &timing_row[5];
>> +       *reg_timing_row |= TIMING_VAL2REG(reg, val);
>> +
>> +       /* data related timings */
>> +       val = dmc->timings->tWTR / clk_period_ps;
>> +       val += dmc->timings->tWTR % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tWTR);
>> +       reg = &timing_data[0];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tWR / clk_period_ps;
>> +       val += dmc->timings->tWR % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tWR);
>> +       reg = &timing_data[1];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRTP / clk_period_ps;
>> +       val += dmc->timings->tRTP % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRTP);
>> +       reg = &timing_data[2];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tW2W_C2C / clk_period_ps;
>> +       val += dmc->timings->tW2W_C2C % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tW2W_C2C);
>> +       reg = &timing_data[3];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tR2R_C2C / clk_period_ps;
>> +       val += dmc->timings->tR2R_C2C % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tR2R_C2C);
>> +       reg = &timing_data[4];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tWL / clk_period_ps;
>> +       val += dmc->timings->tWL % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tWL);
>> +       reg = &timing_data[5];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tDQSCK / clk_period_ps;
>> +       val += dmc->timings->tDQSCK % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tDQSCK);
>> +       reg = &timing_data[6];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tRL / clk_period_ps;
>> +       val += dmc->timings->tRL % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tRL);
>> +       reg = &timing_data[7];
>> +       *reg_timing_data |= TIMING_VAL2REG(reg, val);
>> +
>> +       /* power related timings */
>> +       val = dmc->timings->tFAW / clk_period_ps;
>> +       val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tXP);
>> +       reg = &timing_power[0];
>> +       *reg_timing_power |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tXSR / clk_period_ps;
>> +       val += dmc->timings->tXSR % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tXSR);
>> +       reg = &timing_power[1];
>> +       *reg_timing_power |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tXP / clk_period_ps;
>> +       val += dmc->timings->tXP % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tXP);
>> +       reg = &timing_power[2];
>> +       *reg_timing_power |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tCKE / clk_period_ps;
>> +       val += dmc->timings->tCKE % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tCKE);
>> +       reg = &timing_power[3];
>> +       *reg_timing_power |= TIMING_VAL2REG(reg, val);
>> +
>> +       val = dmc->timings->tMRD / clk_period_ps;
>> +       val += dmc->timings->tMRD % clk_period_ps ? 1 : 0;
>> +       val = max(val, dmc->min_tck->tMRD);
>> +       reg = &timing_power[4];
>> +       *reg_timing_power |= TIMING_VAL2REG(reg, val);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * of_get_dram_timings() - helper function for parsing DT settings for DRAM
>> + * @dmc:        device for which the frequency is going to be set
>> + *
>> + * The function parses DT entries with DRAM information.
>> + */
>> +static int of_get_dram_timings(struct exynos5_dmc *dmc)
>> +{
>> +       int ret = 0;
>> +       struct device_node *np;
>> +       int idx;
>> +       struct device_node *np_ddr;
> 
> Combine with previous definition.
The 'np' will be removed.
> 
>> +       u32 freq_mhz, clk_period_ps;
>> +
>> +       np_ddr = of_parse_phandle(dmc->dev->of_node, "device-handle", 0);
>> +       if (!np_ddr) {
>> +               dev_warn(dmc->dev, "could not find 'device-handle' in DT\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dmc->timing_row = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>> +                                            sizeof(u32), GFP_KERNEL);
>> +       if (!dmc->timing_row)
>> +               return -ENOMEM;
>> +
>> +       dmc->timing_data = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>> +                                             sizeof(u32), GFP_KERNEL);
>> +       if (!dmc->timing_data)
>> +               return -ENOMEM;
>> +
>> +       dmc->timing_power = devm_kmalloc_array(dmc->dev, TIMING_COUNT,
>> +                                              sizeof(u32), GFP_KERNEL);
>> +       if (!dmc->timing_power)
>> +               return -ENOMEM;
>> +
>> +       dmc->timings = of_lpddr3_get_ddr_timings(np_ddr, dmc->dev,
>> +                                                DDR_TYPE_LPDDR3,
>> +                                                &dmc->timings_arr_size);
>> +       if (!dmc->timings) {
>> +               of_node_put(np_ddr);
>> +               dev_warn(dmc->dev, "could not get timings from DT\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       dmc->min_tck = of_lpddr3_get_min_tck(np_ddr, dmc->dev);
>> +       if (!dmc->min_tck) {
>> +               of_node_put(np_ddr);
>> +               dev_warn(dmc->dev, "could not get tck from DT\n");
>> +               return -EINVAL;
>> +       }
>> +
>> +       /* Sorted array of OPPs with frequency ascending */
>> +       for (idx = 0; idx < dmc->opp_count; idx++) {
>> +               freq_mhz = dmc->opp[idx].freq_hz / 1000000;
>> +               clk_period_ps = 1000000 / freq_mhz;
>> +
>> +               ret = create_timings_aligned(dmc, &dmc->timing_row[idx],
>> +                                            &dmc->timing_data[idx],
>> +                                            &dmc->timing_power[idx],
>> +                                            clk_period_ps);
>> +       }
>> +
>> +       of_node_put(np);
> 
> This looks weird. You do not assign np... or I missed something.
Right, it should be 'np_ddr'. I will fix it.
> 
>> +
>> +       /* Take the highest frequency's timings as 'bypass' */
>> +       dmc->bypass_timing_row = dmc->timing_row[idx - 1];
>> +       dmc->bypass_timing_data = dmc->timing_data[idx - 1];
>> +       dmc->bypass_timing_power = dmc->timing_power[idx - 1];
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_init_clks() - Initialize clocks needed for DMC operation.
>> + * @dev:       device for which the clocks are setup
>> + * @dmc:       DMC structure containing needed fields
>> + *
>> + * Get the needed clocks defined in DT device, enable and set the right parents.
>> + * Read current frequency and initialize the initial rate for governor.
>> + */
>> +static int exynos5_dmc_init_clks(struct device *dev, struct exynos5_dmc *dmc)
>> +{
>> +       int ret;
>> +       unsigned long target_volt = 0;
>> +       unsigned long target_rate = 0;
>> +
>> +       dmc->fout_spll = devm_clk_get(dev, "fout_spll");
>> +       if (IS_ERR(dmc->fout_spll))
>> +               return PTR_ERR(dmc->fout_spll);
>> +
>> +       dmc->fout_bpll = devm_clk_get(dev, "fout_bpll");
>> +       if (IS_ERR(dmc->fout_bpll))
>> +               return PTR_ERR(dmc->fout_bpll);
>> +
>> +       dmc->mout_mclk_cdrex = devm_clk_get(dev, "mout_mclk_cdrex");
>> +       if (IS_ERR(dmc->mout_mclk_cdrex))
>> +               return PTR_ERR(dmc->mout_mclk_cdrex);
>> +
>> +       dmc->mout_bpll = devm_clk_get(dev, "mout_bpll");
>> +       if (IS_ERR(dmc->mout_bpll))
>> +               return PTR_ERR(dmc->mout_bpll);
>> +
>> +       dmc->mout_mx_mspll_ccore = devm_clk_get(dev, "mout_mx_mspll_ccore");
>> +       if (IS_ERR(dmc->mout_mx_mspll_ccore))
>> +               return PTR_ERR(dmc->mout_mx_mspll_ccore);
>> +
>> +       dmc->dout_clk2x_phy0 = devm_clk_get(dev, "dout_clk2x_phy0");
>> +       if (IS_ERR(dmc->dout_clk2x_phy0))
>> +               return PTR_ERR(dmc->dout_clk2x_phy0);
>> +
>> +       dmc->mout_spll = devm_clk_get(dev, "ff_dout_spll2");
>> +       if (IS_ERR(dmc->mout_spll)) {
>> +               dmc->mout_spll = devm_clk_get(dev, "mout_sclk_spll");
>> +               if (IS_ERR(dmc->mout_spll))
>> +                       return PTR_ERR(dmc->mout_spll);
>> +       }
>> +
>> +       /*
>> +        * Convert frequency to KHz values and set it for the governor.
>> +        */
>> +       dmc->curr_rate = clk_get_rate(dmc->mout_mclk_cdrex);
>> +       dmc->curr_rate = exynos5_dmc_align_init_freq(dmc, dmc->curr_rate);
>> +       exynos5_dmc_df_profile.initial_freq = dmc->curr_rate;
>> +
>> +       ret = exynos5_dmc_get_volt_freq(dev, &dmc->curr_rate, &target_rate,
>> +                                       &target_volt, 0);
>> +       if (ret)
>> +               return ret;
>> +
>> +       dmc->curr_volt = target_volt;
>> +
>> +       clk_prepare_enable(dmc->mout_spll);
>> +       clk_set_parent(dmc->mout_mx_mspll_ccore, dmc->mout_spll);
>> +       clk_prepare_enable(dmc->mout_mx_mspll_ccore);
>> +
>> +       dmc->bypass_rate = clk_get_rate(dmc->mout_mx_mspll_ccore);
>> +
>> +       clk_prepare_enable(dmc->fout_bpll);
>> +       clk_prepare_enable(dmc->mout_bpll);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_performance_counters_init() - Initializes performance DMC's counters
>> + * @dmc:       DMC for which it does the setup
>> + *
>> + * Initialization of performance counters in DMC for estimating usage.
>> + * The counter's values are used for calculation of a memory bandwidth and based
>> + * on that the governor changes the frequency.
>> + * The counters are not used when the governor is GOVERNOR_USERSPACE.
>> + */
>> +static int exynos5_performance_counters_init(struct exynos5_dmc *dmc)
>> +{
>> +       int counters_size;
>> +       int ret, i;
>> +
>> +       dmc->num_counters = devfreq_event_get_edev_count(dmc->dev);
>> +       if (dmc->num_counters < 0) {
>> +               dev_err(dmc->dev, "could not get devfreq-event counters\n");
>> +               return dmc->num_counters;
>> +       }
>> +
>> +       counters_size = sizeof(struct devfreq_event_dev) * dmc->num_counters;
>> +       dmc->counter = devm_kzalloc(dmc->dev, counters_size, GFP_KERNEL);
>> +       if (!dmc->counter)
>> +               return -ENOMEM;
>> +
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               dmc->counter[i] =
>> +                       devfreq_event_get_edev_by_phandle(dmc->dev, i);
>> +               if (IS_ERR_OR_NULL(dmc->counter[i]))
>> +                       return -EPROBE_DEFER;
>> +       }
>> +
>> +       ret = exynos5_counters_enable_edev(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not enable event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "counld not set event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       mutex_lock(&dmc->lock);
>> +       dmc->counters_enabled = true;
> 
> I do not think it is useful (counters_enabled == false cannot happen).
> You call this function before registering devfreq.
Yes, in this implementation the counters_enabled are not needed.
It will be removed in the next version.
> 
>> +       mutex_unlock(&dmc->lock);
>> +
>> +       return 0;
>> +}
>> +
>> +static struct regmap_config exynos5_clk_regmap_cfg = {
>> +       .reg_bits = 32,
>> +       .val_bits = 32,
>> +       .reg_stride = 4,
>> +};
>> +
>> +static int exynos5_dmc_init_clk_regmap(struct platform_device *pdev,
>> +                                      struct exynos5_dmc *dmc)
>> +{
>> +       struct resource *res;
>> +       void __iomem *base;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 3);
>> +       base = devm_ioremap_resource(dmc->dev, res);
>> +       if (IS_ERR(base))
>> +               return PTR_ERR(base);
>> +
>> +       exynos5_clk_regmap_cfg.max_register = resource_size(res) - 4;
>> +       dmc->clk_regmap = devm_regmap_init_mmio(dmc->dev, base,
>> +                                            &exynos5_clk_regmap_cfg);
>> +       if (IS_ERR(dmc->clk_regmap))
>> +               return PTR_ERR(dmc->clk_regmap);
>> +
>> +       return 0;
>> +}
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +
>> +static int dmc_dbg_show_timings(struct seq_file *seq, void *na)
>> +{
>> +       struct exynos5_dmc *dmc = seq->private;
>> +       int i, j;
>> +       u32 val;
>> +       struct timing_reg *reg;
>> +
>> +       seq_printf(seq, "timings for each frequency\n");
>> +       for (j = dmc->opp_count - 1; j >= 0; j--) {
>> +               seq_printf(seq, "frequency = %uMHz\n",
>> +                                  dmc->opp[j].freq_hz / 1000000);
>> +               seq_printf(seq, "timing_row, timing_data, timing_power\n");
>> +               seq_printf(seq, "0x%08X, 0x%08X, 0x%08X\n", dmc->timing_row[j],
>> +                          dmc->timing_data[j], dmc->timing_power[j]);
>> +       }
>> +
>> +       for (j = dmc->opp_count - 1; j >= 0; j--) {
>> +               seq_printf(seq, "frequency [MHz] = %u\n",
>> +                                  dmc->opp[j].freq_hz / 1000000);
>> +
>> +               for (i = 0; i < ARRAY_SIZE(timing_row); i++) {
>> +                       reg = &timing_row[i];
>> +                       val = TIMING_REG2VAL(dmc->timing_row[j], reg);
>> +                       seq_printf(seq, "%s = %u\n", reg->name, val);
>> +               }
>> +
>> +               for (i = 0; i < ARRAY_SIZE(timing_data); i++) {
>> +                       reg = &timing_data[i];
>> +                       val = TIMING_REG2VAL(dmc->timing_data[j], reg);
>> +                       seq_printf(seq, "%s = %u\n", reg->name, val);
>> +               }
>> +
>> +               for (i = 0; i < ARRAY_SIZE(timing_power); i++) {
>> +                       reg = &timing_power[i];
>> +                       val = TIMING_REG2VAL(dmc->timing_power[j], reg);
>> +                       seq_printf(seq, "%s = %u\n", reg->name, val);
>> +               }
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int dmc_dbg_open_timings(struct inode *inode, struct file *f)
>> +{
>> +       return single_open(f, dmc_dbg_show_timings, inode->i_private);
>> +}
>> +
>> +static const char *event_get_name(const char *evt)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(event_name); i += 2) {
>> +               if (!strcmp(event_name[i], evt))
>> +                       return event_name[i + 1];
>> +       }
>> +
>> +       return "Unknown";
>> +}
>> +
>> +static int dmc_dbg_show_cnt(struct seq_file *seq, void *na)
>> +{
>> +       struct exynos5_dmc *dmc = seq->private;
>> +       int i;
>> +       struct devfreq_event_data event;
>> +       struct devfreq_event_dev *edev;
>> +       int ret;
>> +       const char *evt_name;
>> +       u64 ts_new, delta;
>> +       static u64 ts;
>> +
>> +       seq_printf(seq, "Performance based on PMU counters\n");
>> +       seq_printf(seq, "The counters could overflow every ~9.2 sec\n");
>> +
>> +       ts_new = ktime_get_ns();
>> +       delta = ts_new - ts;
>> +
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               edev = dmc->counter[i];
>> +               if (!edev)
>> +                       continue;
>> +
>> +               evt_name = event_get_name(edev->desc->name);
>> +
>> +               ret = devfreq_event_get_event(edev, &event);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               seq_printf(seq, "%s = %lu / %lu\n", evt_name, event.load_count,
>> +                          event.total_count);
>> +       }
>> +
>> +       seq_printf(seq, "For last %llu ms\n",
>> +                  div64_u64(delta, 1000000UL));
>> +
>> +       ts = ktime_get_ns();
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not set event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int dmc_dbg_open_cnt(struct inode *inode, struct file *f)
>> +{
>> +       return single_open(f, dmc_dbg_show_cnt, inode->i_private);
>> +}
>> +
>> +struct counter {
>> +       u64 load;
>> +       u64 total;
>> +};
>> +
>> +static int dmc_dbg_show_cnt_100ms(struct seq_file *seq, void *na)
>> +{
>> +       struct exynos5_dmc *dmc = seq->private;
>> +       int i;
>> +       u64 bandwidth = 0;
>> +       struct devfreq_event_data event;
>> +       struct devfreq_event_dev *edev;
>> +       int ret;
>> +       const char *evt_name;
>> +       u64 ts_new, delta;
>> +       static u64 ts;
>> +       struct counter *cnt;
>> +       u64 total[3] = {0, 0, 0 }; /* read, write, read+write data*/
>> +       const char *type[3] = {"read", "write", "read+write"};
>> +       u64 bus_cyc_count = 0;
>> +       int offset = 0;
>> +       char *s;
>> +
>> +       s = kzalloc(PAGE_SIZE * sizeof(char), GFP_KERNEL);
>> +       if (!s)
>> +               return -ENOMEM;
>> +
>> +       cnt = kcalloc(dmc->num_counters, sizeof(struct counter), GFP_KERNEL);
>> +       if (!cnt)
>> +               return -ENOMEM;
>> +
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not set event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       ts = ktime_get_ns();
>> +       msleep(100);
>> +
>> +       /* Seprate data acquisition from presentation due to some
>> +          overheads. */
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               edev = dmc->counter[i];
>> +               if (!edev)
>> +                       continue;
>> +
>> +               ret = devfreq_event_get_event(edev, &event);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               total[i % 3] += event.load_count;
>> +               cnt[i].load = event.load_count;
>> +               cnt[i].total = event.total_count;
>> +
>> +               if (bus_cyc_count < event.total_count)
>> +                       bus_cyc_count = event.total_count;
>> +       }
>> +
>> +       ts_new = ktime_get_ns();
>> +       delta = ts_new - ts;
>> +       if (delta == 0)
>> +               delta = 1;
>> +
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               edev = dmc->counter[i];
>> +               if (!edev)
>> +                       continue;
>> +
>> +               evt_name = event_get_name(edev->desc->name);
>> +
>> +               bandwidth = (u64)cnt[i].load * AXI_BUS_WIDTH_BYTES * 1000;
>> +               bandwidth = div64_u64(bandwidth, delta);
>> +
>> +               offset += sprintf(s + offset, "%s\t\t%llu MB/s\n",
>> +                                 evt_name, bandwidth);
>> +       }
>> +
>> +       for (i = 0; i < 3; i++) {
>> +               bandwidth = (u64)total[i] * AXI_BUS_WIDTH_BYTES * 1000;
>> +               bandwidth = div64_u64(bandwidth, delta);
>> +
>> +               offset += sprintf(s + offset, "total\t%s\t\t%llu MB/s\n",
>> +                                 type[i], bandwidth);
>> +       }
>> +
>> +       /* AXI speed is presented in MHz*/
>> +       bus_cyc_count *= 1000;
>> +
>> +       seq_printf(seq, "Performance based on PMU counters\n");
>> +       seq_printf(seq, "The counters will overflow every ~9.2 sec\n");
>> +       seq_printf(seq, "%s", s);
>> +       seq_printf(seq, "AXI bus frequency %llu MHz, width %u B, SDR mode\n",
>> +                  div64_u64(bus_cyc_count, delta), AXI_BUS_WIDTH_BYTES);
>> +       seq_printf(seq, "For last %llu ms\n",
>> +                  div64_u64(delta, 1000000UL));
>> +
>> +       kfree(cnt);
>> +       kfree(s);
>> +
>> +       return 0;
>> +}
>> +
>> +static int dmc_dbg_show_cnt_100ms_raw(struct seq_file *seq, void *na)
>> +{
>> +       struct exynos5_dmc *dmc = seq->private;
>> +       int i;
>> +       struct devfreq_event_data event;
>> +       struct devfreq_event_dev *edev;
>> +       int ret;
>> +       const char *evt_name;
>> +       u64 ts_new, delta;
>> +       static u64 ts;
>> +       struct counter *cnt;
>> +       const char *type[3] = {"read", "write", "read+write"};
>> +       int offset = 0;
>> +       char *s;
>> +
>> +       s = kzalloc(PAGE_SIZE * sizeof(char), GFP_KERNEL);
>> +       if (!s)
>> +               return -ENOMEM;
>> +
>> +       cnt = kcalloc(dmc->num_counters, sizeof(struct counter), GFP_KERNEL);
>> +       if (!cnt)
>> +               return -ENOMEM;
>> +
>> +       ret = exynos5_counters_set_event(dmc);
>> +       if (ret < 0) {
>> +               dev_err(dmc->dev, "could not set event counter\n");
>> +               return ret;
>> +       }
>> +
>> +       ts = ktime_get_ns();
>> +       msleep(100);
>> +
>> +       /* Seprate data acquisition from presentation due to some
>> +          overheads. */
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               edev = dmc->counter[i];
>> +               if (!edev)
>> +                       continue;
>> +
>> +               ret = devfreq_event_get_event(edev, &event);
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               cnt[i].load = event.load_count;
>> +               cnt[i].total = event.total_count;
>> +       }
>> +
>> +       ts_new = ktime_get_ns();
>> +       delta = ts_new - ts;
>> +       if (delta == 0)
>> +               delta = 1;
>> +
>> +       for (i = 0; i < dmc->num_counters; i++) {
>> +               edev = dmc->counter[i];
>> +               if (!edev)
>> +                       continue;
>> +
>> +               evt_name = event_get_name(edev->desc->name);
>> +
>> +               offset += sprintf(s + offset, "%s (%s)\t\t%llu / %llu\n",
>> +                                 evt_name, type[i % 3], cnt[i].load,
>> +                                 cnt[i].total);
>> +       }
>> +
>> +       seq_printf(seq, "Performance based on PMU counters ('load'/'total')\n");
>> +       seq_printf(seq, "The counters will overflow every ~9.2 sec\n");
>> +       seq_printf(seq, "%s", s);
>> +       seq_printf(seq, "For last %llu ms\n",
>> +                  div64_u64(delta, 1000000UL));
>> +
>> +       kfree(cnt);
>> +       kfree(s);
>> +
>> +       return 0;
>> +}
>> +
>> +static int dmc_dbg_open_cnt_100ms(struct inode *inode, struct file *f)
>> +{
>> +       return single_open(f, dmc_dbg_show_cnt_100ms, inode->i_private);
>> +}
>> +
>> +static int dmc_dbg_open_cnt_100ms_raw(struct inode *inode, struct file *f)
>> +{
>> +       return single_open(f, dmc_dbg_show_cnt_100ms_raw, inode->i_private);
>> +}
>> +
>> +static const struct file_operations dmc_debugfs_ops_timings = {
>> +       .open = dmc_dbg_open_timings,
>> +       .read = seq_read,
>> +       .release = single_release,
>> +};
>> +
>> +static const struct file_operations dmc_debugfs_ops_cnt = {
>> +       .open = dmc_dbg_open_cnt,
>> +       .read = seq_read,
>> +       .release = single_release,
>> +};
>> +
>> +static const struct file_operations dmc_debugfs_ops_cnt_100ms = {
>> +       .open = dmc_dbg_open_cnt_100ms,
>> +       .read = seq_read,
>> +       .release = single_release,
>> +};
>> +
>> +static const struct file_operations dmc_debugfs_ops_cnt_100ms_raw = {
>> +       .open = dmc_dbg_open_cnt_100ms_raw,
>> +       .read = seq_read,
>> +       .release = single_release,
>> +};
>> +
>> +static void exynos5_dmc_debugfs_init(struct exynos5_dmc *dmc)
>> +{
>> +       struct dentry *dentry;
>> +
>> +       dmc->dbg_root = debugfs_create_dir(dev_name(dmc->dev), NULL);
>> +       if (!dmc->dbg_root)
>> +               return;
>> +
>> +       dentry = debugfs_create_file("timings", 0444, dmc->dbg_root, dmc,
>> +                                    &dmc_debugfs_ops_timings);
>> +       if (!dentry)
>> +               goto clean_debugfs;
>> +
>> +       dentry = debugfs_create_file("counters", 0444, dmc->dbg_root, dmc,
>> +                                    &dmc_debugfs_ops_cnt);
>> +       if (!dentry)
>> +               goto clean_debugfs;
>> +
>> +       dentry = debugfs_create_file("100ms_counters", 0444, dmc->dbg_root, dmc,
>> +                                    &dmc_debugfs_ops_cnt_100ms);
>> +       if (!dentry)
>> +               goto clean_debugfs;
>> +
>> +       dentry = debugfs_create_file("100ms_raw_counters", 0444, dmc->dbg_root,
>> +                                    dmc, &dmc_debugfs_ops_cnt_100ms_raw);
>> +       if (!dentry)
>> +               goto clean_debugfs;
>> +
>> +       return;
>> +
>> +clean_debugfs:
>> +       debugfs_remove_recursive(dmc->dbg_root);
>> +}
>> +#else
>> +static void exynos5_dmc_debugfs_init(struct exynos5_dmc *dmc)
>> +{}
>> +#endif
>> +
>> +/**
>> + * exynos5_dmc_set_pause_on_switching() - Controls a pause feature in DMC
>> + * @dmc:       device which is used for changing this feature
>> + * @set:       a boolean state passing enable/disable request
>> + *
>> + * There is a need of pausing DREX DMC when divider or MUX in clock tree
>> + * changes its configuration. In such situation access to the memory is blocked
>> + * in DMC automatically. This feature is used when clock frequency change
>> + * request appears and touches clock tree.
>> + */
>> +static inline int exynos5_dmc_set_pause_on_switching(struct exynos5_dmc *dmc)
>> +{
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = regmap_read(dmc->clk_regmap, CDREX_PAUSE, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       val |= 1UL;
>> +       regmap_write(dmc->clk_regmap, CDREX_PAUSE, val);
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_probe() - Probe function for the DMC driver
>> + * @pdev:      platform device for which the driver is going to be initialized
>> + *
>> + * Initialize basic components: clocks, regulators, performance counters, etc.
>> + * Read out product version and based on the information setup
>> + * internal structures for the controller (frequency and voltage) and for DRAM
>> + * memory parameters: timings for each operating frequency.
>> + * Register new devfreq device for controlling DVFS of the DMC.
>> + */
>> +static int exynos5_dmc_probe(struct platform_device *pdev)
>> +{
>> +       int ret = 0;
>> +       struct exynos5_dmc *dmc;
>> +       struct device *dev = &pdev->dev;
>> +       struct resource *res;
>> +
>> +       dmc = devm_kzalloc(dev, sizeof(*dmc), GFP_KERNEL);
>> +       if (!dmc)
>> +               return -ENOMEM;
>> +
>> +       mutex_init(&dmc->lock);
>> +
>> +       dmc->dev = dev;
>> +       platform_set_drvdata(pdev, dmc);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       dmc->base_drexi0 = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(dmc->base_drexi0))
>> +               return PTR_ERR(dmc->base_drexi0);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +       dmc->base_drexi1 = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(dmc->base_drexi1))
>> +               return PTR_ERR(dmc->base_drexi1);
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>> +       dmc->chip_id = devm_ioremap_resource(dev, res);
>> +       if (IS_ERR(dmc->chip_id))
>> +               return PTR_ERR(dmc->chip_id);
>> +
>> +       ret = exynos5_dmc_chip_revision_settings(dmc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = exynos5_init_freq_table(dev, dmc, &exynos5_dmc_df_profile);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize frequency settings\n");
>> +               return ret;
>> +       }
>> +
>> +       dmc->vdd_mif = devm_regulator_get(dev, "vdd");
>> +       if (IS_ERR(dmc->vdd_mif)) {
>> +               ret = PTR_ERR(dmc->vdd_mif);
>> +               dev_warn(dev, "couldn't get regulator\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_dmc_init_clks(dev, dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize clocks\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_dmc_init_clk_regmap(pdev, dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize clock regmap\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = of_get_dram_timings(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't initialize timings settings\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = exynos5_performance_counters_init(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't probe performance counters\n");
>> +               goto remove_clocks;
>> +       }
>> +
>> +       ret = exynos5_dmc_set_pause_on_switching(dmc);
>> +       if (ret) {
>> +               dev_warn(dev, "couldn't get access to PAUSE register\n");
>> +               goto remove_clocks;
>> +       }
>> +
>> +
>> +       /*
>> +        * Setup default thresholds for the devfreq governor.
>> +        * The values are chosen based on experiments.
>> +        */
>> +       dmc->gov_data.upthreshold = 30;
>> +       dmc->gov_data.downdifferential = 5;
>> +
>> +       dmc->df = devm_devfreq_add_device(dev, &exynos5_dmc_df_profile,
>> +                                         DEVFREQ_GOV_USERSPACE,
>> +                                         &dmc->gov_data);
>> +
>> +       if (IS_ERR(dmc->df)) {
>> +               ret = PTR_ERR(dmc->df);
>> +               goto err_devfreq_add;
>> +       }
>> +
>> +       exynos5_dmc_debugfs_init(dmc);
>> +
>> +       dev_info(&pdev->dev, "DMC init for prod_id=0x%08x pkg_id=0x%08x\n",
>> +                dmc->prod_rev, dmc->pkg_rev);
>> +
>> +       return 0;
>> +
>> +err_devfreq_add:
>> +       exynos5_counters_disable_edev(dmc);
>> +remove_clocks:
>> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
>> +       clk_disable_unprepare(dmc->mout_spll);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * exynos5_dmc_remove() - Remove function for the platform device
>> + * @pdev:      platform device which is going to be removed
>> + *
>> + * The function relies on 'devm' framework function which automatically
>> + * clean the device's resources. It just calls explicitly disable function for
>> + * the performance counters.
>> + */
>> +static int exynos5_dmc_remove(struct platform_device *pdev)
>> +{
>> +       struct exynos5_dmc *dmc = dev_get_drvdata(&pdev->dev);
>> +
>> +       exynos5_counters_disable_edev(dmc);
>> +
>> +       clk_disable_unprepare(dmc->mout_mx_mspll_ccore);
>> +       clk_disable_unprepare(dmc->mout_spll);
>> +
>> +       dev_pm_opp_remove_table(&pdev->dev);
>> +
>> +       dev_info(&pdev->dev, "DMC removed\n");
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id exynos5_dmc_of_match[] = {
>> +       { .compatible = "samsung,exynos5422-dmc", },
>> +       { },
>> +};
>> +MODULE_DEVICE_TABLE(of, exynos5_dmc_of_match);
>> +
>> +static struct platform_driver exynos5_dmc_platdrv = {
>> +       .probe  = exynos5_dmc_probe,
>> +       .remove = exynos5_dmc_remove,
>> +       .driver = {
>> +               .name   = "exynos5-dmc",
>> +               .of_match_table = exynos5_dmc_of_match,
>> +       },
>> +};
>> +module_platform_driver(exynos5_dmc_platdrv);
>> +MODULE_DESCRIPTION("Driver for Exynos5422 Dynamic Memory Controller dynamic frequency and voltage change"
> 
> Unneeded empty line.
I agree.

Thank you Krzysztof for the review. I will wait for Rob's feedback
regarding the 'max-freq' --> 'reg' in the DT node and will send new
patches.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
