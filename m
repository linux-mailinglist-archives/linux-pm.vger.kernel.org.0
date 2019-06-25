Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1754D93
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 13:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfFYL0c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 07:26:32 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41591 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbfFYL03 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 07:26:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190625112627euoutp01a2f174378b6c03d8c9cd635ca6640bf9~rbWeK5BvD1598715987euoutp01W
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 11:26:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190625112627euoutp01a2f174378b6c03d8c9cd635ca6640bf9~rbWeK5BvD1598715987euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1561461987;
        bh=4JqJU6o+DBERiv2665/v0Qox8IaVOTuNpfkHMCWoIsg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=k3/hcH/9xyZ+Dgm/9dNAB651g0m8NrA86lYHQSh/4Zn/79c7RyXFUAgUg4AF3IT1Q
         4+LvpUlssjYcDtyNmDWJoNS6y34OdvBFDw5YT5w4UhdKAu1JUphkN49OH59HpV02Ii
         6mWvUGc6uBMjPK+ZhcKWeiIeLQCBNJhw08etOMW8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190625112626eucas1p1a56ebd39e6920cf3632c43593d16400a~rbWdYv9Dv2883828838eucas1p16;
        Tue, 25 Jun 2019 11:26:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7E.B5.04377.2E4021D5; Tue, 25
        Jun 2019 12:26:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190625112625eucas1p2a239acd7ee684a0047a9fd23609d23d8~rbWco0ske0583405834eucas1p2T;
        Tue, 25 Jun 2019 11:26:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190625112625eusmtrp16444d3bfff1f7fc4e65ec50a5c17a3bf~rbWcagC1t2442124421eusmtrp1M;
        Tue, 25 Jun 2019 11:26:25 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-d4-5d1204e20e8f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.8F.04140.1E4021D5; Tue, 25
        Jun 2019 12:26:25 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190625112624eusmtip2f772a8b2ffcf5006f12513e6e216ae3a~rbWbgR6Ro2017020170eusmtip2P;
        Tue, 25 Jun 2019 11:26:24 +0000 (GMT)
Subject: Re: [PATCH v10 08/13] drivers: memory: add DMC driver for
 Exynos5422
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        kyungmin.park@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <c12891f3-2b52-a059-cd74-afe6e41271f4@partner.samsung.com>
Date:   Tue, 25 Jun 2019 13:26:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdjXhfcNRL-XMS6K1jrUQoqoNHXGirjXoeoL4GyXzarpg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHO7vPjSbXaXoqMRgUFqQWBQeK6M2l/uhBf1gmddObj9zU3azM
        IFMyLZ2hmbUSNSllPcxpaw5RW1Or2dReRsMyZwmapThNraTNa+R/n/M939/jezg0psgkF9Gx
        6uO8Rs3FK0kZbmyZbF/ZiysiQm+1SFH1tSoCdbn6CVRitRPo7ogToIzyKhIVvCiWoLZLKpTn
        HMRQe/tDCr1M/0ahkZyPBHptvkmi0VwrQNfaGyTovrWbQp0vtiHHuUoSPf12gUDT76px1Phm
        B3L88kLjz3rBRj92fCwfZ3+8P0+xN9I6cbZO102xBn02yTYW36PY3IzvJKut1QO2xpbKjhoC
        d8sOyNZH8fGxJ3hNyIbDshiH2UUmjm8+lZ41SaSBztCLQEpDZg10vh0kPKxgKgFsKnKzzM0u
        AJu1Bkw8jALY9ecDdRHQMxWWksOiXgHg1yuWWdMQgB1FWuBp5cPsgvUVzZiHfZnl7uKfM20x
        ppCA9T/tpKcTyQRDkz7J45Ez2+EdR43EwzizFDaMOXAPL2DCoKvOAESPN3x+vW9GlzJ7YLpJ
        P+PHGH/4oa9klpfAx0M3MTFaEw0H+5NE3gqnnGZKZB840Fo7ywHQVpCDiyzAtNwyIPIZ6Mwr
        nvWsg09bOwnPypg7S5U5RJQ3QW3ZZ4n4Jl7w/ZC3uIEXzDcWYaIsh1mZCtEdBGtzOiQi+8GK
        e1epy0Cpm5NLNyeLbk4W3f+5pQDXA38+WVBF88JqNX8yWOBUQrI6OjgyQWUA7t9pm251mYD5
        9xELYGignC+faGEiFAR3QkhRWQCkMaWv/DbnluRRXMppXpNwSJMczwsWsJjGlf7y1Hk94Qom
        mjvOH+P5RF7z71ZCSxelASmH5Z4a+gS3Ol8JsjBm7zNpXKixYcpqTBg26lPGhoP8ysm+7LiD
        Cx/tKQusqzdfKrVJJvLVNTvPTYXta83mnwjGugfWqU1Se6Edn8i80fOlEe/xB8siW2q3dHRr
        iz4PmIJj2+yW37r9Z49uNvVOBhx7sq80L3nBWtsZeXjGeSUuxHCrVmAagfsLHX9QBJkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsVy+t/xe7oPWYRiDVafErTYOGM9q8X1L89Z
        LeYfOcdqsfrjY0aL5sXr2Swmn5rLZHGmO9ei//FrZovz5zewW5xtesNu8bHnHqvF5V1z2Cw+
        9x5htJhxfh+Txdojd9ktLp5ytbjduILN4vCbdlaLf9c2sljsv+Jlcfs3n8W3E48YHcQ8vn2d
        xOLx/kYru8fshossHjtn3WX32LSqk81j/9w17B69ze/YPPq2rGL02Hy62uPzJrkArig9m6L8
        0pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jNu7vrAVfHOq
        aOr4ydrAeNGgi5GDQ0LAROLQ/IQuRi4OIYGljBLzti5g6mLkBIqLSUzat50dwhaW+HOtiw2i
        6DWjxPZrj5hAmoUFfCV2HxcHqRER0JS4/vc7K0gNs8BUVokJz0+zQzRMYJLY2HuLDaSBTUBP
        YseqQpAGXgE3iWW3N4MtYxFQldj39TYLiC0qECExe1cDC0SNoMTJmU/AbE6BQImmHavA6pkF
        zCTmbX7IDGGLS9x6Mh8qLi+x/e0c5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kV
        J+YWl+al6yXn525iBCaMbcd+btnB2PUu+BCjAAejEg/vgiMCsUKsiWXFlbmHGCU4mJVEeJcm
        AoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5jM8kriDU0NzS0sDc2NzY3NLJTEeTsEDsYI
        CaQnlqRmp6YWpBbB9DFxcEo1MDof7/w4uUfw2tsZhsGxnTdyq921Qh0nnG6u3yF74VTh3raO
        TCOpR8m1e59NnnWhxuaTU4FN+ceA8v2LJ3Z/3LWJX+l+r8FHs/+2f7gYDpkorux01Dh/O/4f
        21eFde/0o6Kzu7n25aaYL2Fy7vjnc0ww0nVV7GKeieurGVpf2f2bzJjZ94BjpRJLcUaioRZz
        UXEiAPBVXKIuAwAA
X-CMS-MailID: 20190625112625eucas1p2a239acd7ee684a0047a9fd23609d23d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9
References: <CGME20190614095327eucas1p19b6e522efa15c8fd21c51f3900e376e9@eucas1p1.samsung.com>
        <20190614095309.24100-1-l.luba@partner.samsung.com>
        <20190614095309.24100-9-l.luba@partner.samsung.com>
        <CAJKOXPdjXhfcNRL-XMS6K1jrUQoqoNHXGirjXoeoL4GyXzarpg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Krzysztof,

On 6/14/19 3:47 PM, Krzysztof Kozlowski wrote:
> On Fri, 14 Jun 2019 at 11:53, Lukasz Luba <l.luba@partner.samsung.com> wrote:
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
>>   drivers/memory/samsung/exynos5422-dmc.c | 1262 +++++++++++++++++++++++
>>   4 files changed, 1288 insertions(+)
>>   create mode 100644 drivers/memory/samsung/exynos5422-dmc.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 57f496cff999..6ffccfd95351 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3470,6 +3470,14 @@ S:       Maintained
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
>> index 79ce7ea58903..c93baa029654 100644
>> --- a/drivers/memory/samsung/Kconfig
>> +++ b/drivers/memory/samsung/Kconfig
>> @@ -5,6 +5,23 @@ config SAMSUNG_MC
>>            Support for the Memory Controller (MC) devices found on
>>            Samsung Exynos SoCs.
>>
>> +config ARM_EXYNOS5422_DMC
>> +       tristate "ARM EXYNOS5422 Dynamic Memory Controller driver"
>> +       depends on ARCH_EXYNOS
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
>> index 00587be66211..4f6e4383bab7 100644
>> --- a/drivers/memory/samsung/Makefile
>> +++ b/drivers/memory/samsung/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_ARM_EXYNOS5422_DMC)       += exynos5422-dmc.o
>>   obj-$(CONFIG_EXYNOS_SROM)      += exynos-srom.o
>> diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
>> new file mode 100644
>> index 000000000000..b397efe0da57
>> --- /dev/null
>> +++ b/drivers/memory/samsung/exynos5422-dmc.c
>> @@ -0,0 +1,1262 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2019 Samsung Electronics Co., Ltd.
>> + * Author: Lukasz Luba <l.luba@partner.samsung.com>
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/devfreq.h>
>> +#include <linux/devfreq-event.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
>> +#include <linux/pm_opp.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
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
>> +#define CDREX_PAUSE                            (0x2091c)
>> +#define CDREX_LPDDR3PHY_CON3                   (0x20a20)
>> +#define EXYNOS5_TIMING_SET_SWI                 (1UL << 28)
>> +#define USE_MX_MSPLL_TIMINGS                   (1)
>> +#define USE_BPLL_TIMINGS                       (0)
>> +#define EXYNOS5_AREF_NORMAL                    (0x2e)
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
>> +       struct regulator *vdd_mif;
>> +       struct clk *fout_spll;
>> +       struct clk *fout_bpll;
>> +       struct clk *mout_spll;
>> +       struct clk *mout_bpll;
>> +       struct clk *mout_mclk_cdrex;
>> +       struct clk *mout_mx_mspll_ccore;
>> +       struct clk *mx_mspll_ccore_phy;
>> +       struct clk *mout_mx_mspll_ccore_phy;
>> +       struct devfreq_event_dev **counter;
>> +       int num_counters;
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
> 
> It seems that only some of these defines are used. Please clean them up.
Indeed, they were used in previous version which had more features and
debug options. So TIMING_REG2VAL and TIMING_VAL will be cleaned
> You have also a lot of checkpatch --strict suggestions:
>      CHECK: Macro argument 'reg' may be better as '(reg)' to avoid
> precedence issues
> which seems to be valid.
Will not be valid since it is in TIMING_REG2VAL macro which was used
for debugfs information only.
> 
> While at it please also fix few other --strict errors:
> CHECK: Please don't use multiple blank lines
> CHECK: Alignment should match open parenthesis
> CHECK: Prefer using the BIT macro
> CHECK: struct mutex definition without comment
I wouldn't call them 'errors' but will do a cleanup.

Thank you for the review.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
