Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9A9FA5D1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 03:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfKMCZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 21:25:04 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:18947 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbfKMCZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 21:25:01 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191113022458epoutp0147c73187560e9f217b29c396f9c439e3~Wl68leoxH3040430404epoutp01T
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 02:24:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191113022458epoutp0147c73187560e9f217b29c396f9c439e3~Wl68leoxH3040430404epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1573611898;
        bh=gN0fjLadsBOiHpK645VFaTZEUvqnfvmV+jtu0JS5IJs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mO0Oh9K7XiMQZ+3fHaUQytZnjGyWpWmfaVUtJbLZI4ib4jpKLQOVWirWMrSI8VKjX
         OK56SINrja6SiKl8YpCVhoZkX3d0cmI4umje7E7uZxcIeFVn5hna7Km23ia4eFfdp6
         PfCFJZFfmJ5IGwxzmpUu6HJPnb9qESA4unYY4//s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20191113022457epcas1p3068c568378c2528c709bfab43cd90d16~Wl67qWls91761817618epcas1p3a;
        Wed, 13 Nov 2019 02:24:57 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 47CT3B0LDrzMqYkg; Wed, 13 Nov
        2019 02:24:53 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.01.04224.5796BCD5; Wed, 13 Nov 2019 11:24:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191113022452epcas1p4c879be993f81b6af2e93ae746d264a01~Wl63loMJY0064800648epcas1p4H;
        Wed, 13 Nov 2019 02:24:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20191113022452epsmtrp277d5021c7adca709575f2f5cb2d6f60f~Wl63kKg9o2644426444epsmtrp2b;
        Wed, 13 Nov 2019 02:24:52 +0000 (GMT)
X-AuditID: b6c32a38-d5bff70000001080-b2-5dcb69752b31
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        74.94.25663.4796BCD5; Wed, 13 Nov 2019 11:24:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191113022452epsmtip2bbd6d25344ce62098b205f3f7820539a~Wl63P-_z71321013210epsmtip2L;
        Wed, 13 Nov 2019 02:24:52 +0000 (GMT)
Subject: Re: [PATCH v5 4/5] PM / devfreq: Add dynamic scaling for imx8m ddr
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
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <0c416a08-811d-f3bc-af37-9e182f7c4d37@samsung.com>
Date:   Wed, 13 Nov 2019 11:30:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d33acdcc043ce12713a9279636e32d039da5ee54.1573595319.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wbdRTPt3e9K5vdzjLgK5mT3WLiSLq1g7IvOohkzFwiZug0mbrKznKh
        pD9z107mEsVlCNROtmydDBSYDAe4CC3oCtIhBZVfKwJSiYy5hLmQsXXBWqOQGdveFvnv8977
        vB+f9/JkmMJHpspKzTaON7NGmliHfzO4Xam0l45pVZFROfL/8DWJImOjAH0x9T1Af7p6MbTw
        2xxAV87rUONQQIrcXXM4+sTnIVC7qwdHExOdJLp2/C6JWueXpcizEJSiZecNKXKstGEofHII
        oJZfJiUo2HpaisKdCwBNju5Dcx+0EujLwACBxsempKjCN0Qih/8Bgf4NunG02J2C3BHm+ScZ
        l6MVMJcbLgPm/mwFydSXT+JMk8fOeNqrCeZ6sI9gui6+z7hDXgkzEOqTMDUPVMzKYBLTPVOJ
        Mx93twMm7NlSuPENwx49xxZzfBpn1lmKS80lOfSLB4r2FmmyVGqlOhvtptPMrInLofMLCpUv
        lBqj66HTjrBGe9RVyAoCvTN3D2+x27g0vUWw5dCctdhozbbuEFiTYDeX7NBZTM+qVapdmijx
        sEF/zcVbL7pAWUdklSwHN3kHSJBBKhMuffUd4QDrZArKC2DT2VGJaPwBYF9N28PIXwAG5t3Y
        o5RTZyeBGPAB+FF5Fyka9wEcWAyQMVYidRBePVErdQCZbBPFQ+dIeoyDUZMkXGpYksQ4BJUO
        +xdniRjeSG2FM38vgBiWU7lw/PN/8BjGqadh/b1gvE5StOZYhBUpj8OR87filATqLVhTPh0f
        DqNS4K+3GiUifgpeufcpFusLqWEZ/Lb5Ai4qyId3ZpseqkmEd37sJkWcCsMhHyHiY7BtZIgQ
        k6sA7O7/SSoGMmB/yxlJbCCM2g47eneK7q2wZ/UzIDbeAEMRZ3xmSMlh1YcKkbINTt+cl4j4
        CdhcWU2cAnTdGjl1ayTUrZFQ93+zJoC3g2TOKphKOEFtzVx7bQ+Iv0468oK+QIEfUDJAPyaH
        F0a1Cil7RDhq8gMow+hNcm/ZsFYhL2aPvsvxliLebuQEP9BEl30aS03SWaKPaLYVqTW7MjIy
        UKY6S6NW0ynyvEstWgVVwto4A8dZOf5RnkSWkFoODM3r35lrDh24LrVk9d6eOnSsM5A4OLT5
        uW3ZiY3Zu9mXKnqCB00Gg946sWXZuT8fnTn+niRhby1/uHJl88mCDbpDHXe1M2Shb5+Xq779
        tu7nc8PJ5kA9yZ5o+514ZvnS1bwbVcldM+HVifW1DYuvmPKyc19+tWz89TdTXpuecCqr9tO4
        oGfV6RgvsP8BaogbtVAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXcuO66Gp2n4ZpQ1yEhIzW4vVGKR8UYUfqxo6VEPTnJq56jd
        jEwSa6QWNEsrtZuuGeSmtnnXbYZ5bZpTshstqCANW4ZdjNos2Lff8zy///N8eRhCUUMFM6np
        WbyQzqUpaRn5yKYMWZuV2qeKPN+1HlkfN0rRTF8vQNXD3QB91TUTyPV6AiBzWRKqtA9SyFg/
        QaKrbSYaGXRNJBoaqpOigfxPUqR/OU0hk8tJoemLryik/XGfQO4iO0D3xhwS5NRfppC7zgWQ
        ozcWTZzV06h2sItG/X3DFCpos0uR1jpHo99OI4k+NAQh4wyOWYZ1Wj3ADyoeAPx5vECKr+c5
        SFxlysYmwwUav3C20rj+7hlsnLJIcNdUqwSXzEXiH7bFuGG0kMTFDQaA3ablcf4HZVuT+bTU
        HF6IiE6QqQd0QuZdHTj+cOanNA+8EbTAj4HsBnjpigN4WMG2AKitj53vL4Gljm5CC5i/HABt
        NnFemQTwTsEmDwew+2H7uWuUhwNZATZXl0i1QMYQ7JgUFnb2055Cwb4F8MsTO+mxaDYMdnwY
        pz3sz66Eo7Mu72E5Gw37b3/3OiS7Cl6fdHq3Lv574b15/J+zCD4pe+d1/NjDsCRvhPAwwa6G
        vyqG/3EQfP6uUjLPIdA8eYO4BALKfeLlPpFyn0i5T6QKkAawhM8UNSkacV1mVDp/LFzkNGJ2
        ekp4UobGBLzvExZmAT098VbAMkC5UN5Z0atSUFyOeEJjBZAhlIFyy/EelUKezJ04yQsZ8UJ2
        Gi9awVKGVAbJQzIeH1CwKVwWf4TnM3nh/1TC+AXnAZUbOyIT3xYvjXNGGqcSW/1365rvmcue
        pe3a3vk0/2FHvWHPTdfOAytid5gDb+dWckXPw1tDe0fVpfmhLTXHikfW1G4kt50cl+d0qVe0
        /0younL6VNGhowV1IH7v0NbZxqia3BeVWxbQlo9NDftCY2QRO7oHxdKc5G+WWftQ8fTmW0pS
        VHPrwghB5P4AeEb31zoDAAA=
X-CMS-MailID: 20191113022452epcas1p4c879be993f81b6af2e93ae746d264a01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191112215123epcas5p47d93a1e1837accf16ba0430963d03858
References: <cover.1573595318.git.leonard.crestez@nxp.com>
        <CGME20191112215123epcas5p47d93a1e1837accf16ba0430963d03858@epcas5p4.samsung.com>
        <d33acdcc043ce12713a9279636e32d039da5ee54.1573595319.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 11/13/19 6:50 AM, Leonard Crestez wrote:
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
>  drivers/devfreq/imx8m-ddrc.c | 460 +++++++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+)
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
> index 000000000000..62abb9b79d8a
> --- /dev/null
> +++ b/drivers/devfreq/imx8m-ddrc.c
> @@ -0,0 +1,460 @@
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
> +struct clk *clk_get_parent_by_index(struct clk *clk, int index)
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
> +	if (freq->dram_alt_parent_index) {
> +		new_dram_apb_parent = clk_get_parent_by_index(
> +				priv->dram_apb, freq->dram_apb_parent_index - 1);
> +		if (!new_dram_alt_parent) {
> +			dev_err(dev, "failed to fetch new dram_apb parent\n");
> +			return -EINVAL;
> +		}
> +	} else
> +		new_dram_apb_parent = NULL;
> +
> +	/* increase reference counts and ensure clks are ON before switch */
> +	ret = clk_prepare_enable(new_dram_core_parent);
> +	if (ret) {
> +		dev_err(dev, "failed enable new dram_core parent: %d\n", ret);

s/failed enable/failed to enable

> +		goto out;
> +	}
> +	ret = clk_prepare_enable(new_dram_alt_parent);
> +	if (ret) {
> +		dev_err(dev, "failed enable new dram_alt parent: %d\n", ret);

s/failed enable/failed to enable

> +		goto out_disable_core_parent;
> +	}
> +	ret = clk_prepare_enable(new_dram_apb_parent);
> +	if (ret) {
> +		dev_err(dev, "failed enable new dram_apb parent: %d\n", ret);

s/failed enable/failed to enable

> +		goto out_disable_alt_parent;
> +	}
> +
> +	imx8m_ddrc_smc_set_freq(freq->smcarg);
> +
> +	/* update parents in clk tree after switch. */
> +	ret = clk_set_parent(priv->dram_core, new_dram_core_parent);
> +	if (ret)
> +		dev_warn(dev, "failed set dram_core parent: %d\n", ret);

s/failed set/failed to set

> +	if (new_dram_alt_parent) {
> +		ret = clk_set_parent(priv->dram_alt, new_dram_alt_parent);
> +		if (ret)
> +			dev_warn(dev, "failed set dram_alt parent: %d\n", ret);

s/failed set/failed to set

> +	}
> +	if (new_dram_apb_parent) {
> +		ret = clk_set_parent(priv->dram_apb, new_dram_apb_parent);
> +		if (ret)
> +			dev_warn(dev, "failed set dram_apb parent: %d\n", ret);

s/failed set/failed to set

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

Actually, is it error? When use clk_set_rate with target_freq,
if target_freq is not same with supported clock of h/w clock,
the clk_set_rate set the similiar clock rate among the supported clock table.

It means that if the user of clock_set_rate() enters the unsupported clock rate,
the case of (*freq != new_freq) happen. 

Are you sure that you want to show the error when this case (*freq != new_freq)?
The your origin code is not wrong. Just question from me.

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

get_dev_status() callback is called by only simpleondemand governor.
When userspace governor is used, this function is never called.
So, need to drop this function and then add this function on next time.

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
> +
> +	/* Enumerate DT OPPs and disable those not supported by firmware */
> +	freq = ULONG_MAX;
> +	while (true) {
> +		opp = dev_pm_opp_find_freq_floor(dev, &freq);
> +		if (opp == ERR_PTR(-ERANGE))
> +			break;
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
> +
> +		freq--;
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

ditto. It is not used on this patch. On later, add the get_dev_status
for the ondemand governor.

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


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
