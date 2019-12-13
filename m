Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7EF311DBA0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2019 02:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfLMBYX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 20:24:23 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:51470 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731288AbfLMBYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 20:24:23 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20191213012420epoutp02e903d495f46e2f90e0aa6fae874806e0~fyckds4DS0415504155epoutp02g
        for <linux-pm@vger.kernel.org>; Fri, 13 Dec 2019 01:24:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20191213012420epoutp02e903d495f46e2f90e0aa6fae874806e0~fyckds4DS0415504155epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1576200260;
        bh=5CvMUFlOh3CH/oawCLl54ZNz9H/LkRQEF/C9QHv+8XA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=fdTr9uenEBkcjlIwGcU/ZD9DcLdGUog97/+0S0EbC5qN2hmVStMZVJpYE4NMeaVHJ
         PijyKADQFYlEg6oaxZCd1SQWoK687cXRU2DLaK14R7rHli9A6csC1DdcisCBFvRgo3
         x6zJmKcn5A/XW/iONOb3hsKz2kVDvL4meKhSc9kM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20191213012419epcas1p4717e3fe7e5d59b28b9a7455ba67299d0~fycjkwQ762781827818epcas1p4F;
        Fri, 13 Dec 2019 01:24:19 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 47YtHP0fvfzMqYm4; Fri, 13 Dec
        2019 01:24:17 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.78.48498.048E2FD5; Fri, 13 Dec 2019 10:24:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20191213012416epcas1p4d1d2af13ce4822a7439b08801aef55d2~fycg-kx5J2813928139epcas1p40;
        Fri, 13 Dec 2019 01:24:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191213012416epsmtrp135ba3a6b0e6f05d53d2d4b737758d27f~fycg_VY1G1299812998epsmtrp1d;
        Fri, 13 Dec 2019 01:24:16 +0000 (GMT)
X-AuditID: b6c32a36-a3dff7000001bd72-eb-5df2e8403b8e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.9E.06569.048E2FD5; Fri, 13 Dec 2019 10:24:16 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20191213012416epsmtip2538381df632dd67dae345724f33c2a1c~fycglJM5o1814718147epsmtip2P;
        Fri, 13 Dec 2019 01:24:16 +0000 (GMT)
Subject: Re: [PATCH RFC v6 2/9] PM / devfreq: Add generic imx bus scaling
 driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Angus Ainslie <angus@akkea.ca>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <8734a934-79e2-7445-c3e5-a0bb59afd4a8@samsung.com>
Date:   Fri, 13 Dec 2019 10:30:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xbVRjd7WvfeyCdbx3ItQkKz6gZhq2PX14UhovbfFESiUuM0yC+0BdA
        +it9hcjQjJGxsU4djSEbnRUmY4MOHS1lwBwyfrnAMmqnVBgjiKDBxQECdYiB2fbVyH/nO9/5
        7nfPubkkpugilGShzsQbdZyGxsOlV/p3JCTsmVvKUVVYMNT3XTuBfDeHAbpwexCglZqrGJqZ
        mgCoozYP1Q2MyJCjbUKKTnc7cWSv6ZIit7uVQLcq/iBQ0+SfMuSc8cqQea0ZQ8ufDADU+JNH
        grxNFhlabp0ByDO8D00cacLRpZFeHNlWajBU2T1AIHPfOo42vA4pmnNFo8YGL4YcPvalGLbG
        3ATYli9aALswVkmwZ8s9UrbeWcw67Sdw9q73Gs62nT/MOuY7JWzv/DUJe2pdxa71R7GfuuyA
        XXY+kb317aL0Ap5T88ZYXpenVxfq8jPo1w7kvpybkqpiEpg09Dwdq+O0fAa9Nys7YX+hxp8M
        HVvCaYr9VDYnCPSu3elGfbGJjy3QC6YMmjeoNYY0w06B0wrFuvydeXrtC4xKlZjiF75XVOAe
        /pEw3Mv44Lf7VlAOzIlmQJKQSoZfr+nNIJxUUJ0A/nrkPBCLJQBXL/pwsfgLwNrpFswMwoIT
        1c7BUKMbQMvwV6FiAcCTo8eJgGo79QY8d7lZGsCRVBmsvlUhCYgwapyA1we/BYEGTsXDnrkx
        PIAfpeLg6OpMkJdTu+GUfVwWwFLqadjmnggeGkW9CYeuHA1ptsGh2tnggjDqXVje7gvyGBUN
        78zWSUT8JOy4/zkWWAyp6yR8cGkSFz3shWce1hEi3g7v3XCFsBL+fupYCJfB5qEBXByuAtDV
        871MbCTBnsbPJIH4MGoHvHx1l0jHwa5/bKFLbIXzvo9lYsJyWHVMIUqegj/8PCkR8eOw4fgJ
        vBrQ1k12rJssWDdZsP6/rB5I7eAx3iBo83mBMSRufm4nCH6b+NRO8OVIVh+gSEBHyLeol3IU
        Mq5EKNX2AUhidKQ880M/JVdzpYd4oz7XWKzhhT6Q4k/bgimj8vT+T6gz5TIpiUlJSSiZSU1h
        GDpaTq56chRUPmfii3jewBv/m5OQYcpykLn4TNWi8mJrFFliy3z/lZjXXz06HXEw4lDlR2ct
        TEzWwfCSB4fD2je6vR1l8/ve+cby0JeVTjzifis5H7s7O7q/lFxgbCsHnutvDjfrp+48O16v
        20Ktp+m95sjGsJOuM429kTX1tuTpbXumxjJveATHOd/N0sW/cxoibv/y4saFzDhaKhRwTDxm
        FLh/AcXfFxZMBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRiA+XbOzjmOVqdN8bOo1aKMwbxEPz7ITIjgFBFRFBWYHvKg0W7s
        ZGUtWoWBo5vRrFa5LipzGc6ZqaWYm8tL5VBsWsuEJmalCzUrht22Eezfw/c+z/v++ShMUiFc
        RB3UHOb0GlYlJ0T4Y7dcpswan85Os05B5HreQKLZFz0AVfV7APpmfoKhwIgfoMYbB5C1o1eI
        6ur9OLrW6iSQ3dyMI6/XQaJXZyZIZBueEiJnwCdEplA1hmYudABUOdgnQD5bqRDNOAIA9fVs
        Qv7TNgI96G0n0O1vZgwVt3aQyOT6RaDfvjocjT9KRJX3fRiqm2WyljBmkw0wNeU1gPk6VEwy
        N419OHPHWcg47SUE887XQjD1FaeYumCTgGkPtgiYS7/SmJA7gbn4yA6YGefS7fP3iTLyONXB
        I5w+NTNXVODtGSB1n9cfG5u0ACMwrTGBOArSa+Flp4cwAREloZ8C6HH48OggCZb1eTAToP6x
        FLrdfNSZBLCmuBaEHSm9A96trY748fQJODfWiYUljB4m4fXznYJo8QHA3rLrRNgiaAVsGx+K
        8AJ6OXz9MxDZJKYz4Yj9jTDMOL0S1nv9ZJgT6N2wuSIgiDoLYfeN0ci1OHo/NDbMRlqMToZz
        5f1YlBPh21GrIMoy2Dh5C7sMpJaY3BKTWGISS0xyB+B2kMTpeHW+mk/XrdFwR1N4Vs0XavJT
        DmjVThD5OwpFE+jqynEBmgLyeWIbO50tEbJH+CK1C0AKk8eLNxj+PYnz2KLjnF6boy9UcbwL
        LKZweaJYpn2+V0Lns4e5Qxyn4/T/pwIqbpERxF9p5UscFTuN7MN1md2S5Ksvl6GPPz5dDE7s
        alwx19O2+cKZhJaz/qLvBQsM/tBmmXZP3mp6FVF1biO25MfIFrOqrKTUem/t9y26gZMUMIxy
        +NZyXXKu/I968ftQqTJotWSxA51kqqxBuTPl5rCUMTQ827EtQ7Xpi9RRO1illON8AZuuwPQ8
        +xeaSAVbNwMAAA==
X-CMS-MailID: 20191213012416epcas1p4d1d2af13ce4822a7439b08801aef55d2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862
References: <cover.1573761527.git.leonard.crestez@nxp.com>
        <CGME20191114201049epcas5p4a24607634af7b31e6a2dbdb4166dd862@epcas5p4.samsung.com>
        <f329e715898a6b9fd0cee707a93fb1e144e31bd4.1573761527.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 11/15/19 5:09 AM, Leonard Crestez wrote:
> Add initial support for dynamic frequency switching on pieces of the imx
> interconnect fabric.
> 
> All this driver does is set a clk rate based on an opp table, it does
> not map register areas.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/Kconfig       |   9 ++
>  drivers/devfreq/Makefile      |   1 +
>  drivers/devfreq/imx-devfreq.c | 150 ++++++++++++++++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 drivers/devfreq/imx-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 923a6132e741..fef5ce831e90 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -98,10 +98,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  	select DEVFREQ_GOV_USERSPACE
>  	help
>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>  	  adjusting DRAM frequency.
>  
> +config ARM_IMX_DEVFREQ
> +	tristate "i.MX Generic DEVFREQ Driver"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	select DEVFREQ_GOV_PASSIVE
> +	select DEVFREQ_GOV_USERSPACE
> +	help
> +	  This adds the generic DEVFREQ driver for i.MX interconnects. It
> +	  allows adjusting NIC/NOC frequency.
> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 3eb4d5e6635c..61d0edee16f7 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -8,10 +8,11 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
>  # DEVFREQ Event Drivers
> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
> new file mode 100644
> index 000000000000..620b344e87aa
> --- /dev/null
> +++ b/drivers/devfreq/imx-devfreq.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct imx_devfreq {
> +	struct devfreq_dev_profile profile;
> +	struct devfreq *devfreq;
> +	struct clk *clk;
> +	struct devfreq_passive_data passive_data;
> +};
> +
> +static int imx_devfreq_target(struct device *dev,
> +			      unsigned long *freq, u32 flags)

Don't use space for the indentation. Please use only tab.

> +{
> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
> +	struct dev_pm_opp *new_opp;
> +	unsigned long new_freq;
> +	int ret;
> +
> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(new_opp)) {
> +		ret = PTR_ERR(new_opp);
> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
> +		return ret;
> +	}
> +	new_freq = dev_pm_opp_get_freq(new_opp);
> +	dev_pm_opp_put(new_opp);
> +
> +	return clk_set_rate(priv->clk, new_freq);
> +}
> +
> +static int imx_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int imx_devfreq_get_dev_status(struct device *dev,
> +				      struct devfreq_dev_status *stat)

ditto. Please use tab for the indentation.

> +{
> +	struct imx_devfreq *priv = dev_get_drvdata(dev);
> +
> +	stat->busy_time = 0;
> +	stat->total_time = 0;
> +	stat->current_frequency = clk_get_rate(priv->clk);
> +
> +	return 0;
> +}
> +
> +static void imx_devfreq_exit(struct device *dev)
> +{
> +	dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int imx_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_devfreq *priv;

How about changing the variable name 'priv' to 'imx' or 'imx_data'?
because it is not easy to catch the role of 'priv' from variable name.

> +	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	void *govdata = NULL;

How about changing the variable name 'govdata' to 'gov_data'?
- govdata -> gov_data

> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(dev, NULL);

nitpick: because the clock-name is not mandatory.
Don't need to specify the clock name to inform the role of clock
of other developer/user?

For example, "ddr", "bus" and so on.

> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
> +		return ret;
> +	}
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get OPP table\n");
> +		return ret;
> +	}
> +
> +	priv->profile.polling_ms = 1000;
> +	priv->profile.target = imx_devfreq_target;
> +	priv->profile.get_dev_status = imx_devfreq_get_dev_status;
> +	priv->profile.exit = imx_devfreq_exit;
> +	priv->profile.get_cur_freq = imx_devfreq_get_cur_freq;
> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
> +
> +	/* Handle passive devfreq parent link */
> +	priv->passive_data.parent = devfreq_get_devfreq_by_phandle(dev, 0);
> +	if (!IS_ERR(priv->passive_data.parent)) {
> +		dev_info(dev, "setup passive link to %s\n",
> +			 dev_name(priv->passive_data.parent->dev.parent));
> +		gov = DEVFREQ_GOV_PASSIVE;
> +		govdata = &priv->passive_data;
> +	} else if (priv->passive_data.parent != ERR_PTR(-ENODEV)) {
> +		// -ENODEV means no parent: not an error.
> +		ret = PTR_ERR(priv->passive_data.parent);
> +		if (ret != -EPROBE_DEFER)
> +			dev_warn(dev, "failed to get initialize passive parent: %d\n",
> +				 ret);
> +		goto err;
> +	}

You better to change the exception handling as following: It is more simple.

	} else if (PTR_ERR(priv->passive_data.parent) == -EPROBE_DEFER)
			|| PTR_ERR(priv->passive_data.parent) == -ENODEV) {
		goto err;
	} else {
		ret = PTR_ERR(priv->passive_data.parent);
		dev_err(dev, "failed to get initialize passive parent: %d\n", ret);
		goto err;
	}

> +
> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
> +						gov, govdata);
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
> +static const struct of_device_id imx_devfreq_of_match[] = {
> +	{ .compatible = "fsl,imx8m-noc", },
> +	{ .compatible = "fsl,imx8m-nic", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
> +
> +static struct platform_driver imx_devfreq_platdrv = {
> +	.probe		= imx_devfreq_probe,
> +	.driver = {
> +		.name	= "imx-devfreq",
> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
> +	},
> +};
> +module_platform_driver(imx_devfreq_platdrv);
> +
> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");

If this driver is for bus frequency, you better to use 'bus' for the clock-name
for the readability.

> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
