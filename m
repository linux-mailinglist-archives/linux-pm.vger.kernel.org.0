Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97936864F8
	for <lists+linux-pm@lfdr.de>; Wed,  1 Feb 2023 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjBALDM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Feb 2023 06:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjBALDH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Feb 2023 06:03:07 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B25E55BB;
        Wed,  1 Feb 2023 03:02:57 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 7so7295460pgh.7;
        Wed, 01 Feb 2023 03:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DceIlcz7tCoQ/WNnHU3QRL3ZPrUM/et/4+cwphHyZVo=;
        b=YMERq+jo+9nZx8onlIiHnvFPFUn6mdyeEqXO431QYRoVmiQ9Q116SA2p1q3tykzO5Y
         P+NR0gK2LRaV5brvBSNkSeqsOyaD7eTpFJUMK7sipoVkFXRP7HSUTiy+xDCtSMmUfdSm
         bVie87GA2WCCSufqEcDn6JTTGy48nEATS/dmaiwcdsA067fEENPkwg4MAwXLO3mKkvYQ
         ngGnoTeP+68sj/ROTY6VzNzmpe+J1KGZ3EoHXANAmxltFfIfMYT4PPPNxK2xi4ivDjr2
         /3+K6DZHbwkQ+SdD8j1atNVRH7rCiklINWxbI1BBdqovCse9fWThIO/BUOgWiCvViRxw
         Aq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DceIlcz7tCoQ/WNnHU3QRL3ZPrUM/et/4+cwphHyZVo=;
        b=Oap/gQ5DX2zJ2cWHCWOj9o/9037HUcJFsawInfXYKBwF2unrerm4QX/65/UlI0hqye
         cBcwbafqsvutUoj2fmZpU5ETKIocv93Zg36LVgSZcR1WHg9r7OqoZi5b8iAYoKQ5r0sK
         LPDWDnXHsej3ey1ZQxscyzC3wzJvqk3BfuK16CctKPQNzcFcEBNexhDm8BFvwIgQVHTM
         qAzt00MjH8CNu49dJtVoM+o6NddEWTKlBANxJAObimuk50zXnC3iK8vSd33sUyDU2yLY
         T/GQmHe3QMPxIpUl62sy3mqTVkIBW4ebyX8e15htE3m0zNbFq7kw417bSlhwcJzy/gf6
         QgUg==
X-Gm-Message-State: AO0yUKXvuf+MSkQSN6iA0NuSa0QWtoXqqDVIPiK2sMiLmZ4DHulKyqzz
        k6kLTIlAU8jYWPWr1Udi68NG4SIbwBa+Gg==
X-Google-Smtp-Source: AK7set8Hus/TW6hqB7rmqLK7f4INwf+AwZC03ro8sJa0NADi/Yem3ot2EmnSfzmQwET4ZkZvjkZRsQ==
X-Received: by 2002:a05:6a00:10c8:b0:593:c648:f836 with SMTP id d8-20020a056a0010c800b00593c648f836mr2515637pfu.3.1675249376175;
        Wed, 01 Feb 2023 03:02:56 -0800 (PST)
Received: from [172.30.1.94] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id s9-20020a62e709000000b0058de0998f17sm11127029pfh.154.2023.02.01.03.02.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:02:55 -0800 (PST)
Message-ID: <cee1778f-70a0-4bb5-a18f-4dd89cf62a2e@gmail.com>
Date:   Wed, 1 Feb 2023 20:02:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] PM / devfreq: qcom: Introduce CCI devfreq driver
To:     Jun Nie <jun.nie@linaro.org>, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, cw00.choi@samsung.com
Cc:     bryan.odonoghue@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230201080227.473547-1-jun.nie@linaro.org>
 <20230201080227.473547-2-jun.nie@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230201080227.473547-2-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 23. 2. 1. 17:02, Jun Nie wrote:
> Cache Coherent Interconnect (CCI) is used by some Qualcomm SoCs. This
> driver is introduced so that its freqency can be adjusted. And regulator
> associated with opp table can be also adjusted accordingly which is
> shared with cpu cluster.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/devfreq/Kconfig    |   9 +++
>  drivers/devfreq/Makefile   |   1 +
>  drivers/devfreq/qcom-cci.c | 162 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/devfreq/qcom-cci.c
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 9754d8b31621..6f3f1872f3fb 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -130,6 +130,15 @@ config ARM_MEDIATEK_CCI_DEVFREQ
>  	  buck voltages and update a proper CCI frequency. Use the notification
>  	  to get the regulator status.
>  
> +config ARM_QCOM_CCI_DEVFREQ
> +	tristate "QUALCOMM CCI DEVFREQ Driver"
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	select DEVFREQ_GOV_PASSIVE
> +	help
> +	  This adds a devfreq driver for Qualcomm Cache Coherent Interconnect which
> +	  shares the same regulator with the cpu cluster. This driver can track a
> +	  proper regulator state while CCI frequency is updated.

Maybe, this driver use the passive governor because as this description,
the regulator is shared with cpu cluster. But, as I commented below,
you use the 'userspace' governor in probe. is it right?

> +
>  config ARM_RK3399_DMC_DEVFREQ
>  	tristate "ARM RK3399 DMC DEVFREQ Driver"
>  	depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> index bf40d04928d0..f2526d8c168d 100644
> --- a/drivers/devfreq/Makefile
> +++ b/drivers/devfreq/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+= exynos-bus.o
>  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)	+= imx-bus.o
>  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)	+= imx8m-ddrc.o
>  obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ)	+= mtk-cci-devfreq.o
> +obj-$(CONFIG_ARM_QCOM_CCI_DEVFREQ)	+= qcom-cci.o
>  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)	+= rk3399_dmc.o
>  obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)	+= sun8i-a33-mbus.o
>  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)		+= tegra30-devfreq.o
> diff --git a/drivers/devfreq/qcom-cci.c b/drivers/devfreq/qcom-cci.c
> new file mode 100644
> index 000000000000..21b5f133cddc
> --- /dev/null
> +++ b/drivers/devfreq/qcom-cci.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2023 Linaro Ltd.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/devfreq.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_opp.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#define SPEED_PVS(s, p) ((s << 16) | p)

What it meaning of PVS? Could you add the comment for 'PVS' and 's', 'p'?

> +
> +struct qcom_cci {
> +	struct devfreq_dev_profile profile;
> +	struct devfreq *devfreq;
> +	struct clk *clk;
> +};
> +
> +static int qcom_cci_target(struct device *dev,
> +		unsigned long *freq, u32 flags)

Actually, this line is not long. You can type it on one line as following:

static int qcom_cci_target(struct device *dev, unsigned long *freq, u32 flags)

> +{
> +	struct dev_pm_opp *new_opp;
> +	int ret;

As I mentioned belwo, this local variable is not needed
if just return PTR_ERR(new_opp).

> +
> +	new_opp = devfreq_recommended_opp(dev, freq, flags);
> +	if (IS_ERR(new_opp)) {
> +		ret = PTR_ERR(new_opp);
> +		dev_err(dev, "failed to get recommended opp: %d\n", ret);
> +		return ret;

Better to add 'return PTR_ERR(new_opp)' without 'ret' local variable.

> +	}
> +	dev_pm_opp_put(new_opp);
> +
> +	return dev_pm_opp_set_rate(dev, *freq);
> +}
> +
> +static int qcom_cci_get_cur_freq(struct device *dev, unsigned long *freq)
> +{
> +	struct qcom_cci *priv = dev_get_drvdata(dev);
> +
> +	*freq = clk_get_rate(priv->clk);
> +
> +	return 0;
> +}
> +
> +static int qcom_get_dev_version(struct nvmem_cell *speedbin_nvmem)
> +{
> +	int speed = 0, pvs = 0;
> +	u8 *speedbin;
> +	size_t len;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	speed = (speedbin[0xc] >> 2) & 0x7;
> +	pvs = (speedbin[0x3] >> 5 & 0x1) | ((speedbin[0x6] >> 2 & 0x3) << 1);

Actually, 0xc, 0x3, 0x7, 0x1 and so on. It is impossible to understand
the meaning of this hex value. Plesae add the constant defintion 
for the readability. 

> +	kfree(speedbin);
> +
> +	/* Convert speedbin and PVS into version bit map */
> +	switch (SPEED_PVS(speed, pvs)) {
> +	case SPEED_PVS(0, 0): return 0x1;
> +	case SPEED_PVS(2, 0): return 0x2;
> +	case SPEED_PVS(2, 2): return 0x4;
> +	case SPEED_PVS(4, 0): return 0x8;
> +	case SPEED_PVS(5, 0): return 0x10;
> +	case SPEED_PVS(5, 6): return 0x20;
> +	default:
> +		return 0x1;> +	}
> +}
> +
> +static void qcom_cci_exit(struct device *dev)
> +{
> +	dev_pm_opp_of_remove_table(dev);
> +}
> +
> +static int qcom_cci_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct qcom_cci *priv;
> +	const char *gov = DEVFREQ_GOV_USERSPACE;

Even if you select 'DEVFREQ_GOV_PASSIVE' on Kconfig,
Is it right that this driver use the userspace governor?


> +	struct device_node *np = dev->of_node;
> +	struct nvmem_cell *speedbin_nvmem;
> +	int ret;
> +	u32 version;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		ret = PTR_ERR(priv->clk);
> +		dev_err(dev, "failed to fetch clk: %d\n", ret);
> +		return ret;

You can use dev_err_probe as following:

	return dev_err_probe(dev, ret, "failed to fetch clk: %d\n", ret);

> +	}
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* Check whether we have profiled speed version per chip */
> +	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
> +	if (IS_ERR(speedbin_nvmem))
> +		return PTR_ERR(speedbin_nvmem);

I recommend that you need to add the fail log with dev_err.

> +
> +	version = qcom_get_dev_version(speedbin_nvmem);
> +	dev_info(dev, "%s: set opp table version 0x%x\n", __func__, version);

Don't need to use '__func__' because dev_info will print the module name.
It is enough.

> +
> +	nvmem_cell_put(speedbin_nvmem);
> +	ret = dev_pm_opp_set_supported_hw(dev, &version, 1);
> +	if (ret) {
> +		dev_err(dev, "Failed to set supported hardware\n");
> +		return ret;
> +	}
> +
> +	ret = dev_pm_opp_of_add_table(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get OPP table\n");
> +		return ret;
> +	}
> +
> +	priv->profile.target = qcom_cci_target;
> +	priv->profile.exit = qcom_cci_exit;
> +	priv->profile.get_cur_freq = qcom_cci_get_cur_freq;
> +	priv->profile.initial_freq = clk_get_rate(priv->clk);
> +
> +	priv->devfreq = devm_devfreq_add_device(dev, &priv->profile,
> +						gov, NULL);
> +	if (IS_ERR(priv->devfreq)) {
> +		ret = PTR_ERR(priv->devfreq);
> +		dev_err(dev, "failed to add devfreq device: %d\n", ret);
> +		goto err;

Need to goto 'err_remove_opp_table' instead of 'err'.

> +	}
> +
> +	return 0;
> +
> +err:
> +	dev_pm_opp_of_remove_table(dev);
> +	return ret;

For more correct exception handling, need to change it as following:

err_remove_opp_table:
	dev_pm_opp_of_remove_table(dev);
err:
	return ret;

> +}
> +
> +static const struct of_device_id qcom_cci_of_match[] = {
> +	{ .compatible = "qcom,msm8939-cci"},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, qcom_cci_of_match);
> +
> +static struct platform_driver qcom_cci_platdrv = {
> +	.probe		= qcom_cci_probe,
> +	.driver = {
> +		.name	= "qcom-cci-devfreq",
> +		.of_match_table = qcom_cci_of_match,
> +	},
> +};
> +module_platform_driver(qcom_cci_platdrv);
> +
> +MODULE_DESCRIPTION("QCOM cci frequency scaling driver");

cci is the abbreviation. You need to use the captical letter as following:

MODULE_DESCRIPTION("QCOM CCI frequency scaling driver");

> +MODULE_AUTHOR("Jun Nie <jun.nie@linaro.org>");
> +MODULE_LICENSE("GPL");

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

