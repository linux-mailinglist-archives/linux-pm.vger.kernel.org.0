Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9EFD26F
	for <lists+linux-pm@lfdr.de>; Fri, 15 Nov 2019 02:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfKOB0R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Nov 2019 20:26:17 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:58520 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfKOB0R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Nov 2019 20:26:17 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20191115012612epoutp0376957da0229f44c297cd7c85b1f3db14~XMaNA6nQo3137431374epoutp033
        for <linux-pm@vger.kernel.org>; Fri, 15 Nov 2019 01:26:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20191115012612epoutp0376957da0229f44c297cd7c85b1f3db14~XMaNA6nQo3137431374epoutp033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573781172;
        bh=CIXbiSD9rBDyaG68RlgG320HIrdkqQoPFPzde4BmWbs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uasawRORsP1xayFNMramSKMPSaAAAKHFUwxd+E1iWkjkdLCmKnKK/hXzv9LOVCmIu
         wFnKuGI1T+qn0w9rcw1MRaffk4OftGR58s1i6iBNYHSPsSUg8pQbQf6HHQ5C786ot7
         THFtEpUrpcoN0L5yPhvx530RP5kVEFxTIxNy4970=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191115012611epcas1p3a4f05858ab6b876e5c18380c2f3695c0~XMaMSB54v1818718187epcas1p3X;
        Fri, 15 Nov 2019 01:26:11 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.154]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 47DgfV1KZhzMqYkf; Fri, 15 Nov
        2019 01:26:10 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.29.04085.2BEFDCD5; Fri, 15 Nov 2019 10:26:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20191115012609epcas1p1aba40498514fe80375435594c40298d7~XMaKzjd_S2566525665epcas1p1k;
        Fri, 15 Nov 2019 01:26:09 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191115012609epsmtrp18849165c0a31d85bf8705f4ea131332e~XMaKyV5_r1439914399epsmtrp1d;
        Fri, 15 Nov 2019 01:26:09 +0000 (GMT)
X-AuditID: b6c32a37-287189c000000ff5-01-5dcdfeb2bac3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.66.25663.1BEFDCD5; Fri, 15 Nov 2019 10:26:09 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191115012608epsmtip1bf1503054a9ba87618d90dbe0d766aa4~XMaKGuLOm0765707657epsmtip1v;
        Fri, 15 Nov 2019 01:26:08 +0000 (GMT)
Subject: Re: [PATCH v6 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
 controller
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
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
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <b0146aad-f9f5-875e-74aa-5afc4ccafb2e@samsung.com>
Date:   Fri, 15 Nov 2019 10:31:53 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3b1341a9a0c0dcaae1f37aebff25b773db7429cf.1573756360.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRTO2/vRMle5K1Bea4LsGqOgbC1d2csci3ObXnUmzK8YFfGm3BRC
        v9LbEuc0Ig42GnQMZcs6x9BZ13UYoXSjTAgCZY7vgVlBcLCMGSdfY3QsCwZmL3dG/j3PeZ9z
        nnPOmyPDFK1SlSzPbOdsZtZIk2vw8+1J6hTfcm+WuqpRhtounpOihe4ugH4Y7ADoTuUFDE2M
        jwLUcEyPTgb7CFRXP4qjo80+EnkrG3HU318rRb1F01LkuXqbQL6JEIFul40RyLl4BkPhL4IA
        uYcGJCjkOUygcO0EQANdu9DoZx4Sne1rJVFP9yCBipuDUuRsWyLRcqgORzf98ch9KoShugXm
        uQSm0ukBTE1VDWBuDRdLmeOFAzhT7XMwPm8pyfwRaiKZ+u8/ZepmAxKmdbZJwhxaUjOL7XGM
        /8oBnPnS7wVM2JeQGf1O/tZcjs3hbImcWW/JyTMbMuhXXs/eka1LU2tSNOloM51oZk1cBr1z
        d2bKC3nGyI7oxALW6IiEMlmepzdu22qzOOxcYq6Ft2fQnDXHaE23buBZE+8wGzboLaYtGrU6
        VRcRfpCfO3l9GreWlIMPe0qryELQanYCmQxSm+DkFOkEa2QKKgDg7x0+qUjmI6SnO0KiIuQu
        gO1zawUsJHT8VY+LomYAry1dBCK5BeCJqc8lgiqGehuOjN8nBItYygbLOpMFDUbdl8Lz1Zcw
        QUNSybDl5jAp4GhqPbxybwIIWE5tgxVFXSt1cOoJ2FTesFInLlKze4EVJetg57EbuICjqPfh
        QIt3pSRGxcORGyclIn4MNsx8gwm+kArK4LfVYxJxgp1wPNCAiTgGTv7ql4pYBf8+VPIA74Nn
        OoOkmHwQQH/LZUJ80MIW91cSoSGMSoI/XdgohtfDxn9OANH4YTi7UEaI65XDgyUKUfI4/O3a
        1QctPAJPHSglywHtWjWOa9UIrlUjuP43qwa4Fyg5K28ycLzGql392T6wcj7JmwOgtm93G6Bk
        gF4rhyO9WQqCLeD3mtoAlGF0rPzrmZ4shTyH3fsRZ7Nk2xxGjm8DusiyD2OqOL0lcoxme7ZG
        l6rVatEmTZpOo6Hj5dtPu7MUlIG1c/kcZ+Vs/+VJZFGqQvDkuRzP8o6xgnspyk9mlXv2X2eL
        oHb6tZ/vwl7D9KM6o7+sf3jooQrT4I9HGt+bipkfTm3Qv+g+rX/qjT9furz/l+LR43teVrme
        +e5dZXp4bAvev3jHELuOxyv20Wkfzw1dSgpwr0renJnvr9meYK0klgLhZ8/WzbU8rZS+9Xw4
        rI120Dify2qSMRvP/gv6enBYVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XYuOxsOj9Php4XSoIJBXsIfHyVSP7TzU/qVgdnKw2Zuc+2o
        qQWZYOW6aJGJVmp5YU0zd7GZt+W8YN4nuMQrOEEJZ6QJIV5y08B/D7zP875/XgoTfyZCqTRN
        JqvTyFVSUoh/6ZGGnTHtjiRHvd87gRz9LXy0OTQIUP1EH0B/Stsw5F6YAchWfhNV9Y4SyGSZ
        wVFZp5lExtKvOBoba+ajkYJVPjLM/SaQ2e0i0O+n8wTSb33E0MazXoDqfjh5yGV4QaCNZjdA
        zsF4NPPAQKKG0W4SDQ9NEKiws5eP9I4dEu26TDhasQajuhoXhkybzIUwplRvAExjZSNgfk0V
        8pk3+U6cqTZnMWZjEcnMujpIxlJ7nzGttfKY7rUOHlO8E8Vs9UgY6+QjnHluNQJmwxyW6H9V
        GJvKqtKyWV1k3HWh8ufiKq59WAJyhosqyXzQrdEDAQXpGNi3bMH1QEiJ6XYALc175MEgBL52
        9mF6QO1zIOzp4Q4cD4AG2zfC6wTSV+D0wp6Pg2gdbKsv5nsljC6k4Kehcv5BsQjgqL6A57VI
        WgbtK1O+C/70CTj51w28LKLj4MuCQZ+D0ydhR4nNt1Wyf2HZNnXoBMDv5Uu4lwX0Nei0GzEv
        Y/RpuF05ccjBcHqpinfA4dDmeYuVgMCKI3nFkaTiSFJxJKkGuBGEsFpOrVBz0dqzGvZOBCdX
        c1kaRcTNDLUZ+N5IJmsFAwMpDkBTQOongtMjyWJCns3lqh0AUpg0SPTKM5wsFqXKc/NYXUaK
        LkvFcg5wjMKlwaLwjP4kMa2QZ7LpLKtldf+nPEoQmg9iYMz2I4+Ee1Z0Pj0wIRbqPihuzCUQ
        wvJTT2bD7+VFnsv3FJnTB8ZpydTF9nVnX+p6U1V9/LoKXF3EGjskl5NuCbourSs1qT/ualrs
        ozbl3tb4ceu4/0a8n1KwajH13t6qfWxvcKt2Np82/ZLO58jKumoCat5JFJ6BnMQyVopzSnm0
        DNNx8n8LCHBZQgMAAA==
X-CMS-MailID: 20191115012609epcas1p1aba40498514fe80375435594c40298d7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114183341epcas1p362ecf4d86e6bdb9352f2a4b932f3204e
References: <cover.1573756360.git.leonard.crestez@nxp.com>
        <CGME20191114183341epcas1p362ecf4d86e6bdb9352f2a4b932f3204e@epcas1p3.samsung.com>
        <3b1341a9a0c0dcaae1f37aebff25b773db7429cf.1573756360.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

After reviewing the dt-binding patch from DT maintainer,
I'll take patch3/patch4 to devfreq git. 

Or, Should I have to finish the review of patch1/patch2?

Regards,
Chanwoo Choi

On 11/15/19 3:33 AM, Leonard Crestez wrote:
> Add driver for dynamic scaling the DDR Controller on imx8m chips. Actual
> frequency switching is implemented inside TF-A, this driver wraps the
> SMC calls and synchronizes the clk tree.
> 
> The DRAM clocks on imx8m have the following structure (abridged):
> 
>  +----------+       |\            +------+
>  | dram_pll |-------|M| dram_core |      |
>  +----------+       |U|---------->| D    |
>                  /--|X|           |  D   |
>    dram_alt_root |  |/            |   R  |
>                  |                |    C |
>             +---------+           |      |
>             |FIX DIV/4|           |      |
>             +---------+           |      |
>   composite:     |                |      |
>  +----------+    |                |      |
>  | dram_alt |----/                |      |
>  +----------+                     |      |
>  | dram_apb |-------------------->|      |
>  +----------+                     +------+
> 
> The dram_pll is used for higher rates and dram_alt is used for lower
> rates. The dram_alt and dram_apb clocks are "imx composite" and their
> parent can also be modified.
> 
> This driver will prepare/enable the new parents ahead of switching (so
> that the expected roots are enabled) and afterwards it will call
> clk_set_parent to ensure the parents in clock framework are up-to-date.
> 
> The driver relies on dram_pll dram_alt and dram_apb being marked with
> CLK_GET_RATE_NOCACHE for rate updates.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/Kconfig      |   9 +
>  drivers/devfreq/Makefile     |   1 +
>  drivers/devfreq/imx8m-ddrc.c | 465 +++++++++++++++++++++++++++++++++++
>  3 files changed, 475 insertions(+)
>  create mode 100644 drivers/devfreq/imx8m-ddrc.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 066e6c4efaa2..923a6132e741 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -89,10 +89,19 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  Each memory bus group could contain many memoby bus block. It reads
>  	  PPMU counters of memory controllers by using DEVFREQ-event device
>  	  and adjusts the operating frequencies and voltages with OPP support.
>  	  This does not yet operate with optimal voltages.
>  
> +config ARM_IMX8M_DDRC_DEVFREQ
> +	tristate "i.MX8M DDRC DEVFREQ Driver"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select DEVFREQ_GOV_USERSPACE
> +	help
> +	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
> +	  adjusting DRAM frequency.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 338ae8440db6..3eb4d5e6635c 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
>  # DEVFREQ Event Drivers
> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
> new file mode 100644
> index 000000000000..fea169619c59
> --- /dev/null
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -0,0 +1,465 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/devfreq.h>
> +#include <linux/pm_opp.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/arm-smccc.h>
> +
> +#define IMX_SIP_DDR_DVFS			0xc2000004
> +
> +/* Values starting from 0 switch to specific frequency */
> +#define IMX_SIP_DDR_FREQ_SET_HIGH		0x00
> +
> +/* Deprecated after moving IRQ handling to ATF */
> +#define IMX_SIP_DDR_DVFS_WAIT_CHANGE		0x0F
> +
> +/* Query available frequencies. */
> +#define IMX_SIP_DDR_DVFS_GET_FREQ_COUNT		0x10
> +#define IMX_SIP_DDR_DVFS_GET_FREQ_INFO		0x11
> +
> +/*
> + * This should be in a 1:1 mapping with devicetree OPPs but
> + * firmware provides additional info.
> + */
> +struct imx8m_ddrc_freq {
> +	unsigned long rate;
> +	unsigned long smcarg;
> +	int dram_core_parent_index;
> +	int dram_alt_parent_index;
> +	int dram_apb_parent_index;
> +};
> +
> +/* Hardware limitation */
> +#define IMX8M_DDRC_MAX_FREQ_COUNT 4
> +
> +/*
> + * i.MX8M DRAM Controller clocks have the following structure (abridged):
> + *
> + * +----------+       |\            +------+
> + * | dram_pll |-------|M| dram_core |      |
> + * +----------+       |U|---------->| D    |
> + *                 /--|X|           |  D   |
> + *   dram_alt_root |  |/            |   R  |
> + *                 |                |    C |
> + *            +---------+           |      |
> + *            |FIX DIV/4|           |      |
> + *            +---------+           |      |
> + *  composite:     |                |      |
> + * +----------+    |                |      |
> + * | dram_alt |----/                |      |
> + * +----------+                     |      |
> + * | dram_apb |-------------------->|      |
> + * +----------+                     +------+
> + *
> + * The dram_pll is used for higher rates and dram_alt is used for lower rates.
> + *
> + * Frequency switching is implemented in TF-A (via SMC call) and can change the
> + * configuration of the clocks, including mux parents. The dram_alt and
> + * dram_apb clocks are "imx composite" and their parent can change too.
> + *
> + * We need to prepare/enable the new mux parents head of switching and update
> + * their information afterwards.
> + */
> +struct imx8m_ddrc {
> +	struct devfreq_dev_profile profile;
> +	struct devfreq *devfreq;
> +
> +	/* For frequency switching: */
> +	struct clk *dram_core;
> +	struct clk *dram_pll;
> +	struct clk *dram_alt;
> +	struct clk *dram_apb;
> +
> +	int freq_count;
> +	struct imx8m_ddrc_freq freq_table[IMX8M_DDRC_MAX_FREQ_COUNT];
> +};
> +
> +static struct imx8m_ddrc_freq *imx8m_ddrc_find_freq(struct imx8m_ddrc *priv,
> +						    unsigned long rate)
> +{
> +	struct imx8m_ddrc_freq *freq;
> +	int i;
> +
> +	/*
> +	 * Firmware reports values in MT/s, so we round-down from Hz
> +	 * Rounding is extra generous to ensure a match.
> +	 */
> +	rate = DIV_ROUND_CLOSEST(rate, 250000);
> +	for (i = 0; i < priv->freq_count; ++i) {
> +		freq = &priv->freq_table[i];
> +		if (freq->rate == rate ||
> +				freq->rate + 1 == rate ||
> +				freq->rate - 1 == rate)
> +			return freq;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void imx8m_ddrc_smc_set_freq(int target_freq)
> +{
> +	struct arm_smccc_res res;
> +	u32 online_cpus = 0;
> +	int cpu;
> +
> +	local_irq_disable();
> +
> +	for_each_online_cpu(cpu)
> +		online_cpus |= (1 << (cpu * 8));
> +
> +	/* change the ddr freqency */
> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, target_freq, online_cpus,
> +			0, 0, 0, 0, 0, &res);
> +
> +	local_irq_enable();
> +}
> +
> +static struct clk *clk_get_parent_by_index(struct clk *clk, int index)
> +{
> +	struct clk_hw *hw;
> +
> +	hw = clk_hw_get_parent_by_index(__clk_get_hw(clk), index);
> +
> +	return hw ? hw->clk : NULL;
> +}
> +
> +static int imx8m_ddrc_set_freq(struct device *dev, struct imx8m_ddrc_freq *freq)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +	struct clk *new_dram_core_parent;
> +	struct clk *new_dram_alt_parent;
> +	struct clk *new_dram_apb_parent;
> +	int ret;
> +
> +	/*
> +	 * Fetch new parents
> +	 *
> +	 * new_dram_alt_parent and new_dram_apb_parent are optional but
> +	 * new_dram_core_parent is not.
> +	 */
> +	new_dram_core_parent = clk_get_parent_by_index(
> +			priv->dram_core, freq->dram_core_parent_index - 1);
> +	if (!new_dram_core_parent) {
> +		dev_err(dev, "failed to fetch new dram_core parent\n");
> +		return -EINVAL;
> +	}
> +	if (freq->dram_alt_parent_index) {
> +		new_dram_alt_parent = clk_get_parent_by_index(
> +				priv->dram_alt,
> +				freq->dram_alt_parent_index - 1);
> +		if (!new_dram_alt_parent) {
> +			dev_err(dev, "failed to fetch new dram_alt parent\n");
> +			return -EINVAL;
> +		}
> +	} else
> +		new_dram_alt_parent = NULL;
> +
> +	if (freq->dram_apb_parent_index) {
> +		new_dram_apb_parent = clk_get_parent_by_index(
> +				priv->dram_apb,
> +				freq->dram_apb_parent_index - 1);
> +		if (!new_dram_apb_parent) {
> +			dev_err(dev, "failed to fetch new dram_apb parent\n");
> +			return -EINVAL;
> +		}
> +	} else
> +		new_dram_apb_parent = NULL;
> +
> +	/* increase reference counts and ensure clks are ON before switch */
> +	ret = clk_prepare_enable(new_dram_core_parent);
> +	if (ret) {
> +		dev_err(dev, "failed to enable new dram_core parent: %d\n",
> +			ret);
> +		goto out;
> +	}
> +	ret = clk_prepare_enable(new_dram_alt_parent);
> +	if (ret) {
> +		dev_err(dev, "failed to enable new dram_alt parent: %d\n",
> +			ret);
> +		goto out_disable_core_parent;
> +	}
> +	ret = clk_prepare_enable(new_dram_apb_parent);
> +	if (ret) {
> +		dev_err(dev, "failed to enable new dram_apb parent: %d\n",
> +			ret);
> +		goto out_disable_alt_parent;
> +	}
> +
> +	imx8m_ddrc_smc_set_freq(freq->smcarg);
> +
> +	/* update parents in clk tree after switch. */
> +	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
> +	if (ret)
> +		dev_warn(dev, "failed to set dram_core parent: %d\n", ret);
> +	if (new_dram_alt_parent) {
> +		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
> +		if (ret)
> +			dev_warn(dev, "failed to set dram_alt parent: %d\n",
> +				 ret);
> +	}
> +	if (new_dram_apb_parent) {
> +		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
> +		if (ret)
> +			dev_warn(dev, "failed to set dram_apb parent: %d\n",
> +				 ret);
> +	}
> +
> +	/*
> +	 * Explicitly refresh dram PLL rate.
> +	 *
> +	 * Even if it's marked with CLK_GET_RATE_NOCACHE the rate will not be
> +	 * automatically refreshed when clk_get_rate is called on children.
> +	 */
> +	clk_get_rate(priv->dram_pll);
> +
> +	/*
> +	 * clk_set_parent transfer the reference count from old parent.
> +	 * now we drop extra reference counts used during the switch
> +	 */
> +	clk_disable_unprepare(new_dram_apb_parent);
> +out_disable_alt_parent:
> +	clk_disable_unprepare(new_dram_alt_parent);
> +out_disable_core_parent:
> +	clk_disable_unprepare(new_dram_core_parent);
> +out:
> +	return ret;
> +}
> +
> +static int imx8m_ddrc_target(struct device *dev, unsigned long *freq, u32 flags)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +	struct imx8m_ddrc_freq *freq_info;
> +	struct dev_pm_opp *new_opp;
> +	unsigned long old_freq, new_freq;
> +	int ret;
> +
> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(new_opp)) {
> +		ret = PTR_ERR(new_opp);
> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
> +		return ret;
> +	}
> +	dev_pm_opp_put(new_opp);
> +
> +	old_freq = clk_get_rate(priv->dram_core);
> +	if (*freq == old_freq)
> +		return 0;
> +
> +	freq_info = imx8m_ddrc_find_freq(priv, *freq);
> +	if (!freq_info)
> +		return -EINVAL;
> +
> +	/*
> +	 * Read back the clk rate to verify switch was correct and so that
> +	 * we can report it on all error paths.
> +	 */
> +	ret = imx8m_ddrc_set_freq(dev, freq_info);
> +
> +	new_freq = clk_get_rate(priv->dram_core);
> +	if (ret)
> +		dev_err(dev, "ddrc failed freq switch to %lu from %lu: error %d. now at %lu\n",
> +			old_freq, *freq, ret, new_freq);
> +	else if (*freq != new_freq)
> +		dev_err(dev, "ddrc failed freq update to %lu from %lu, now at %lu\n",
> +			old_freq, *freq, new_freq);
> +	else
> +		dev_dbg(dev, "ddrc freq set to %lu (was %lu)\n",
> +			*freq, old_freq);
> +
> +	return ret;
> +}
> +
> +static int imx8m_ddrc_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(priv->dram_core);
> +
> +	return 0;
> +}
> +
> +static int imx8m_ddrc_get_dev_status(struct device *dev,
> +				     struct devfreq_dev_status *stat)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +
> +	stat->busy_time = 0;
> +	stat->total_time = 0;
> +	stat->current_frequency = clk_get_rate(priv->dram_core);
> +
> +	return 0;
> +}
> +
> +static int imx8m_ddrc_init_freq_info(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +	struct arm_smccc_res res;
> +	int index;
> +
> +	/* An error here means DDR DVFS API not supported by firmware */
> +	arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_COUNT,
> +			0, 0, 0, 0, 0, 0, &res);
> +	priv->freq_count = res.a0;
> +	if (priv->freq_count <= 0 ||
> +			priv->freq_count > IMX8M_DDRC_MAX_FREQ_COUNT)
> +		return -ENODEV;
> +
> +	for (index = 0; index < priv->freq_count; ++index) {
> +		struct imx8m_ddrc_freq *freq = &priv->freq_table[index];
> +
> +		arm_smccc_smc(IMX_SIP_DDR_DVFS, IMX_SIP_DDR_DVFS_GET_FREQ_INFO,
> +			      index, 0, 0, 0, 0, 0, &res);
> +		/* Result should be strictly positive */
> +		if ((long)res.a0 <= 0)
> +			return -ENODEV;
> +
> +		freq->rate = res.a0;
> +		freq->smcarg = index;
> +		freq->dram_core_parent_index = res.a1;
> +		freq->dram_alt_parent_index = res.a2;
> +		freq->dram_apb_parent_index = res.a3;
> +
> +		/* dram_core has 2 options: dram_pll or dram_alt_root */
> +		if (freq->dram_core_parent_index != 1 &&
> +				freq->dram_core_parent_index != 2)
> +			return -ENODEV;
> +		/* dram_apb and dram_alt have exactly 8 possible parents */
> +		if (freq->dram_alt_parent_index > 8 ||
> +				freq->dram_apb_parent_index > 8)
> +			return -ENODEV;
> +		/* dram_core from alt requires explicit dram_alt parent */
> +		if (freq->dram_core_parent_index == 2 &&
> +				freq->dram_alt_parent_index == 0)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int imx8m_ddrc_check_opps(struct device *dev)
> +{
> +	struct imx8m_ddrc *priv = dev_get_drvdata(dev);
> +	struct imx8m_ddrc_freq *freq_info;
> +	struct dev_pm_opp *opp;
> +	unsigned long freq;
> +	int i, opp_count;
> +
> +	/* Enumerate DT OPPs and disable those not supported by firmware */
> +	opp_count = dev_pm_opp_get_opp_count(dev);
> +	if (opp_count < 0)
> +		return opp_count;
> +	for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
> +		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
> +		if (IS_ERR(opp)) {
> +			dev_err(dev, "Failed enumerating OPPs: %ld\n",
> +				PTR_ERR(opp));
> +			return PTR_ERR(opp);
> +		}
> +		dev_pm_opp_put(opp);
> +
> +		freq_info = imx8m_ddrc_find_freq(priv, freq);
> +		if (!freq_info) {
> +			dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
> +					freq, DIV_ROUND_CLOSEST(freq, 250000));
> +			dev_pm_opp_disable(dev, freq);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void imx8m_ddrc_exit(struct device *dev)
> +{
> +	dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int imx8m_ddrc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx8m_ddrc *priv;
> +	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = imx8m_ddrc_init_freq_info(dev);
> +	if (ret) {
> +		dev_err(dev, "failed to init firmware freq info: %d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->dram_core = devm_clk_get(dev, "core");
> +	priv->dram_pll = devm_clk_get(dev, "pll");
> +	priv->dram_alt = devm_clk_get(dev, "alt");
> +	priv->dram_apb = devm_clk_get(dev, "apb");
> +	if (IS_ERR(priv->dram_core) ||
> +		IS_ERR(priv->dram_pll) ||
> +		IS_ERR(priv->dram_alt) ||
> +		IS_ERR(priv->dram_apb)) {
> +		ret = PTR_ERR(priv->devfreq);
> +		dev_err(dev, "failed to fetch clocks: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get OPP table\n");
> +		return ret;
> +	}
> +
> +	ret = imx8m_ddrc_check_opps(dev);
> +	if (ret < 0)
> +		goto err;
> +
> +	priv->profile.polling_ms = 1000;
> +	priv->profile.target = imx8m_ddrc_target;
> +	priv->profile.get_dev_status = imx8m_ddrc_get_dev_status;
> +	priv->profile.exit = imx8m_ddrc_exit;
> +	priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
> +	priv->profile.initial_freq = clk_get_rate(priv->dram_core);
> +
> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
> +						gov, NULL);
> +	if (IS_ERR(priv->devfreq)) {
> +		ret = PTR_ERR(priv->devfreq);
> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
> +		goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_pm_opp_of_remove_table(dev);
> +	return ret;
> +}
> +
> +static const struct of_device_id imx8m_ddrc_of_match[] = {
> +	{ .compatible = "fsl,imx8m-ddrc", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx8m_ddrc_of_match);
> +
> +static struct platform_driver imx8m_ddrc_platdrv = {
> +	.probe		= imx8m_ddrc_probe,
> +	.driver = {
> +		.name	= "imx8m-ddrc-devfreq",
> +		.of_match_table = of_match_ptr(imx8m_ddrc_of_match),
> +	},
> +};
> +module_platform_driver(imx8m_ddrc_platdrv);
> +
> +MODULE_DESCRIPTION("i.MX8M DDR Controller frequency driver");
> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
> +MODULE_LICENSE("GPL v2");
> 
