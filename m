Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB875DACD
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2019 03:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfGCB2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jul 2019 21:28:24 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14097 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfGCB2X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jul 2019 21:28:23 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190703012820epoutp04a4dfdb4788a1fc067fef27c858b5144d~twWiRUIyr0517705177epoutp04a
        for <linux-pm@vger.kernel.org>; Wed,  3 Jul 2019 01:28:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190703012820epoutp04a4dfdb4788a1fc067fef27c858b5144d~twWiRUIyr0517705177epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1562117300;
        bh=0MvMxcreUuWDXQwnNIBVUQ4nBFrEQg/CxBcOkNy78MU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s6WgD7MMJ03VU/CQkdrQA0ltFcqlMIEjZq0XvuGlYKTzEjwRjklgTNj8m1nEtx8aI
         hCqjbrWFuxtG1wDb2YhAREWlDyqmgjwPMMPL8HothRcfjUZW1mKULXab+1bLcloM0k
         lGYhy8vwk9l85w8GPT7jcjKpwwciLjd08I6wESQk=
Received: from epsmges1p2.samsung.com (unknown [182.195.40.154]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190703012816epcas1p11c5e2100a88118b6c1720f1bb265b043~twWeIFB3c0166301663epcas1p1v;
        Wed,  3 Jul 2019 01:28:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.B3.04142.0B40C1D5; Wed,  3 Jul 2019 10:28:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20190703012815epcas1p4dff08bb09b21137afbb3e1ee86860b07~twWddhyu32727027270epcas1p4l;
        Wed,  3 Jul 2019 01:28:15 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190703012815epsmtrp2fba7ea49941abbd61b8ab83c572e1ad9~twWdcWjHU1781817818epsmtrp26;
        Wed,  3 Jul 2019 01:28:15 +0000 (GMT)
X-AuditID: b6c32a36-cf9ff7000000102e-4e-5d1c04b0491b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.B0.03662.FA40C1D5; Wed,  3 Jul 2019 10:28:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190703012815epsmtip1ce9af017213817fab4ff40f44793d347~twWdFkcIV1055210552epsmtip1e;
        Wed,  3 Jul 2019 01:28:15 +0000 (GMT)
Subject: Re: [RFCv2 6/8] devfreq: Add imx-devfreq driver
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Saravana Kannan <saravanak@google.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "cpgs (cpgs@samsung.com)" <cpgs@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <c938c3ee-f91f-5207-76ce-f4738fb52441@samsung.com>
Date:   Wed, 3 Jul 2019 10:31:03 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <5531b22cdcb056c66fc0a51b4c839df5d86049d0.1561707104.git.leonard.crestez@nxp.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpll+LIzCtJLcpLzFFi42LZdlhTX3cDi0yswdPFrBZfT59itFh26Sij
        xZepu5gtts9Mtnh5SNNi4+bbLBbT925is1g1dSeLxfnzG9gtzja9YbdYcfcjq8Wmx9dYLT72
        3GO16Pq1ktnic+8RRouLp1wtbjeuYLNYfe4gm8XcL1OZLboO/WWz+HdtI4vFiy3iFsfXhlts
        /OrhIOHx/kYru8eCTaUem1Z1snncubaHzWPzknqPje92MHn0/zXw6NuyitHj8ya5AM6obJuM
        1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoDeVFMoSc0qB
        QgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWWBXrFibnFpXnpesn5uVaGBgZGpkCFCdkZ/VO/
        MBW8NavYvlW2gfGwThcjJ4eEgInEnjffWbsYuTiEBHYwSnT9fMEO4XxilFhy5zgThPONEahs
        AxtMy7+O3VAtexkl5nUfZoFw3jNK9PxcBeRwcAgLWEi82JwL0iAi8Aeoe2oSSA2zQBurxKPH
        T8AmsQloSex/cQPM5hdQlLj64zEjiM0rYCexbcFiMJtFQEXi9pKtYLaoQITE5S27oGoEJU7O
        fMICYnMKxEncvtHODmIzC4hL3HoynwnClpdo3jqbGWSxhEAjh8TVv/uZIF5wkXjzeTo7hC0s
        8er4FihbSuLzu71Qb1ZLrDx5hA2iuYNRYsv+C6wQCWOJ/UsnM4F8ySygKbF+lz5EWFFi5++5
        jBA2r0TDxt9QB/FJvPvawwpSDhLvaBOCKFGWuPzgLtMERuVZSN6ZheSFWUhemIWwbAEjyypG
        sdSC4tz01GLDAiPk2N7ECM4CWmY7GBed8znEKMDBqMTD6+EnHSvEmlhWXJl7iFGCg1lJhHf/
        CslYId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPzFB5JfGGpkbGxsYWJoZmpoaGSuK88dw3
        Y4QE0hNLUrNTUwtSi2D6mDg4pRoY9c6K5QjvvTiDue7Z5Ko1b3y+3eT6Jm74TvPOk88st/o4
        Q/d/cj2XNC0o9bFQ7bbcwh3C4fVbv6isfrakNMJjQ1da8tqOcjGZVP6Eg/Z95d/lD670PDKj
        wn5rwkaXx401nXacdl7nV+kdyzl9doO9XxTXp+W/WnjDs6Kn8z27vvaN2tTbL16uV2Ipzkg0
        1GIuKk4EALt7ICEYBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeT1nZ5dcnTZz7zK1VhCOUlcibxfEIuF8y4LQgmVDD2q6OXbm
        LQjtouUo9UMznV3MJHTSZfMyTU3c8jpMlNStlYRKLkjNdBSRlnMEfvs9/+f/ez49HEywiO/k
        pKu0tEalyJQQPLzVJgk5+BLfJY9c9AiRxz4E0LOxXoBW9K8xZKlKRl+tYcjU5MLR/S4zgYz6
        dhyNjLxio+Hr39io/tMSC5lnJlho6c4UC+l+N2Bo+e5bgEaH4pDrWj2BGt/1EOjhih5DOusq
        gdYmTDhyN4tQ//MEZPJQsZBadBSxqRpzNmU2lhDUx4lOgmqqK6BMC21+VNlqJFXabATUsjkk
        nnuBdzyFzkzPoTURMZd4aWX6FT/1fHSepSW4ENgO6ACXA8kouHa7g+VlAdkBYN/fMF8uhhWj
        vZgOcNZZCG02Rgd465V5AJef9LG9uZBE0N2k9OYB5BqA99rn2N4BI4tZ8PP7HyyfMb1+tMsJ
        vFcJUgq73Q7Cy9vIPXD818xGzidjYGvN0w3GyX3QVdeywTvIRFhaXE34OtvhYNUs7mUueRG6
        HLfYXsbI/fDPozHMxyL4Yfaxn49D4Y2WaqwcCA2bdMMmxbBJMWxSagBuBGJazShTlYxMfUhF
        54YzCiWTrUoNT85SmsHGG0ilbWBgIMkKSA6Q+PNr4oPkApYih8lXWgHkYJIAfne9WC7gpyjy
        r9CarCRNdibNWEEQB5eI+KFZfecFZKpCS2fQtJrW/N/6cbg7C8HVIhl3b6A071hK7OGeRLl7
        Wp/jlAxGnGqLkTZG2efKtXFfHNoBbUJfoJtHywoqe4LFqgdHG0qmNJWyMOek1R5SX3vujOq7
        xaOs6xw36LYs+CsrDLnO+Oifa/wT5hc35bW7h0UZJ8++KS2wqE9vFUxS9ory8cuMCPccKe4v
        kuBMmkImxTSM4h9o3GWbAgMAAA==
X-CMS-MailID: 20190703012815epcas1p4dff08bb09b21137afbb3e1ee86860b07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190628074015epcas5p262581ad38abeceb9e496cbc1094d4fef
References: <cover.1561707104.git.leonard.crestez@nxp.com>
        <CGME20190628074015epcas5p262581ad38abeceb9e496cbc1094d4fef@epcas5p2.samsung.com>
        <5531b22cdcb056c66fc0a51b4c839df5d86049d0.1561707104.git.leonard.crestez@nxp.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Leonard,

On 19. 6. 28. 오후 4:39, Leonard Crestez wrote:
> Add initial support for frequency switches on pieces of the imx
> interconnect fabric.
> 
> Uses clk_set_min_rate so that other subsytems can also impose minimum
> rate requests.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---
>  drivers/devfreq/Kconfig       |  10 +++
>  drivers/devfreq/Makefile      |   1 +
>  drivers/devfreq/imx-devfreq.c | 142 ++++++++++++++++++++++++++++++++++
>  3 files changed, 153 insertions(+)
>  create mode 100644 drivers/devfreq/imx-devfreq.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index f3b242987fd9..3a7c6265ca2f 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -90,10 +90,20 @@ config ARM_EXYNOS_BUS_DEVFREQ
>  	  Each memory bus group could contain many memoby bus block. It reads
>  	  PPMU counters of memory controllers by using DEVFREQ-event device
>  	  and adjusts the operating frequencies and voltages with OPP support.
>  	  This does not yet operate with optimal voltages.
>  
> +config ARM_IMX_DEVFREQ
> +	tristate "i.MX DEVFREQ Driver"
> +	depends on ARCH_MXC

You don't need to add 'COMPILE_TEST' as following?
	depends on ARCH_MXC || COMPILE_TEST

> +	select DEVFREQ_GOV_USERSPACE
> +	select PM_OPP
> +	help
> +	  This adds the DEVFREQ driver for the Tegra family of SoCs.
> +	  It reads ACTMON counters of memory controllers and adjusts the
> +	  operating frequencies and voltages with OPP support.

Maybe, you referred to the description of ARM_TEGRA_DEVFREQ.
You have to modify it according to the role of IMX_DEVFREQ.

> +
>  config ARM_TEGRA_DEVFREQ
>  	tristate "NVIDIA Tegra30/114/124/210 DEVFREQ Driver"
>  	depends on ARCH_TEGRA_3x_SOC || ARCH_TEGRA_114_SOC || \
>  		ARCH_TEGRA_132_SOC || ARCH_TEGRA_124_SOC || \
>  		ARCH_TEGRA_210_SOC || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index 338ae8440db6..c2463ed4c934 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -7,10 +7,11 @@ obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+= governor_powersave.o
>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+= governor_userspace.o
>  obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+= governor_passive.o
>  
>  # DEVFREQ Drivers
>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
> +obj-$(CONFIG_ARM_IMX_DEVFREQ)		+= imx-devfreq.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
>  obj-$(CONFIG_ARM_TEGRA20_DEVFREQ)	+= tegra20-devfreq.o
>  
>  # DEVFREQ Event Drivers
> diff --git a/drivers/devfreq/imx-devfreq.c b/drivers/devfreq/imx-devfreq.c
> new file mode 100644
> index 000000000000..aa8868d32f22
> --- /dev/null
> +++ b/drivers/devfreq/imx-devfreq.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 NXP
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/devfreq-event.h>
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
> +};
> +
> +static int imx_devfreq_target(struct device *dev, unsigned long *freq, u32 flags)
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
> +	ret = clk_set_min_rate(priv->clk, new_freq);
> +        if (ret)

Fix the indentation.

> +		return ret;
> +
> +	ret = clk_set_rate(priv->clk, 0);
> +	if (ret) {
> +		clk_set_min_rate(priv->clk, priv->devfreq->previous_freq);
> +		return ret;
> +	}
> +
> +	return 0;
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
> +		struct devfreq_dev_status *stat)
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
> +	return dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int imx_devfreq_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_devfreq *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->devfreq)) {
> +		ret = PTR_ERR(priv->devfreq);
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
> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
> +						DEVFREQ_GOV_USERSPACE,
> +						NULL);
> +	if (IS_ERR(priv->devfreq)) {
> +		ret = PTR_ERR(priv->devfreq);
> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
> +		goto err_remove_table;
> +	}
> +
> +	return 0;
> +
> +err_remove_table:
> +	dev_pm_opp_of_remove_table(dev);
> +	return ret;
> +}
> +
> +static const struct of_device_id imx_devfreq_of_match[] = {
> +	{ .compatible = "fsl,imx8mm-ddrc", },
> +	{ .compatible = "fsl,imx8mm-noc", },
> +	{ .compatible = "fsl,imx8mm-nic", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, imx_devfreq_of_match);
> +
> +static struct platform_driver imx_devfreq_platdrv = {
> +	.probe		= imx_devfreq_probe,
> +	.driver = {
> +		.name	= "devfreq-imx",
> +		.of_match_table = of_match_ptr(imx_devfreq_of_match),
> +	},
> +};
> +module_platform_driver(imx_devfreq_platdrv);
> +
> +MODULE_DESCRIPTION("Generic i.MX bus frequency driver");
> +MODULE_LICENSE("GPL v2");
> 

Why don't you add the author information?

And when you are sending the patch, you better
to use get_maintainer.pl script to contain
the related all maintainers/reviewers.


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
