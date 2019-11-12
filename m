Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAEEF859E
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 01:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKLAy3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 19:54:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:44263 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLAy3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 19:54:29 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191112005424epoutp02df5686000b5582712fbcc7b1cc048bf6~WRCl2sQnF0097300973epoutp02B
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 00:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191112005424epoutp02df5686000b5582712fbcc7b1cc048bf6~WRCl2sQnF0097300973epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573520064;
        bh=ra5PqLzI/pmTGFNyiCZA5UsMZNBaGlP5BhhnZGU26/U=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=DlQU+dc+NCA975s96+IsfLXUz+8YMT9DxdEtyAxq0VCQN7Fln0wseWa/nXmN9/Wnt
         W1BnabNkNPM33Z+tlcAIEDvKjryLXsYZGF/F66URVNL0n0BIFwyO75ZfFScA8/i7mb
         ZuahPAb4t8ihMH5tnqoFwTqpGt5IqhYGe1TZ870E=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191112005423epcas1p462510c8f2e837ab856b1958603ccee34~WRClGa8fr1929519295epcas1p4e;
        Tue, 12 Nov 2019 00:54:23 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 47Bq580fwGzMqYks; Tue, 12 Nov
        2019 00:54:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.4E.04224.BB20ACD5; Tue, 12 Nov 2019 09:54:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20191112005419epcas1p21f12ea978afda0f453e05fa78645a917~WRChGyT6X2388223882epcas1p2f;
        Tue, 12 Nov 2019 00:54:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191112005419epsmtrp1dc59ebe4a1cf81c9ef28271b89d90d08~WRChFZ44Q1959919599epsmtrp1O;
        Tue, 12 Nov 2019 00:54:19 +0000 (GMT)
X-AuditID: b6c32a38-d43ff70000001080-08-5dca02bb5d53
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.D4.24756.BB20ACD5; Tue, 12 Nov 2019 09:54:19 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191112005419epsmtip2f92911e6608c258c1565a8cf625eada5~WRCgkpgfN2457624576epsmtip2f;
        Tue, 12 Nov 2019 00:54:19 +0000 (GMT)
Subject: Re: [PATCH v4 4/6] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <45f4471b-55b2-498a-463c-2adbd03e84df@samsung.com>
Date:   Tue, 12 Nov 2019 10:00:06 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB7023A07C682C9DA006D1BEF1EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRj2tPfetmSVuzLk2GQbu7ofIwF7Vz7ODEwXwdzEJUP9Y1iQXeGm
        EPqV3pYMljgkGZTKZJORWRwbieNjBedaYIApQTpkUAQEsoLr5sASZahMxLoxHbHtxaT/nvc8
        z/uc93lPjlSs+EailJbozZxJz2opIga7eetASrJb5M1X1T8WIc9orwQFJ7wAtc1+C9BfjV+L
        UeCBH6A+eyG6MjKFI2e3H0MXB10EcjQOYGh6+oYETVb9JkEd99dx5Ar4cLRe9yOObE+vidHG
        2RGAWudnRMjXcR5HGzcCAM14c5D/ow4CdU4NE+i7iVkcnRkckSCb5xmBtnxODK30JCBnkHl9
        N9No6wBM1+UuwDxaOCNhPq+cwZgWl4VxOWoJ5p7PTTDdV08zzrV+ETO85hYx9c9UzNNb8UzP
        nRqM+aTHAZgN157c2LzSzGKOLeJMiZy+0FBUotdkUW+9W/BGQVq6ik6mD6EMKlHP6rgsKvto
        bvKbJdrQeqjEMlZrCR3lsjxPvXI402SwmLnEYgNvzqI4Y5HWeMiYwrM63qLXpBQadK/SKtXB
        tJDwRGnxp1fHcOPmV+Bkb/VjUAnqq4ENSKWQTIV9/vdtIEaqIPsBdLQt4TYgCxV/AtgdLBWI
        vwF0Lt8jwkS4wde6BQRiEMDR621ioXgE4OWHflFYFUe+Bxt+GohY7SJzoffsL5EOMdkug0tr
        q5IwQZBJcGhlIWIbS+6Dd54EQBjLycPwwpA7YoSR++HdB9cl4VnjQ6YTQVaQ7ITj9mUsjGVk
        PhwIWCOWYjIF/uxtwgScAO8uXxEJeC/s+/1SZFBIjklh+8Xm7TjZ8N+qzzABx8HV2z0SASvh
        w/rqbXwKXhsfIYRmK4A9Q9/jAqGGQ60NIgHvgwP/NAPhtufhWrAOFxYsh9ZqhSB5Cc4t3t+W
        vwi/qKklzgGqKSpPU1SGpqgMTVEZWgDmAC9wRl6n4XjamBr94C4Q+T1JqB+4p456ACkF1A75
        cyfG8xU4W8aX6zwASsXULnn/ybF8hbyILa/gTIYCk0XL8R6QFlr3ebEyvtAQ+ot6cwGddlCt
        VqNUOj2NpqkE+ZH21nwFqWHNXCnHGTnT/30iqUxZCXKyyzvbFqzzK6+l55mXE3zNG6s7LPbj
        sMIbOFdWO+xfmbfHzU4dmdN/IPtB/7Li9vHRmzlme17A9E5c6sc1Xwa7Fueqxk5npG+eWvrj
        197plg93qjMmV2lon1mMf1KD75ljuzaPNWSqDqxf2G8djLnUqdmbU8H2Tsbu3opVut6uozC+
        mKWTxCae/Q+r8FLpUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTURzHObvPrYa3qXgsyloUZLUcSRykF2R1IrIHQQ8adpkXtdy03TQT
        QntoOTTNXNasLJi1tJfz/SKcZmmZaLhMK6ElZdR6rMhHRW4a+N8Hfp/P+f5zWEJRSs1kY/WH
        BYOej1PSMrKqWRm0tF7SrgkpehuA7K2VDPr5pB2gG90PAfphqiOQc6AfoOpLWlTU8oxCZeX9
        JCpotNGoxFRLos7O+wzqOPGJQdbX3yhkczoo9C3rDYWMo7cI5M5uAaj4RZcEOaznKOS+7wSo
        q3096j9upVHpsyYaPX3STaH0xhYGGe1/aPTXUUaiDxUBqOwnXjsbm4xWgG9fvQ3wl950Bhem
        dZH4mi0R20oyafzK0UDjcksqLnPVSHCTq0GCc/6E4NFmf1zRc5rEZytKAHbb5mzz2StbGSXE
        xSYJhmWr98ti8iyPqYSReyC5MuMXSAM5GcAIpCzkQqGj+O84y1gFVw/g97riyUMgvND1kDAC
        dpx9YXOzOOF8BvDiVzfpcXy53fD821rKw35cBGzqafA+RHB3pNA8ZGImio8SWJXVRnssmguG
        Dz70etmHmwd7hp3eNTm3GuY/aJB4mOQWwL6Bu4yH/ccX3lf3TjozYNuld95lKaeBtc4zXofg
        lsAM93XJBAfAvndFkxwEqz9fJnKBr3lKbp6SmKck5inJNUCWgEAhQdRF60R1glovHFGJvE5M
        1EertPE6G/B+oeBFNeC5JdIOOBYop8utmjaNguKTxKM6O4AsofST1yQ/1ijkUfzRFMEQH2lI
        jBNEO5jFksoA+aC+dY+Ci+YPCwcFIUEw/L9KWOnMNLCmX8Hs+/1ddbPSn7m85dhQeCy9sEYb
        Glaoiq4bGFw1GMPmZprl1Ia5MyJTWlOPO0dWbN45B9o7TplafdZGlGYtnpa3ayxqx0nLgUdV
        LxuzY/1C+B5XmEu7buvG+Zv4/PAUF5F+aLg48wo/fET9aro1zby9HNeP9YVljvHLC97nKUkx
        hlcHEwaR/weoHGjLPgMAAA==
X-CMS-MailID: 20191112005419epcas1p21f12ea978afda0f453e05fa78645a917
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191108224026epcas1p35263d69e63d2e7357f82b2e41d9efe07
References: <cover.1573252696.git.leonard.crestez@nxp.com>
        <CGME20191108224026epcas1p35263d69e63d2e7357f82b2e41d9efe07@epcas1p3.samsung.com>
        <675f35b1e92f49e0d7889675c87e944d454d4e38.1573252696.git.leonard.crestez@nxp.com>
        <9eeb496b-2d7e-590c-3e9e-765a9e996481@samsung.com>
        <VI1PR04MB7023A07C682C9DA006D1BEF1EE740@VI1PR04MB7023.eurprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/12/19 2:23 AM, Leonard Crestez wrote:
> On 11.11.2019 05:18, Chanwoo Choi wrote:
>> Hi Leonard,
>>
>> On 11/9/19 7:39 AM, Leonard Crestez wrote:
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
>>>   drivers/devfreq/Kconfig      |  10 +
>>>   drivers/devfreq/Makefile     |   1 +
>>>   drivers/devfreq/imx8m-ddrc.c | 416 +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 427 insertions(+)
>>>   create mode 100644 drivers/devfreq/imx8m-ddrc.c
>>>
>>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>>> index defe1d438710..c519fd27808f 100644
>>> --- a/drivers/devfreq/Kconfig
>>> +++ b/drivers/devfreq/Kconfig
>>> @@ -90,10 +90,20 @@ config ARM_EXYNOS_BUS_DEVFREQ
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
>>> +	select PM_OPP
>>
>> It doesn't need to add. CONFIG_DEVFREQ add 'select PM_OPP'
>> because 'PM_OPP' is mandatory for devfreq.
> 
> OK.
> 
> All other drivers select PM_OPP, this was just copied
> 
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
>>> index 000000000000..51903fee21a7
>>> --- /dev/null
>>> +++ b/drivers/devfreq/imx8m-ddrc.c
>>> @@ -0,0 +1,416 @@
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
>>
>> local_irq_disable is more proper than local_irq_save()?
> 
> There's no need to use save/restore because we know that irqs are 
> enabled when entering the function. This is only called from devfreq 
> set_target which runs in process context.

local_irq might affect the whole architecture and other running device driver
which requires the some CPU irq at the same time. Don't need to save the irqflag?

> 
>>
>>> +
>>> +	for_each_online_cpu(cpu)
>>> +		online_cpus |= (1 << (cpu * 8));
>>> +
>>> +	/* change the ddr freqency */
>>> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,
>>> +			0, 0, 0, 0, 0, &res);
>>> +
>>> +	local_irq_enable();
>>
>> ditto. local_irq_restore() instead of local_irq_enable()
>>
>>> +}
>>> +
>>> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)
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
>>> +	new_dram_core_parent = clk_get_parent_by_index(
>>  > You can use 'clk_hw_get_parent_by_index' directly.
> 
> The helper above avoids duplicating ?:

I think that it is not duplicate. You use 'clk_hw_get_parent_by_index' function
and check the return value. it is essential behavior.

> 
>> And, you need to check whether the return value is NULL or not.
> Yes for dram_core_parent but others are deliberately allowed to be NULL. 
> For some setpoints some parents might be indifferent or require no 
> changes. For example when dram_core has pll as parent the expectation is 
> that dram_all will be OFF so parent is irrelevant.

If all case is not same as you commented, you just add the proper dev_warn
or dev_info message according to the h/w characteristic. Because user 
cannot know the detailed reason why don't check the return value.


> 
> Driver relies on the fact that clock API ignores prepare/enable for NULL 
> clocks. I can add a comment explaining that.
> 
>>> +			priv->dram_core, freq->dram_core_parent_index - 1);
>>> +	new_dram_alt_parent = clk_get_parent_by_index(
>>
>> ditto.
>>
>>> +			priv->dram_alt, freq->dram_alt_parent_index - 1);
>>> +	new_dram_apb_parent = clk_get_parent_by_index(
>>
>> ditto.
> 
>>> +			priv->dram_apb, freq->dram_apb_parent_index - 1);
>>> +
>>> +	/* increase reference counts and ensure clks are ON before switch */
>>> +	ret = clk_prepare_enable(new_dram_core_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);
>>> +		goto out;
>>> +	}
>>> +	ret = clk_prepare_enable(new_dram_alt_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);
>>> +		goto out_dis_core;
>>
>> I think that 'dis' is not general expression for 'disable'.
>> Just, I think that 'out_disable_core' is better than 'out_dis_core'.
> 
> OK
> 
>>> +	}
>>> +	ret = clk_prepare_enable(new_dram_apb_parent);
>>> +	if (ret) {
>>> +		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);
>>> +		goto out_dis_alt;
>>
>> ditto.
>>
>>> +	}
>>> +
>>> +	imx8m_ddrc_smc_set_freq(freq->smcarg);
>>> +
>>> +	/* update parents in clk tree after switch. */
>>> +	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
>>> +	if (ret)
>>> +		dev_err(dev, "failed set dram_core parent: %d\n", ret);
>>
>> if you don't return directly, you better to use 'dev_warn' instead of 'dev_err'.
> 
> OK.
> 
>>> +	if (new_dram_alt_parent) {
>>> +		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
>>> +		if (ret)
>>> +			dev_err(dev, "failed set dram_alt parent: %d\n", ret);
>>
>> ditto. Use dev_warn.
>>   
>>> +	}
>>> +	if (new_dram_apb_parent) {
>>> +		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
>>> +		if (ret)
>>> +			dev_err(dev, "failed set dram_apb parent: %d\n", ret);
>>
>> ditto. Use dev_warn.
>>
>>> +	}
>>> +
>>> +	/*
>>> +	 * Explicitly refresh dram PLL rate.
>>> +	 *
>>> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be
>>
>> nitpick:
>> What is more proper description either or 'Even if' or 'if' ?
> 
> Rate updates work for dram_alt/apb but not for dram_pll because 
> additional clocks might be present between the PLL and dram_core mux. 
> This happens *even if* pll is marked with CLK_GET_RATE_NOCACHE.

ok.

> 
>>> +	 * automatically refreshed when clk_get_rate is called on children.
>>> +	 */
>>> +	clk_get_rate(priv->dram_pll);
>>> +
>>> +	/*
>>> +	 * clk_set_parent transfer the reference count from old parent.
>>> +	 * now we drop extra reference counts used during the switch
>>> +	 */
>>> +	clk_disable_unprepare(new_dram_apb_parent);
>>> +out_dis_alt:
>>> +	clk_disable_unprepare(new_dram_alt_parent);
>>> +out_dis_core:
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
>>> +	ret = imx8m_ddrc_set_freq(dev, freq_info);
>>
>> Need to check whether 'ret' is valid or not.
>>
>>> +
>>> +	/* Also read back the clk rate to verify switch was correct */
>>> +	new_freq = clk_get_rate(priv->dram_core);
>>> +	if (ret || *freq != new_freq)
>>
>> You should check 'ret' right after imx8m_ddrc_set_freq()
>> instead of this position.
> 
> OK, I can add two error paths.
> 
>>> +		dev_err(dev, "ddrc failed freq set to %lu from %lu, now at %lu\n",
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
>>> +static int imx8m_ddrc_init_freq_info(struct device *dev)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct arm_smccc_res res;
>>> +	int index;
>>> +
>>> +	/*
>>> +	 * An error here means DDR DVFS API not supported by firmware
>>> +	 */
>>
>> Don't need to add multiple line comments. It is possible to be change as following:
>>
>> 	/* An error here means DDR DVFS API not supported by firmware */
> 
> OK.
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
>>> +				index, 0, 0, 0, 0, 0, &res);
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
>>> +/* imx8m_ddrc_check_opps() - disable OPPs not supported by firmware */
>>
>> nitpick:
>> On this driver, there are no some description for internal function.
>> In order to keep the coding style, you better to move this comment
>> into function before 'freq = ULONG_MAX'.
> 
> Is it a problem if only some internal functions have documentation? I 
> can add docs to more functions.

It is not problem. It is just preferable way to add the comment.
Usually, if the function is public and exported, I added the detailed
function comment as following example of devfreq_add_device().

/**                                                                             
 656  * devfreq_add_device() - Add devfreq feature to the device                     
 657  * @dev:        the device to add devfreq feature.                              
 658  * @profile:    device-specific profile to run devfreq.                         
 659  * @governor_name:      name of the policy to choose frequency.                 
 660  * @data:       private data for the governor. The devfreq framework does not   
 661  *              touch this value.                                               
 662  */                                                                             
 663 struct devfreq *devfreq_add_device(struct device *dev,                          
 664                                    struct devfreq_dev_profile *profile,         
 665                                    const char *governor_name,                   
 666                                    void *data)              


Otherwise, if function is used in the only local with static keyword,
usually I don't add the above detailed description. Instead,
add the detailed comment into the function.

It is not the standard way. Just preferable way for the function description
if possible.



> 
> BTW: how can I generate devfreq documentation from these comments?
> 
>>> +static int imx8m_ddrc_check_opps(struct device *dev)
>>> +{
>>> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>>> +	struct imx8m_ddrc_freq *freq_info;
>>> +	struct dev_pm_opp *opp;
>>> +	unsigned long freq;
>>> +
>>> +	freq = ULONG_MAX;
>>> +	while (true) {
>>> +		opp = dev_pm_opp_find_freq_floor(dev, &freq);
>>> +		if (opp == ERR_PTR(-ERANGE))
>>> +			break;
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
>>> +
>>> +		freq--;
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
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
