Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7419E19A21E
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaWzj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 18:55:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38573 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgCaWzj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 18:55:39 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200331225536epoutp0267c5e68503bdf9652499d46b078dde52~BhYHEEswq1886918869epoutp02O
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2020 22:55:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200331225536epoutp0267c5e68503bdf9652499d46b078dde52~BhYHEEswq1886918869epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585695336;
        bh=fG2pvKOs/nfbkCyYfW2IZo12SDvtmU5s5GgX4jeKvvw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=gmE611YxvUH66+j3Bg0WgRa6njp0hdVl8jOX3ujjZZi3JfW/9Zeesd00ipkqDfk8a
         QPOABHMd5Da1Ox38glj4GY1FY8In/vtPp/9Tp9sXr9Gtb2B0n5yKHO+XYtTCD8dkwG
         ekAy19Fgw1kC0CQO7oHOK0kt2TjejyPpmKXcwijQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200331225535epcas1p411c5a4f6ab9d435e8cb472de075aa513~BhYGRPxhG2684726847epcas1p4L;
        Tue, 31 Mar 2020 22:55:35 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48sPn11MvBzMqYkV; Tue, 31 Mar
        2020 22:55:33 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.C9.04140.56AC38E5; Wed,  1 Apr 2020 07:55:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200331225532epcas1p1561edc072010788f90dc19b0c7f8609e~BhYDRqKpp2015420154epcas1p1J;
        Tue, 31 Mar 2020 22:55:32 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200331225532epsmtrp160bb6e7d4d4eddd38c7da21a71035f87~BhYDQYq1f1153311533epsmtrp1L;
        Tue, 31 Mar 2020 22:55:32 +0000 (GMT)
X-AuditID: b6c32a36-fa3ff7000000102c-c5-5e83ca6559e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.94.04158.36AC38E5; Wed,  1 Apr 2020 07:55:32 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200331225531epsmtip23f79aa3a8e16d6754388e3972ad3b534~BhYC0Z5pi0816508165epsmtip2Z;
        Tue, 31 Mar 2020 22:55:31 +0000 (GMT)
Subject: Re: [PATCH 2/8] PM / devfreq: Add generic imx bus scaling driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kepplinger <martink@posteo.de>
Cc:     =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
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
        Silvano di Ninno <silvano.dininno@nxp.com>,
        linux-pm@vger.kernel.org, kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <781911a0-6139-8e41-cd96-da40fad685fc@samsung.com>
Date:   Wed, 1 Apr 2020 08:04:37 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <e32290a36b31fbe922cc8ed48c33e89a5eb08804.1585188174.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTdxTft9deD2Pnrcr42m1abj+iJEBLLftCAN3GzJlpxrKwZVvW7gYX
        YP2ZXmuGLhmTFbBxomg3QVGGspXODLiyigohLd1ccYKwWI1oXKxZ2NwgDBCHUddra8Z/n/fe
        5/34vJdHYHKfVEFUme2szcwYKXyZ2D+0PiuTHa7VqWbCGLpx1AnQ/PlhgL4Z/xGgOfcZDEVv
        TAB0qrkMHQuNSFCPb0KMvhrgceR1nxaj0dFuKbqw6y8p8lyfkSA+GpEg12Inhma/CAHUcXlM
        hCKe/RI02x0FaGz4VTTxmQdH340EcNQ658aQcyAkRa7gfRw9iPSI0WRvGuo4HsFQzzy96Rna
        7fIA+uTRk4CevuKU0odrxsR0G++gee9unL4W6cdp34lP6Z6pPhHdeF9FLw6l0nt7vYCe5deU
        yN41FFSyTDlrU7LmMkt5lbmikHrtTf0rem2uSp2pzkMvUkozY2ILqeKtJZmbq4yxpVDK7YzR
        EXOVMBxHZRcV2CwOO6ustHD2Qoq1lhutedYsjjFxDnNFVpnFlK9WqXK0MeIHhsrus2us7fkf
        P4xNUwO+znaBFAKSG2Ab3yBygWWEnOwDcHHP3+KE8Q+AnTO3xAJLTt4B8OGU6lHGwt0AliAN
        ADjMDyaNaQAP3awXCayV5BY4t/cIEAKryBMAhiIL8boY6ZHCOv+38bo4mQEHJ6/gAl5BpsNL
        d6NAwDKyCPYfvC0VsJh8DkZ++TleNZV8C4b9nyc5T8BwszAfQaSQOlh/cafgxsg0ePXWMVEC
        r4W1PxyOTwfJfgK6B/zShIZi+PuuBTyBV8I/z/Um/Qr4R2NdEu+EneEQnkhuALB38KIkEdDA
        wY4DIqExRq6HXWeSm0yHp++1gkTjx+HU/B6JQIGkDDbUyROUZ+Gvv10XJfBqeLx+N74PUC1L
        1LQskdCyRELL/83agNgLnmStnKmC5dTWnKXX5kH8YTJy+0D7yNYgIAlALZcp82t1cgmznas2
        BQEkMGqVDH+9RieXlTPVO1ibRW9zGFkuCLSxZe/HFKllltj7me16tTZHo9GgDepcrVpNpcnc
        l406OVnB2FkDy1pZ26M8EZGiqAFPZT9oSou0brz902OlGQrJv5q30ztXe9GhI8WqtQfhvjd8
        mwNkY+GFU8s/8W4EN1/ecvX89wbt04Hg85dWfNTlW2cI5J1lPoyODHVNk6Zt1f3+0gZ3NnPt
        3rb3mr4MvDA/7vWMO4usL61z6nXNyvaSd6yjk5vC3lKeP9d0oCDl/dIcSsxVMuoMzMYx/wGv
        rirLRgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTUQDHPbt3d9fV8DpfR/OBI6gG+UrqJCb1Ibh9yT71+jBbepmSm2vX
        mRrU1ExdNRW0cD6ymjanhE5LTSV8lVk+q2VZSU3IUitTUSxnzhH47cf5/36c8+GQmLCc60Mm
        KJIZlUKaKCL4+KNuUcDuuP4sSUjBLEATFdkALb7oB6h6tBegheLHGLJOjAPUXBKLbvcMclFD
        4ziObnWYCWQqbsXR0FA9Dw1kzvCQ8eMcF5mtFi7SrtRgaP5GD0BVb0c4yGIs5KL5eitAI/2H
        0XiGkUC1g50EKl8oxlB2Rw8PabtWCWSzNOBoqskLVd2zYKhhkT7oRxdrjYCuq6gD9M+xbB5d
        qhnB6Uqzmjab8gj6g6WdoBsNl+mGHy0cOn81hF7p9qB1TSZAz5v9jwlO8yPjmMSEFEYVHHWG
        H1/f5q+8G5G6ti5rwJ1gLXAmIRUOl5Y7MS3gk0KqDUBbdTnXMXjDmyO96wO5zm6wu5t1OLMA
        1pnvc+yOG3UELujKgJ3dKQOAhs/Rdgmj6ngw05BDOIovAOZNr+F2i6DE8MnUGGFnFyoQvlm2
        btQCKgq2F03z7IxT26HlZd/GDR7UcdhqsHIcjit8XjKJ21/kTElgzvBF+zFG7YB/K0YxB3vB
        95O3OQ4OgFkPS7EC4KbfVOs3JfpNiX5TUglwE/BmlKxcJmdDlWEK5kIQK5WzaoUsKDZJbgYb
        n0YsbgF9fTFdgCKBaKsgMCJLIuRKU9g0eReAJCZyFxDRGolQECdNS2dUSTEqdSLDdoFtJC7y
        EgQkPT0lpGTSZOYcwygZ1f+VQzr7aEBgftr31YJXc888h4tkJq6tsn1fERWldgo37oqvypg4
        20x9gq4yHxBsM/nxdXu8U4MOXLlGL+1fTg//3Vo74+uii/SrfTDqbzO89v2mWP0TdLXwpOl8
        r5M4X/du5eh1919OW76GLSYFWg7p+YWkPjPWU70kGagpyy28lLvzxF5/Ec7GS0PFmIqV/gO4
        +IhXMAMAAA==
X-CMS-MailID: 20200331225532epcas1p1561edc072010788f90dc19b0c7f8609e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200326021637epcas1p26d84c256cf05a97ae1c90bb16ea6fa5d
References: <cover.1585188174.git.leonard.crestez@nxp.com>
        <CGME20200326021637epcas1p26d84c256cf05a97ae1c90bb16ea6fa5d@epcas1p2.samsung.com>
        <e32290a36b31fbe922cc8ed48c33e89a5eb08804.1585188174.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Looks good to me. I added the comments.
But, it need to add the dt binding documentation for this device.

The old email of Artur Świgoń is not used. On next time,
use following the new email address Because when I reply the mail,
always show the fail message from thunderbird due to the Artur's old email.
<a.swigon@partnet.samsung.com> -> <a.swigon@samsung.com>

On 3/26/20 11:16 AM, Leonard Crestez wrote:
> Add initial support for dynamic frequency switching on pieces of the imx
> interconnect fabric.
> 
> All this driver does is set a clk rate based on an opp table, it does
> not map register areas.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/Kconfig   |   9 +++
>  drivers/devfreq/Makefile  |   1 +
>  drivers/devfreq/imx-bus.c | 142 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 152 insertions(+)
>  create mode 100644 drivers/devfreq/imx-bus.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 0b1df12e0f21..44d26192ddc4 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -99,10 +99,19 @@ config ARM_IMX8M_DDRC_DEVFREQ
>  	select DEVFREQ_GOV_USERSPACE
>  	help
>  	  This adds the DEVFREQ driver for the i.MX8M DDR Controller. It allows
>  	  adjusting DRAM frequency.
>  
> +config ARM_IMX_BUS_DEVFREQ
> +	tristate "i.MX Generic Bus DEVFREQ Driver"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	select DEVFREQ_GOV_PASSIVE
> +	select DEVFREQ_GOV_USERSPACE

Maybe, you would update it by using passive governor?
But, in this version, it doesn't handle the any passive governor.

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
> index 3eb4d5e6635c..3ca1ad0ecb97 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o

The ARM_IMX_BUS_DEVFREQ config is under ARM_IMX8M_DDRC_DEVFREQ
and imx-bus.o is over imx8m-ddrc.o. Need to edit the sequence.

>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
> diff --git a/drivers/devfreq/imx-bus.c b/drivers/devfreq/imx-bus.c
> new file mode 100644
> index 000000000000..285e0f1ae6b1
> --- /dev/null
> +++ b/drivers/devfreq/imx-bus.c
> @@ -0,0 +1,142 @@
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
> +struct imx_bus {
> +	struct devfreq_dev_profile profile;
> +	struct devfreq *devfreq;
> +	struct clk *clk;
> +	struct devfreq_passive_data passive_data;

This patch doesn't touch the passive_data.

> +};
> +
> +static int imx_bus_target(struct device *dev,
> +		unsigned long *freq, u32 flags)
> +{
> +	struct imx_bus *priv = dev_get_drvdata(dev);
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

It doesn't need. Because the new frequency is stored to 'freq'
by calling devfreq_recommended_opp().

> +	dev_pm_opp_put(new_opp);
> +
> +	return clk_set_rate(priv->clk, new_freq);

nitpick. you can use dev_pm_opp_set_rate(). But, I'm not forcing to use it.

> +}
> +
> +static int imx_bus_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct imx_bus *priv = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int imx_bus_get_dev_status(struct device *dev,
> +		struct devfreq_dev_status *stat)
> +{
> +	struct imx_bus *priv = dev_get_drvdata(dev);
> +
> +	stat->busy_time = 0;
> +	stat->total_time = 0;
> +	stat->current_frequency = clk_get_rate(priv->clk);
> +
> +	return 0;
> +}
> +
> +static void imx_bus_exit(struct device *dev)
> +{
> +	dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int imx_bus_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_bus *priv;
> +	const char *gov = DEVFREQ_GOV_USERSPACE;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Fetch the clock to adjust but don't explictly enable.

Need to fix typo.
s/explictly/explicitly

> +	 *
> +	 * For imx bus clock clk_set_rate is safe no matter if the clock is on
> +	 * or off and some peripheral side-buses might be off unless enabled by
> +	 * drivers for devices on those specific buses.
> +	 *
> +	 * Rate adjustment on a disabled bus clock just takes effect later.
> +	 */
> +	priv->clk = devm_clk_get(dev, NULL);
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
> +	priv->profile.target = imx_bus_target;
> +	priv->profile.get_dev_status = imx_bus_get_dev_status;
> +	priv->profile.exit = imx_bus_exit;
> +	priv->profile.get_cur_freq = imx_bus_get_cur_freq;
> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
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
> +static const struct of_device_id imx_bus_of_match[] = {
> +	{ .compatible = "fsl,imx8m-noc", },
> +	{ .compatible = "fsl,imx8m-nic", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_bus_of_match);
> +
> +static struct platform_driver imx_bus_platdrv = {
> +	.probe		= imx_bus_probe,
> +	.driver = {
> +		.name	= "imx-bus-devfreq",
> +		.of_match_table = of_match_ptr(imx_bus_of_match),
> +	},
> +};
> +module_platform_driver(imx_bus_platdrv);
> +
> +MODULE_DESCRIPTION("Generic i.MX bus frequency scaling driver");
> +MODULE_AUTHOR("Leonard Crestez <leonard.crestez@nxp.com>");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
