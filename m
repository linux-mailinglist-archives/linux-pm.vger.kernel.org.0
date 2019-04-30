Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4880EDA0
	for <lists+linux-pm@lfdr.de>; Tue, 30 Apr 2019 02:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfD3AUb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Apr 2019 20:20:31 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:22230 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfD3AUa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2019 20:20:30 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190430002027epoutp024d9d3bac5d7ef372eba0bca880fd57c8~aGI-rLXjj3157031570epoutp02u
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2019 00:20:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190430002027epoutp024d9d3bac5d7ef372eba0bca880fd57c8~aGI-rLXjj3157031570epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556583627;
        bh=waL7kuchv2rXyYj9PX0DqoezAXj6ObofBNBo84T3MTk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Qg8nAUR3WMewyyVE6WqGgSzU9/ksqlyLp1Rpa5MDQwAHpPQ9SkFAciPFE4QjUdgfj
         Ld7uMI83HMjdqomux4jcZhQQVIx+6BJvW4Nj/Ulhg2yi+PIt4vRndafPoMiDT/yqU+
         NnjY8ryxCSa49AesoDa4SGIvS8Y89FzntQ9UVBmI=
Received: from epsmges1p1.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190430002024epcas1p3ab63d2d7a19edadc9739cac082bd98fb~aGI88vqV62248822488epcas1p3G;
        Tue, 30 Apr 2019 00:20:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.C2.04139.8C497CC5; Tue, 30 Apr 2019 09:20:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20190430002023epcas1p33dc4b61fbc05f5e201a0da7f54cc1ceb~aGI8JMJhO1793717937epcas1p3i;
        Tue, 30 Apr 2019 00:20:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190430002023epsmtrp1199ca9c7bdeb4eb7582938b8e3e3534f~aGI8IXnCK1586115861epsmtrp1a;
        Tue, 30 Apr 2019 00:20:23 +0000 (GMT)
X-AuditID: b6c32a35-973ff7000000102b-8f-5cc794c8ccad
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.82.03692.7C497CC5; Tue, 30 Apr 2019 09:20:23 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190430002023epsmtip129836e7a25c0aa7245c84c160d349750~aGI77QI3X2652226522epsmtip1l;
        Tue, 30 Apr 2019 00:20:23 +0000 (GMT)
Subject: Re: [PATCH v3 16/16] PM / devfreq: Introduce driver for NVIDIA
 Tegra20
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <298cb2de-4191-4cd4-5bee-4501efe1967b@samsung.com>
Date:   Tue, 30 Apr 2019 09:21:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417222925.5815-17-digetx@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHebbduymubpvWaVjZjTCFqdc1u1ZGZMWNXlAkMjHsppcp7q3d
        TbI+ZBmVomYYvcwoy5SyxBIVNWr5khq1LEWUzIxMSBlWmlEY1m7XyG+/85xznv/5P89RSFUP
        cI0iw2znbGbWSOK+soa2kDBt14XO5IgPZ1bTd7+OIPqU86aMdp/0yOne5qs4PVXYjui8b06c
        HjxxG6d/Nl+T0UXVPfhmH6Zx6BZimpxDcqYwdwJniuqqEDNVuzwOS8rcmM6xaZwtiDOnWtIy
        zIYYcmdCSmyKPiqC0lLR9DoyyMyauBhy66447fYMo3cgMiiLNTq8R3Esz5PhmzbaLA47F5Ru
        4e0xJGdNM1qjrWE8a+IdZkNYqsW0noqIiNR7Cw9mpncWFkusbduOjFQOSnJQDZ2PfBRArIX3
        5SN4PvJVqIhGBO6CGUwMJhFMFDchMfiO4NLbj7J/LcNFDXMtjxC8+JIvE4PPCH6NlcqFKjUR
        D2XvZiRCwp+YRTDZfBkTElJiP0y3VEgFxolQcH0awAVeSKyEvh8jSGAlsQlmX7slAsuI1dDU
        P/6XA4hEGO64j4k1i+DZFXEkHyIKKpxPkHj/Enjz8bpE5BWQW18qFYYA4jcO3dMeXPSwFVyf
        PXKR1TDeWTfHGhg7d3qOj8GdZ+242HwWQZ3rFSYmdOCqKPEqKLwKIVDTHC6KLYCJ6QJMOAZC
        CWdPq8TqVdD7fkgi8lIoP5M3NwID+V3jWDFa6ZxnxznPgnOeBed/sTIkq0KLOStvMnA8ZaXm
        /3ct+ruuofpGdOHlrlZEKBDpp2QmOpJVGJvFZ5taESikpL+S6XyarFKmsdlHOZslxeYwcnwr
        0ntf+7xUE5Bq8S6/2Z5C6SN1Oh29lorSUxS5RFmzOTZZRRhYO5fJcVbO9q9PovDR5KDKyBvx
        gbN772kdu8svenJ91VsCVYWlrYF1uvFFAzFlLr/nWKxHKx+N0hq2uCumlltGT/0uPpB0tV6r
        aym7NJi4pzv4UHDeCrV6+GFBCT5WMly9Q3d5RpNB2nzdPfqsZe3tvzqOT1uqj+Wo1lVl7Xts
        OFyUMMkY1RsWN5rW5PT3kTI+naVCpTae/QPSnQxSxAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnO7xKcdjDL5M1LZY/fExo0XLrEUs
        Fmeb3rBbXN41h83ic+8RRovOL7PYLG43rmCz+LlrHotF39pLbA6cHjvuLmH02DnrLrtHb/M7
        No++LasYPT5vkgtgjeKySUnNySxLLdK3S+DKON47gangsGvF42W3mRoY11t0MXJySAiYSNzv
        28bWxcjFISSwm1Gi7dwNZoiEpMS0i0eBbA4gW1ji8OFiiJq3jBLNCyYxgdQICwRKLLj3mwkk
        ISLQxCTx+WELWIJZIFKi/1E3K0THFkaJv9O7waayCWhJ7H9xgw3E5hdQlLj64zEjiM0rYCfx
        7+JZsGYWAVWJnddfgdmiAhESZ96vYIGoEZQ4OfMJmM0pYCaxdNYBRohl6hJ/5l1ihrDFJW49
        mQ91hLxE89bZzBMYhWchaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvX
        S87P3cQIjjItzR2Ml5fEH2IU4GBU4uH1eHcsRog1say4MvcQowQHs5IIr8fxozFCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeZ/mHYsUEkhPLEnNTk0tSC2CyTJxcEo1MLLnsUeJxNhfn7cnRd08
        4URTBwfD+0sxC44fXp7OfmL5/NdPD2QLPLD+O93R7+acJ7VN18J8pAqyT1a3pl/8fm3LkcYi
        00CDvp2We4+y7Nwze0r/X83qAw8vXk3x8GdYJ7/jxWmXBC/tXVf5rrHFz90Q+47LfqObgWRv
        98ozZ2I2fDm01/9+z2IlluKMREMt5qLiRAAXWIlurgIAAA==
X-CMS-MailID: 20190430002023epcas1p33dc4b61fbc05f5e201a0da7f54cc1ceb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190417224323epcas2p1fdc2aa12d442dd8e22e3cdd04d0204c8
References: <20190417222925.5815-1-digetx@gmail.com>
        <CGME20190417224323epcas2p1fdc2aa12d442dd8e22e3cdd04d0204c8@epcas2p1.samsung.com>
        <20190417222925.5815-17-digetx@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

Looks good to me. But, just I have one minor comment
about '8' divider value in the tegra_devfreq_get_dev_status().

On the next version, you better to add the comment about the meaning
of '8' divider value.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

On 19. 4. 18. 오전 7:29, Dmitry Osipenko wrote:
> Add devfreq driver for NVIDIA Tegra20 SoC's. The driver periodically
> reads out Memory Controller counters and adjusts memory frequency based
> on the memory clients activity.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  MAINTAINERS                       |   8 ++
>  drivers/devfreq/Kconfig           |  10 ++
>  drivers/devfreq/Makefile          |   1 +
>  drivers/devfreq/tegra20-devfreq.c | 202 ++++++++++++++++++++++++++++++
>  4 files changed, 221 insertions(+)
>  create mode 100644 drivers/devfreq/tegra20-devfreq.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 002d564efbe5..c70896550a27 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10070,6 +10070,14 @@ F:	include/linux/memblock.h
>  F:	mm/memblock.c
>  F:	Documentation/core-api/boot-time-mm.rst
>  
> +MEMORY FREQUENCY SCALING DRIVER FOR NVIDIA TEGRA20
> +M:	Dmitry Osipenko <digetx@gmail.com>
> +L:	linux-pm@vger.kernel.org
> +L:	linux-tegra@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git
> +S:	Maintained
> +F:	drivers/devfreq/tegra20-devfreq.c
> +
>  MEMORY MANAGEMENT
>  L:	linux-mm@kvack.org
>  W:	http://www.linux-mm.org
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index a6bba6e1e7d9..1530dbefa31f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -100,6 +100,16 @@ config ARM_TEGRA_DEVFREQ
>  	  It reads ACTMON counters of memory controllers and adjusts the
>  	  operating frequencies and voltages with OPP support.
>  
> +config ARM_TEGRA20_DEVFREQ
> +	tristate "NVIDIA Tegra20 DEVFREQ Driver"
> +	depends on (TEGRA_MC && TEGRA20_EMC) || COMPILE_TEST
> +	select DEVFREQ_GOV_SIMPLE_ONDEMAND
> +	select PM_OPP
> +	help
> +	  This adds the DEVFREQ driver for the Tegra20 family of SoCs.
> +	  It reads Memory Controller counters and adjusts the operating
> +	  frequencies and voltages with OPP support.
> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on ARCH_ROCKCHIP
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 47e5aeeebfd1..338ae8440db6 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> +obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
>  # DEVFREQ Event Drivers
>  obj-$(CONFIG_PM_DEVFREQ_EVENT)		+= event/
> diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
> new file mode 100644
> index 000000000000..ec2cec6808ed
> --- /dev/null
> +++ b/drivers/devfreq/tegra20-devfreq.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVIDIA Tegra20 devfreq driver
> + *
> + * Copyright (C) 2019 GRATE-DRIVER project
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/slab.h>
> +
> +#include <soc/tegra/mc.h>
> +
> +#include "governor.h"
> +
> +#define MC_STAT_CONTROL				0x90
> +#define MC_STAT_EMC_CLOCK_LIMIT			0xa0
> +#define MC_STAT_EMC_CLOCKS			0xa4
> +#define MC_STAT_EMC_CONTROL			0xa8
> +#define MC_STAT_EMC_COUNT			0xb8
> +
> +#define EMC_GATHER_CLEAR			(1 << 8)
> +#define EMC_GATHER_ENABLE			(3 << 8)
> +
> +struct tegra_devfreq {
> +	struct devfreq *devfreq;
> +	struct clk *clk;
> +	void __iomem *regs;
> +};
> +
> +static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
> +				u32 flags)
> +{
> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +	struct devfreq *devfreq = tegra->devfreq;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int err;
> +
> +	opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	rate = dev_pm_opp_get_freq(opp);
> +	dev_pm_opp_put(opp);
> +
> +	err = clk_set_min_rate(tegra->clk, rate);
> +	if (err)
> +		return err;
> +
> +	err = clk_set_rate(tegra->clk, 0);
> +	if (err)
> +		goto restore_min_rate;
> +
> +	return 0;
> +
> +restore_min_rate:
> +	clk_set_min_rate(tegra->clk, devfreq->previous_freq);
> +
> +	return err;
> +}
> +
> +static int tegra_devfreq_get_dev_status(struct device *dev,
> +					struct devfreq_dev_status *stat)
> +{
> +	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
> +
> +	stat->busy_time = readl_relaxed(tegra->regs + MC_STAT_EMC_COUNT);
> +	stat->total_time = readl_relaxed(tegra->regs + MC_STAT_EMC_CLOCKS) / 8;

How about adding the comment why divide with '8' constant value?


> +	stat->current_frequency = clk_get_rate(tegra->clk);
> +
> +	writel_relaxed(EMC_GATHER_CLEAR, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(EMC_GATHER_ENABLE, tegra->regs + MC_STAT_CONTROL);
> +
> +	return 0;
> +}
> +
> +static struct devfreq_dev_profile tegra_devfreq_profile = {
> +	.polling_ms	= 500,
> +	.target		= tegra_devfreq_target,
> +	.get_dev_status	= tegra_devfreq_get_dev_status,
> +};
> +
> +static struct tegra_mc *tegra_get_memory_controller(void)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	struct tegra_mc *mc;
> +
> +	np = of_find_compatible_node(NULL, NULL, "nvidia,tegra20-mc-gart");
> +	if (!np)
> +		return ERR_PTR(-ENOENT);
> +
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	mc = platform_get_drvdata(pdev);
> +	if (!mc)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return mc;
> +}
> +
> +static int tegra_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra;
> +	struct tegra_mc *mc;
> +	unsigned long max_rate;
> +	unsigned long rate;
> +	int err;
> +
> +	mc = tegra_get_memory_controller();
> +	if (IS_ERR(mc)) {
> +		err = PTR_ERR(mc);
> +		dev_err(&pdev->dev, "failed to get memory controller: %d\n",
> +			err);
> +		return err;
> +	}
> +
> +	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
> +	if (!tegra)
> +		return -ENOMEM;
> +
> +	/* EMC is a system-critical clock that is always enabled */
> +	tegra->clk = devm_clk_get(&pdev->dev, "emc");
> +	if (IS_ERR(tegra->clk)) {
> +		err = PTR_ERR(tegra->clk);
> +		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
> +		return err;
> +	}
> +
> +	tegra->regs = mc->regs;
> +
> +	max_rate = clk_round_rate(tegra->clk, ULONG_MAX);
> +
> +	for (rate = 0; rate <= max_rate; rate++) {
> +		rate = clk_round_rate(tegra->clk, rate);
> +
> +		err = dev_pm_opp_add(&pdev->dev, rate, 0);
> +		if (err) {
> +			dev_err(&pdev->dev, "failed to add opp: %d\n", err);
> +			goto remove_opps;
> +		}
> +	}
> +
> +	/*
> +	 * Reset statistic gathers state, select global bandwidth for the
> +	 * statistics collection mode and set clocks counter saturation
> +	 * limit to maximum.
> +	 */
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_CONTROL);
> +	writel_relaxed(0x00000000, tegra->regs + MC_STAT_EMC_CONTROL);
> +	writel_relaxed(0xffffffff, tegra->regs + MC_STAT_EMC_CLOCK_LIMIT);
> +
> +	platform_set_drvdata(pdev, tegra);
> +
> +	tegra->devfreq = devfreq_add_device(&pdev->dev, &tegra_devfreq_profile,
> +					    DEVFREQ_GOV_SIMPLE_ONDEMAND, NULL);
> +	if (IS_ERR(tegra->devfreq)) {
> +		err = PTR_ERR(tegra->devfreq);
> +		goto remove_opps;
> +	}
> +
> +	return 0;
> +
> +remove_opps:
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	return err;
> +}
> +
> +static int tegra_devfreq_remove(struct platform_device *pdev)
> +{
> +	struct tegra_devfreq *tegra = platform_get_drvdata(pdev);
> +
> +	devfreq_remove_device(tegra->devfreq);
> +	dev_pm_opp_remove_all_dynamic(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tegra_devfreq_driver = {
> +	.probe		= tegra_devfreq_probe,
> +	.remove		= tegra_devfreq_remove,
> +	.driver		= {
> +		.name	= "tegra20-devfreq",
> +	},
> +};
> +module_platform_driver(tegra_devfreq_driver);
> +
> +MODULE_ALIAS("platform:tegra20-devfreq");
> +MODULE_AUTHOR("Dmitry Osipenko <digetx@gmail.com>");
> +MODULE_DESCRIPTION("NVIDIA Tegra20 devfreq driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
