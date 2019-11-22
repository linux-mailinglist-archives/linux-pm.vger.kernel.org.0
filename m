Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB25A105E57
	for <lists+linux-pm@lfdr.de>; Fri, 22 Nov 2019 02:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfKVBmV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 21 Nov 2019 20:42:21 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46570 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfKVBmU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 21 Nov 2019 20:42:20 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20191122014216epoutp048f93499b85e321a5472155150f097541~ZWJPBwN8V0331303313epoutp04b
        for <linux-pm@vger.kernel.org>; Fri, 22 Nov 2019 01:42:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20191122014216epoutp048f93499b85e321a5472155150f097541~ZWJPBwN8V0331303313epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574386936;
        bh=GR03aDQbfStvmfjDNg/FBv4jUCiq+teb7kPBMKC3DRk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=t6FP0j6VFGWXAEdfzwygsYJJzyUL9NXIKzLZUrBUS72Aad1USIOgOOMsgtpBbyOVy
         XYbgNfOzXUZhSHU9mpqEmFHjR0j+g1OrcZWgUVeIgHuGbXifNiziF4gJ/KnEUyDD2C
         PhSyPnUP9L3/t6vF1GPQMO2+cCbw1Q39vmU002OI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20191122014215epcas1p2afe2bd2ce45c399e0a77cb8eb0239006~ZWJOOBrca1742217422epcas1p2Y;
        Fri, 22 Nov 2019 01:42:15 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47Jzgm05rXzMqYkb; Fri, 22 Nov
        2019 01:42:12 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.86.04080.3FC37DD5; Fri, 22 Nov 2019 10:42:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191122014211epcas1p454caf6233ebbbc5e7d957a42646b5c84~ZWJKmCbyu1507115071epcas1p4p;
        Fri, 22 Nov 2019 01:42:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191122014211epsmtrp12b863f9d16d04f26fdae992fce2e1f36~ZWJKkyXf31290112901epsmtrp14;
        Fri, 22 Nov 2019 01:42:11 +0000 (GMT)
X-AuditID: b6c32a37-7cdff70000000ff0-d7-5dd73cf339e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A4.DF.03654.3FC37DD5; Fri, 22 Nov 2019 10:42:11 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191122014211epsmtip102d71ac0d0424f5294c1093a9377fea6~ZWJKJSeB22147921479epsmtip1J;
        Fri, 22 Nov 2019 01:42:11 +0000 (GMT)
Subject: Re: [PATCH v6 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <f2dad757-f326-172f-3c78-15266d38d602@samsung.com>
Date:   Fri, 22 Nov 2019 10:47:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023C4B9CF43BA2EB2D6A66BEE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjO13PpgazzrIp864+JZyxsZCC1Fj436sZk5iSiY9nVmY6dlSMw
        elsPF50mAzcQ6w2ykMUComMYLG6jFSaYdmhFx8XBqlAITHGDETAOIqWEsaBrOZrw73mf532f
        L8/75aUweadUQeUY83iLkdMzZDj+89WXNsT5kwe1CdbeJOS53iJFgZ5ugM7evAbQXOUlDI2N
        jgB08aQO1Xb0EshxYQRH37qdJLJXtuGor69Jin47eF+KGm4/IJBzzEegB0fvEMi6eA5D/mMd
        ANUPeiXI11BBIH/TGEDe7jfRSHEDiRbscwRq7L1Cohs9NwlU4u6QIqtniUQPfQ4cTTZHovo6
        H4YcAfb1dWyltQGw50+dB+zMUImUrSry4uxpZz7rtB8m2T98LpK98P2XrGO6VcJemXZJ2BNL
        Cezi1Qi2eeAQzh5vtgPW73wufdVHucnZPJfJW6J4o86UmWPM0jDb38nYmqFOTFDGKTejJCbK
        yBl4DZOalh63LUcfXBQTVcDp84NUOicIzIYtyRZTfh4flW0S8jQMb87Umzeb4wXOIOQbs+J1
        JsMryoSEjepg4ye52cO2Ccw8WwP2jk/cwopA8X4rCKMgvQkeL63CrCCcktOtALbU3cBCgpye
        BfAn32eiMA9gwFZOPpmY/7cFiIIbwEunOkmxmAFw8bpreXw1/SEcHn1EhIQ1dAWAs3NV0lCB
        0Y4w2PLdWSLURdKxsH1yaNl3Fb0eDiyMBX0pSkZvgU1/p4donH4B2uo7sRAdETTtCXAhWkY/
        A7tOjuMhHEZrob/LJQ1hjI6HE902XMSRcHi8ViLidfDiP9WYmGCIgjMTL4csIZ0KB/tiRHo1
        vPdrs1TECjh1ovQx3g/PdXUsZ4R0GYDN7b8ToqCC7fXfSES8Hrb9VwPEt56G04GjhOgvg2Wl
        crHleXjr7u3H7c/CukOHyXLA2Faksa1IYFuRwLYiwWmA28Fa3iwYsnhBaVat/G4nWL6i2KRW
        0NSb5gE0BZinZOWFPq2c4AqEfQYPgBTGrJG5Bvu1clkmt+8L3mLKsOTrecED1MFlV2CKCJ0p
        eJPGvAyleqNKpUKblIlqpZKJlFELXq2czuLy+FyeN/OWJ3MSKkxRBDJ3fT3q7c+pqf5l91JT
        9KdlB9zFtfTnMX9em1e0+925j168o5nud7919/LumJLq6DcmGz9+7Yzv4I5dGPC//Z608N2G
        7QPCzvIDKa4FtW6xMPyHe2x9wVT0nvgjVUcS08I1SYGv7k/9uPbYnpQzKQ8bPaq/2lKT39cm
        7rVvNX6guPyqUMHgQjanjMUsAvc/cmL1NVsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfyyUcRzHfe/5cY+bm6eT+SLUbbWlFFs/vm1mNrM9q3/80xbtphtPx7hj
        97hEa3SmuAh/CFd+tDAdWzzIj9Dc0aJSHMcQW66ylkpH6UryUJv/Xp/P+/P6fP75UJisjfCh
        EjVprFajTJaTEvyRRe4f5AidVARbrb7I/LRdjFafDwNUPzYI0EppN4YW5mcA6qiIQ9UDIwRq
        aZ3BUVkvTyJTaReOXr1qFqOX+k9i1PBmmUD8go1AywVzBDI4H2DIUTgAUN3kqAjZGkoI5Ghe
        AGh0OBLNXGsg0ZpphUCNI/0kevF8jEC5vQNiZDCvk+iPrQVHi21eqO6+DUMtq0x4AFNqaABM
        U1UTYL5M5YqZO9mjOFPD6xjelE8ys7YekmmtzWJaPneKmP7PPSKmaD2YcVo8mbaJGzhzq80E
        GAfvH+UeIwmNZ5MTL7Hao2EXJAnTxvdY6rdKcNn+3oplg2tXDMCVgvQx+P1nOzAACSWjHwOY
        1z1Obgfe8PboIGYA1CZ7QIuF255ZAvB3jl4kzHjQ5+D0/AYhBLvpEgDt+a2YUGB0hyt8UXST
        3FY+iuBG+/zWWpIOhE8Wp7bYnd4HJ9YWgHBCSofB5ndRQhun90Nj3TNMYM/NCx86poDAUnoX
        HKqw4wK70groGOoRC4zRh+F1xz3RNnvBaXv1Pw6AHUt3sWLgYdyhG3coxh2KcYdSA3AT8GZT
        ObVKzYWkhmjY9COcUs3pNKojcSlqHmz9UuDBTmCtjTUDmgJyN2lxuk0hI5SXuAy1GUAKk++W
        9kyOK2TSeGVGJqtNidXqklnODHwpXO4lfad5Gi2jVco0NollU1nt/1REufpkgzKNvd3Nedat
        +K1/RIy0PMgcreqr5/FV96wku3Oijx+ZLTp68UfhgeN55adO1EWm2J1753TZngNin9mTv17X
        GIOr/D6UVEoCS11o3Zk9QeFJmY1qfZr/6fPBedFfC1StRFe5n+XQnM2rHn8Y8lDadFVfwIcd
        c7lQr7dGFPnmDMpxLkEZEohpOeVf6aaf60cDAAA=
X-CMS-MailID: 20191122014211epcas1p454caf6233ebbbc5e7d957a42646b5c84
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114183341epcas1p362ecf4d86e6bdb9352f2a4b932f3204e
References: <cover.1573756360.git.leonard.crestez@nxp.com>
        <CGME20191114183341epcas1p362ecf4d86e6bdb9352f2a4b932f3204e@epcas1p3.samsung.com>
        <3b1341a9a0c0dcaae1f37aebff25b773db7429cf.1573756360.git.leonard.crestez@nxp.com>
        <b0146aad-f9f5-875e-74aa-5afc4ccafb2e@samsung.com>
        <VI1PR04MB7023C4B9CF43BA2EB2D6A66BEE4D0@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 11/18/19 11:37 PM, Leonard Crestez wrote:
> On 2019-11-15 3:26 AM, Chanwoo Choi wrote:
>> After reviewing the dt-binding patch from DT maintainer,
>> I'll take patch3/patch4 to devfreq git.
>>
>> Or, Should I have to finish the review of patch1/patch2?
> Patches 1/2 were already reviewed but they conflict with other pending 
> series doing clk_hw cleanups:
> 
>      https://patchwork.kernel.org/cover/11224933/
>      https://patchwork.kernel.org/cover/11217881/
> 
> Those cleanups would conflict with most imx8m clk changes, it might make 
> sense to wait for them to enter first and then I'll send a v7 of devfreq 
> with solved conflicts and collected acks.
> 
> Shawn / Stephen: How should we proceed?
> 
>> Regards,
>> Chanwoo Choi
>>
>> On 11/15/19 3:33 AM, Leonard Crestez wrote:
>>> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
>>> frequency switching is implemented inside TF-A, this driver wraps the
>>> SMC calls and synchronizes the clk tree.
>>>
>>> The DRAM clocks on imx8m have the following structure (abridged):
>>>
>>>   +----------+       |\            +------+
>>>   | dram_pll |-------|M| dram_core |      |
>>>   +----------+       |U|---------->| D    |
>>>                   /--|X|           |  D   |
>>>     dram_alt_root |  |/            |   R  |
>>>                   |                |    C |
>>>              +---------+           |      |
>>>              |FIX DIV/4|           |      |
>>>              +---------+           |      |
>>>    composite:     |                |      |
>>>   +----------+    |                |      |
>>>   | dram_alt |----/                |      |
>>>   +----------+                     |      |
>>>   | dram_apb |-------------------->|      |
>>>   +----------+                     +------+
>>>
>>> The dram_pll is used for higher rates and dram_alt is used for lower
>>> rates. The dram_alt and dram_apb clocks are "imx composite" and their
>>> parent can also be modified.
>>>
>>> This driver will prepare/enable the new parents ahead of switching (so
>>> that the expected roots are enabled) and afterwards it will call
>>> clk_set_parent to ensure the parents in clock framework are up-to-date.
>>>
>>> The driver relies on dram_pll dram_alt and dram_apb being marked with
>>> CLK_GET_RATE_NOCACHE for rate updates.
>>>
>>> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>>> ---
>>>   drivers/devfreq/Kconfig      |   9 +
>>>   drivers/devfreq/Makefile     |   1 +
>>>   drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 475 insertions(+)
>>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index 066e6c4efaa2..923a6132e741 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ
>>>   	  Each memory bus group could contain many memoby bus block. It reads
>>>   	  PPMU counters of memory controllers by using DEVFREQ-event device
>>>   	  and adjusts the operating frequencies and voltages with OPP support.
>>>   	  This does not yet operate with optimal voltages.
>>>   
>>> +config ARM_IMX8M_DDRC_DEVFREQ
>>> +	tristate "i.MX8M DDRC DEVFREQ Driver"
>>> +	depends on ARCH_MXC || COMPILE_TEST
>>> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
>>> +	select DEVFREQ_GOV_USERSPACE
>>> +	help
>>> +	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>>> +	  adjusting DRAM frequency.
>>> +
>>>   config ARM_TEGRA_DEVFREQ
>>>   	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>>>   	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>>>   		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>>>   		ARCH_TEGRA_210_SOC || \
>>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>>> index 338ae8440db6..3eb4d5e6635c 100644
>>> --- a/drivers/devfreq/Makefile
>>> +++ b/drivers/devfreq/Makefile
>>> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>>>   obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>>>   obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>>>   
>>>   # DEVFREQ Drivers
>>>   obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>>> +obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>>>   obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>>>   obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>>>   obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>>>   
>>>   # DEVFREQ Event Drivers
>>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
>>> new file mode 100644
>>> index 000000000000..fea169619c59
>>> --- /dev/null
>>> +++ b/drivers/devfreq/imx8m-ddrc.c
>>> @@ -0,0 +1,465 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2019 NXP
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/device.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/devfreq.h>
>>> +#include <linux/pm_opp.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/clk-provider.h>
>>> +#include <linux/arm-smccc.h>
>>> +
>>> +#define IMX_SIP_DDR_DVFS			0xc2000004
>>> +
>>> +/* Values starting from 0 switch to specific frequency */
>>> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00
>>> +
>>> +/* Deprecated after moving IRQ handling to ATF */
>>> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F
>>> +
>>> +/* Query available frequencies. */
>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10
>>> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11
>>> +
>>> +/*
>>> + * This should be in a 1:1 mapping with devicetree OPPs but
>>> + * firmware provides additional info.
>>> + */
>>> +struct imx8m_ddrc_freq {
>>> +	unsigned long rate;
>>> +	unsigned long smcarg;
>>> +	int dram_core_parent_index;
>>> +	int dram_alt_parent_index;
>>> +	int dram_apb_parent_index;
>>> +};
>>> +
>>> +/* Hardware limitation */
>>> +#define IMX8M_DDRC_MAX_FREQ_COUNT 4
>>> +
>>> +/*
>>> + * i.MX8M DRAM Controller clocks have the following structure (abridged):
>>> + *
>>> + * +----------+       |\            +------+
>>> + * | dram_pll |-------|M| dram_core |      |
>>> + * +----------+       |U|---------->| D    |
>>> + *                 /--|X|           |  D   |
>>> + *   dram_alt_root |  |/            |   R  |
>>> + *                 |                |    C |
>>> + *            +---------+           |      |
>>> + *            |FIX DIV/4|           |      |
>>> + *            +---------+           |      |
>>> + *  composite:     |                |      |
>>> + * +----------+    |                |      |
>>> + * | dram_alt |----/                |      |
>>> + * +----------+                     |      |
>>> + * | dram_apb |-------------------->|      |
>>> + * +----------+                     +------+
>>> + *
>>> + * The dram_pll is used for higher rates and dram_alt is used for lower rates.
>>> + *
>>> + * Frequency switching is implemented in TF-A (via SMC call) and can change the
>>> + * configuration of the clocks, including mux parents. The dram_alt and
>>> + * dram_apb clocks are "imx composite" and their parent can change too.
>>> + *
>>> + * We need to prepare/enable the new mux parents head of switching and update
>>> + * their information afterwards.
>>> + */
>>> +struct imx8m_ddrc {
>>> +	struct devfreq_dev_profile profile;
>>> +	struct devfreq *devfreq;
>>> +
>>> +	/* For frequency switching: */
>>> +	struct clk *dram_core;
>>> +	struct clk *dram_pll;
>>> +	struct clk *dram_alt;
>>> +	struct clk *dram_apb;
>>> +
>>> +	int freq_count;
>>> +	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
>>> +};
>>> +
>>> +static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc *priv,
>>> +						    unsigned long rate)
>>> +{
>>> +	struct imx8m_ddrc_freq *freq;
>>> +	int i;
>>> +
>>> +	/*
>>> +	 * Firmware reports values in MT/s, so we round-down from Hz
>>> +	 * Rounding is extra generous to ensure a match.
>>> +	 */
>>> +	rate = DIV_ROUND_CLOSEST(rate, 250000);
>>> +	for (i = 0; i < priv->freq_count; ++i) {
>>> +		freq = &priv->freq_table[i];
>>> +		if (freq->rate == rate ||
>>> +				freq->rate + 1 == rate ||
>>> +				freq->rate - 1 == rate)
>>> +			return freq;
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +static void imx8m_ddrc_smc_set_freq(int target_freq)
>>> +{
>>> +	struct arm_smccc_res res;
>>> +	u32 online_cpus = 0;
>>> +	int cpu;
>>> +
>>> +	local_irq_disable();
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		online_cpus |= (1 << (cpu * 8));
>>> +
>>> +	/* change the ddr freqency */
>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,
>>> +			0, 0, 0, 0, 0, &res);
>>> +
>>> +	local_irq_enable();
>>> +}
>>> +
>>> +static struct clk *clk_get_parent_by_index(struct clk *clk, int index)
>>> +{
>>> +	struct clk_hw *hw;
>>> +
>>> +	hw = clk_hw_get_parent_by_index(__clk_get_hw(clk), index);
>>> +
>>> +	return hw ? hw->clk : NULL;
>>> +}
>>> +
>>> +static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_freq *freq)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct clk *new_dram_core_parent;
>>> +	struct clk *new_dram_alt_parent;
>>> +	struct clk *new_dram_apb_parent;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * Fetch new parents
>>> +	 *
>>> +	 * new_dram_alt_parent and new_dram_apb_parent are optional but
>>> +	 * new_dram_core_parent is not.
>>> +	 */
>>> +	new_dram_core_parent = clk_get_parent_by_index(
>>> +			priv->dram_core, freq->dram_core_parent_index - 1);
>>> +	if (!new_dram_core_parent) {
>>> +		dev_err(dev, "failed to fetch new dram_core parent\n");
>>> +		return -EINVAL;
>>> +	}
>>> +	if (freq->dram_alt_parent_index) {
>>> +		new_dram_alt_parent = clk_get_parent_by_index(
>>> +				priv->dram_alt,
>>> +				freq->dram_alt_parent_index - 1);
>>> +		if (!new_dram_alt_parent) {
>>> +			dev_err(dev, "failed to fetch new dram_alt parent\n");
>>> +			return -EINVAL;
>>> +		}
>>> +	} else
>>> +		new_dram_alt_parent = NULL;
>>> +
>>> +	if (freq->dram_apb_parent_index) {
>>> +		new_dram_apb_parent = clk_get_parent_by_index(
>>> +				priv->dram_apb,
>>> +				freq->dram_apb_parent_index - 1);
>>> +		if (!new_dram_apb_parent) {
>>> +			dev_err(dev, "failed to fetch new dram_apb parent\n");
>>> +			return -EINVAL;
>>> +		}
>>> +	} else
>>> +		new_dram_apb_parent = NULL;
>>> +
>>> +	/* increase reference counts and ensure clks are ON before switch */
>>> +	ret = clk_prepare_enable(new_dram_core_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to enable new dram_core parent: %d\n",
>>> +			ret);
>>> +		goto out;
>>> +	}
>>> +	ret = clk_prepare_enable(new_dram_alt_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to enable new dram_alt parent: %d\n",
>>> +			ret);
>>> +		goto out_disable_core_parent;
>>> +	}
>>> +	ret = clk_prepare_enable(new_dram_apb_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to enable new dram_apb parent: %d\n",
>>> +			ret);
>>> +		goto out_disable_alt_parent;
>>> +	}
>>> +
>>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);
>>> +
>>> +	/* update parents in clk tree after switch. */
>>> +	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
>>> +	if (ret)
>>> +		dev_warn(dev, "failed to set dram_core parent: %d\n", ret);
>>> +	if (new_dram_alt_parent) {
>>> +		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
>>> +		if (ret)
>>> +			dev_warn(dev, "failed to set dram_alt parent: %d\n",
>>> +				 ret);
>>> +	}
>>> +	if (new_dram_apb_parent) {
>>> +		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
>>> +		if (ret)
>>> +			dev_warn(dev, "failed to set dram_apb parent: %d\n",
>>> +				 ret);
>>> +	}
>>> +
>>> +	/*
>>> +	 * Explicitly refresh dram PLL rate.
>>> +	 *
>>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be
>>> +	 * automatically refreshed when clk_get_rate is called on children.
>>> +	 */
>>> +	clk_get_rate(priv->dram_pll);
>>> +
>>> +	/*
>>> +	 * clk_set_parent transfer the reference count from old parent.
>>> +	 * now we drop extra reference counts used during the switch
>>> +	 */
>>> +	clk_disable_unprepare(new_dram_apb_parent);
>>> +out_disable_alt_parent:
>>> +	clk_disable_unprepare(new_dram_alt_parent);
>>> +out_disable_core_parent:
>>> +	clk_disable_unprepare(new_dram_core_parent);
>>> +out:
>>> +	return ret;
>>> +}
>>> +
>>> +static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct imx8m_ddrc_freq *freq_info;
>>> +	struct dev_pm_opp *new_opp;
>>> +	unsigned long old_freq, new_freq;
>>> +	int ret;
>>> +
>>> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
>>> +	if (IS_ERR(new_opp)) {
>>> +		ret = PTR_ERR(new_opp);
>>> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +	dev_pm_opp_put(new_opp);
>>> +
>>> +	old_freq = clk_get_rate(priv->dram_core);
>>> +	if (*freq == old_freq)
>>> +		return 0;
>>> +
>>> +	freq_info = imx8m_ddrc_find_freq(priv, *freq);
>>> +	if (!freq_info)
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * Read back the clk rate to verify switch was correct and so that
>>> +	 * we can report it on all error paths.
>>> +	 */
>>> +	ret = imx8m_ddrc_set_freq(dev, freq_info);
>>> +
>>> +	new_freq = clk_get_rate(priv->dram_core);
>>> +	if (ret)
>>> +		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now at %lu\n",
>>> +			old_freq, *freq, ret, new_freq);
>>> +	else if (*freq != new_freq)
>>> +		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n",
>>> +			old_freq, *freq, new_freq);
>>> +	else
>>> +		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",
>>> +			*freq, old_freq);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +
>>> +	*freq = clk_get_rate(priv->dram_core);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx8m_ddrc_get_dev_status(struct device *dev,
>>> +				     struct devfreq_dev_status *stat)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +
>>> +	stat->busy_time = 0;
>>> +	stat->total_time = 0;
>>> +	stat->current_frequency = clk_get_rate(priv->dram_core);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx8m_ddrc_init_freq_info(struct device *dev)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct arm_smccc_res res;
>>> +	int index;
>>> +
>>> +	/* An error here means DDR DVFS API not supported by firmware */
>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,
>>> +			0, 0, 0, 0, 0, 0, &res);
>>> +	priv->freq_count = res.a0;
>>> +	if (priv->freq_count <= 0 ||
>>> +			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)
>>> +		return -ENODEV;
>>> +
>>> +	for (index = 0; index < priv->freq_count; ++index) {
>>> +		struct imx8m_ddrc_freq *freq = &priv->freq_table[index];
>>> +
>>> +		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,
>>> +			      index, 0, 0, 0, 0, 0, &res);
>>> +		/* Result should be strictly positive */
>>> +		if ((long)res.a0 <= 0)
>>> +			return -ENODEV;
>>> +
>>> +		freq->rate = res.a0;
>>> +		freq->smcarg = index;
>>> +		freq->dram_core_parent_index = res.a1;
>>> +		freq->dram_alt_parent_index = res.a2;
>>> +		freq->dram_apb_parent_index = res.a3;
>>> +
>>> +		/* dram_core has 2 options: dram_pll or dram_alt_root */
>>> +		if (freq->dram_core_parent_index != 1 &&
>>> +				freq->dram_core_parent_index != 2)
>>> +			return -ENODEV;
>>> +		/* dram_apb and dram_alt have exactly 8 possible parents */
>>> +		if (freq->dram_alt_parent_index > 8 ||
>>> +				freq->dram_apb_parent_index > 8)
>>> +			return -ENODEV;
>>> +		/* dram_core from alt requires explicit dram_alt parent */
>>> +		if (freq->dram_core_parent_index == 2 &&
>>> +				freq->dram_alt_parent_index == 0)
>>> +			return -ENODEV;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int imx8m_ddrc_check_opps(struct device *dev)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct imx8m_ddrc_freq *freq_info;
>>> +	struct dev_pm_opp *opp;
>>> +	unsigned long freq;
>>> +	int i, opp_count;
>>> +
>>> +	/* Enumerate DT OPPs and disable those not supported by firmware */
>>> +	opp_count = dev_pm_opp_get_opp_count(dev);
>>> +	if (opp_count < 0)
>>> +		return opp_count;
>>> +	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
>>> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>>> +		if (IS_ERR(opp)) {
>>> +			dev_err(dev, "Failed enumerating OPPs: %ld\n",
>>> +				PTR_ERR(opp));
>>> +			return PTR_ERR(opp);
>>> +		}
>>> +		dev_pm_opp_put(opp);
>>> +
>>> +		freq_info = imx8m_ddrc_find_freq(priv, freq);
>>> +		if (!freq_info) {
>>> +			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
>>> +					freq, DIV_ROUND_CLOSEST(freq, 250000));
>>> +			dev_pm_opp_disable(dev, freq);
>>> +		}
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void imx8m_ddrc_exit(struct device *dev)
>>> +{
>>> +	dev_pm_opp_of_remove_table(dev);
>>> +}
>>> +
>>> +static int imx8m_ddrc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct imx8m_ddrc *priv;
>>> +	const char *gov = DEVFREQ_GOV_USERSPACE;
>>> +	int ret;
>>> +
>>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	platform_set_drvdata(pdev, priv);
>>> +
>>> +	ret = imx8m_ddrc_init_freq_info(dev);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed to init firmware freq info: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	priv->dram_core = devm_clk_get(dev, "core");
>>> +	priv->dram_pll = devm_clk_get(dev, "pll");
>>> +	priv->dram_alt = devm_clk_get(dev, "alt");
>>> +	priv->dram_apb = devm_clk_get(dev, "apb");
>>> +	if (IS_ERR(priv->dram_core) ||
>>> +		IS_ERR(priv->dram_pll) ||
>>> +		IS_ERR(priv->dram_alt) ||
>>> +		IS_ERR(priv->dram_apb)) {
>>> +		ret = PTR_ERR(priv->devfreq);
>>> +		dev_err(dev, "failed to fetch clocks: %d\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = dev_pm_opp_of_add_table(dev);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "failed to get OPP table\n");
>>> +		return ret;
>>> +	}
>>> +
>>> +	ret = imx8m_ddrc_check_opps(dev);
>>> +	if (ret < 0)
>>> +		goto err;
>>> +
>>> +	priv->profile.polling_ms = 1000;
>>> +	priv->profile.target = imx8m_ddrc_target;
>>> +	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
>>> +	priv->profile.exit = imx8m_ddrc_exit;
>>> +	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
>>> +	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
>>> +
>>> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
>>> +						gov, NULL);
>>> +	if (IS_ERR(priv->devfreq)) {
>>> +		ret = PTR_ERR(priv->devfreq);
>>> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
>>> +		goto err;
>>> +	}
>>> +
>>> +	return 0;
>>> +
>>> +err:
>>> +	dev_pm_opp_of_remove_table(dev);
>>> +	return ret;
>>> +}
>>> +
>>> +static const struct of_device_id imx8m_ddrc_of_match[] = {
>>> +	{ .compatible = "fsl,imx8m-ddrc", },
>>> +	{ /* sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
>>> +
>>> +static struct platform_driver imx8m_ddrc_platdrv = {
>>> +	.probe		= imx8m_ddrc_probe,
>>> +	.driver = {
>>> +		.name	= "imx8m-ddrc-devfreq",
>>> +		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
>>> +	},
>>> +};
>>> +module_platform_driver(imx8m_ddrc_platdrv);
>>> +
>>> +MODULE_DESCRIPTION("i.MX8M DDR Controller frequency driver");
>>> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
>>> +MODULE_LICENSE("GPL v2");
>>>
>>
> 
> 
> 

Applied patch3/patch4 for v5.6-rc1. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
