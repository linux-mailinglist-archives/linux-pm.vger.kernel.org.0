Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D373B34B6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhFXR0p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 13:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhFXR0p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 13:26:45 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2135C061760
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:24:25 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso5803216pjx.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Jun 2021 10:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xHc8C92sx8/aohYtG12VyQHoC26k/+GZRETwEpgiO+0=;
        b=RZxe0tir/QylxunE8fp0YLkvO7A2D2CndwzO04V1dtp9BzZawp2oCimmVCrlIEUoVb
         uDK6y4qbnaf8wnMJA1BoRqiTJWOcE96YW5bUkPKXXV8sYYrDI0MuRjgaZf2wgnUV37Er
         TJRbGkreUhw18hXYu4yLl3LSK6dRHjulQT0YY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xHc8C92sx8/aohYtG12VyQHoC26k/+GZRETwEpgiO+0=;
        b=dkuUogQP/GW5uvxBiJvpQ8w3DP1jtY8djqzamMW2iJt7UTN7bYzqYYkocqtc7YFpsE
         8Nr8pidDMb+3G7IA9SVK2k1iidGqSBtRfBpoH4YAfAW8p7vbJS5Euvqlv6PQuqMXQKaA
         6ozxQMR8XE1iMogYsndhwWTuybrDAsrvtiBaaycrl8TIwScGZDQkpSVZcmQHdQLxpR9a
         37JhJfZ2fEb8JdSHb+XlSlA3ieZaWW165mz5oZIUX7A2EyXHN8wIa5DQIH5e7Plus+tg
         NSfalVbnlrAQIYU6Xi4iKVVowhwe2SSMFn/l5hdvRibJkfvpj+wdIaMuJizPIRAkzxyC
         eNfg==
X-Gm-Message-State: AOAM530vwJmNttY/e0X16Wc+GZln364gB98Lz8vFq5a9o6BAPm6ePVqh
        iByl8uQ6kOKJv2rtKtaK7ufBsA==
X-Google-Smtp-Source: ABdhPJz3HsT9zY/XmGDI2TMeforqk4W6CxtzXkF5wjbxzg5a7FeqObOcpVvraLlkPaq32eK25Zl1AA==
X-Received: by 2002:a17:90a:fb48:: with SMTP id iq8mr6396730pjb.135.1624555465476;
        Thu, 24 Jun 2021 10:24:25 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:dda9:4015:5d1f:23fe])
        by smtp.gmail.com with UTF8SMTPSA id y6sm2888822pgk.79.2021.06.24.10.24.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 10:24:25 -0700 (PDT)
Date:   Thu, 24 Jun 2021 10:24:23 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v2 2/5] thermal: qcom: Add support for LMh driver
Message-ID: <YNS/x8Po4kGILcOC@google.com>
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624115813.3613290-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 24, 2021 at 07:58:10AM -0400, Thara Gopinath wrote:
> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
> current, battery current violations, enabling reliability algorithm and
> setting up various temperature limits.
> 
> The following has been explained in the cover letter. I am including this
> here so that this remains in the commit message as well.
> 
> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
> temperature and current limits as programmed by software for certain IPs
> like CPU. On many newer LMh is configured by firmware/TZ and no programming
> is needed from the kernel side. But on certain SoCs like sdm845 the
> firmware does not do a complete programming of the h/w. On such soc's
> kernel software has to explicitly set up the temperature limits and turn on
> various monitoring and enforcing algorithms on the hardware.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v1->v2:
> 	- Cosmetic and spelling fixes from review comments from Randy Dunlap
> 	- Added irq_disable to lmh_irq_ops and removed disabling of irq from
> 	  lmh_handle_irq. Now cpufreq explicitly disables irq prior to
> 	  handling it as per Bjorn's suggestion.
> 	- Rebased to new version of qcom_scm_lmh_dcvsh as changed in patch 1.
> 	- Removed generic dt compatible string and introduced platform specific one
> 	  as per Bjorn's suggestion.
> 	- Take arm, low and high temp thresholds for LMh from dt properties instead of
> 	  #defines in the driver as per Daniel's suggestion.
> 	- Other minor fixes.
> 
>  drivers/thermal/qcom/Kconfig  |  10 ++
>  drivers/thermal/qcom/Makefile |   1 +
>  drivers/thermal/qcom/lmh.c    | 251 ++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/thermal/qcom/lmh.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 8d5ac2df26dc..7d942f71e532 100644
> --- a/drivers/thermal/qcom/Kconfig
> +++ b/drivers/thermal/qcom/Kconfig
> @@ -31,3 +31,13 @@ config QCOM_SPMI_TEMP_ALARM
>  	  trip points. The temperature reported by the thermal sensor reflects the
>  	  real time die temperature if an ADC is present or an estimate of the
>  	  temperature based upon the over temperature stage value.
> +
> +config QCOM_LMH
> +	tristate "Qualcomm Limits Management Hardware"
> +	depends on ARCH_QCOM
> +	help
> +	  This enables initialization of Qualcomm limits management
> +	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
> +	  input from temperature and current sensors.  On many newer Qualcomm SoCs
> +	  LMh is configured in the firmware and this feature need not be enabled.
> +	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index 252ea7d9da0b..0fa2512042e7 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -5,3 +5,4 @@ qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>  				   tsens-8960.o
>  obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
>  obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
> +obj-$(CONFIG_QCOM_LMH)		+= lmh.o
> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
> new file mode 100644
> index 000000000000..a14cad83b459
> --- /dev/null
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -0,0 +1,251 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2021, Linaro Limited. All rights reserved.
> + */
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +#include <linux/qcom_scm.h>
> +
> +#define LMH_NODE_DCVS			0x44435653
> +#define LMH_CLUSTER0_NODE_ID		0x6370302D
> +#define LMH_CLUSTER1_NODE_ID		0x6370312D
> +
> +#define LMH_SUB_FN_THERMAL		0x54484D4C
> +#define LMH_SUB_FN_CRNT			0x43524E54
> +#define LMH_SUB_FN_REL			0x52454C00
> +#define LMH_SUB_FN_BCL			0x42434C00
> +
> +#define LMH_ALGO_MODE_ENABLE		0x454E424C
> +#define LMH_TH_HI_THRESHOLD		0x48494748
> +#define LMH_TH_LOW_THRESHOLD		0x4C4F5700
> +#define LMH_TH_ARM_THRESHOLD		0x41524D00
> +
> +#define LMH_REG_DCVS_INTR_CLR		0x8
> +
> +struct lmh_hw_data {
> +	void __iomem *base;
> +	struct irq_domain *domain;
> +	int irq;
> +	u32 cpu_id;
> +};
> +
> +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
> +{
> +	struct lmh_hw_data *lmh_data = data;
> +	int irq = irq_find_mapping(lmh_data->domain, 0);
> +
> +	/*
> +	 * Call the cpufreq driver to handle the interrupt.
> +	 */

no need for a multiline comment

> +	if (irq)
> +		generic_handle_irq(irq);
> +
> +	return 0;
> +}
> +
> +static void lmh_enable_interrupt(struct irq_data *d)
> +{
> +	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
> +
> +	/* Clear the existing interrupt */
> +	writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
> +	enable_irq(lmh_data->irq);
> +}
> +
> +static void lmh_disable_interrupt(struct irq_data *d)
> +{
> +	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
> +
> +	disable_irq_nosync(lmh_data->irq);
> +}
> +
> +static struct irq_chip lmh_irq_chip = {
> +	.name           = "lmh",
> +	.irq_enable	= lmh_enable_interrupt,
> +	.irq_disable	= lmh_disable_interrupt
> +};
> +
> +static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +	struct lmh_hw_data *lmh_data = d->host_data;
> +
> +	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
> +	irq_set_chip_data(irq, lmh_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops lmh_irq_ops = {
> +	.map = lmh_irq_map,
> +	.xlate = irq_domain_xlate_onecell,
> +};
> +
> +static int lmh_probe(struct platform_device *pdev)
> +{
> +	struct device *dev;
> +	struct device_node *np;
> +	struct lmh_hw_data *lmh_data;
> +	u32 node_id;
> +	int temp_low, temp_high, temp_arm, ret;
> +
> +	dev = &pdev->dev;
> +	np = dev->of_node;
> +	if (!np)
> +		return -EINVAL;
> +
> +	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
> +	if (!lmh_data)
> +		return -ENOMEM;
> +
> +	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lmh_data->base))
> +		return PTR_ERR(lmh_data->base);
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-cpu-id", &lmh_data->cpu_id);

binding missing?

> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-cpu-id property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-high", &temp_high);
> +	if (ret) {

ditto

> +		dev_err(dev, "missing qcom,lmh-temperature-high property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-low", &temp_low);
> +	if (ret) {

ditto

> +		dev_err(dev, "missing qcom,lmh-temperature-low property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-arm", &temp_arm);
> +	if (ret) {

ditto

> +		dev_err(dev, "missing qcom,lmh-temperature-arm property\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
> +	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
> +	 * of a dt match table.
> +	 */
> +	if (lmh_data->cpu_id == 0) {
> +		node_id = LMH_CLUSTER0_NODE_ID;
> +	} else if (lmh_data->cpu_id == 4) {
> +		node_id = LMH_CLUSTER1_NODE_ID;
> +	} else {
> +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
> +		return -EINVAL;
> +	}
> +
> +	platform_set_drvdata(pdev, lmh_data);
> +
> +	if (!qcom_scm_lmh_dcvsh_available())
> +		return -EINVAL;
> +
> +	/* Enable Thermal Algorithm */

nit: thermal algorithm

Same for other comments below.

Actually I think you can delete the comments, the error log a few lines below
provides the same information.

> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Current Sensing Algorithm */
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Reliability Algorithm */
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {

disable thermal subfunction??

> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable BCL Algorithm */
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {

disable previously enabled stuff?

> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_profile_change(0x1);

Does profile 1 represent something specific, i.e. should this be a constant?
If not, why a hex instead of a decimal value?

> +	if (ret) {

disable previously enabled stuff?

> +		dev_err(dev, "Error %d changing profile\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set default thermal trips */
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {

undo stuff?

> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {

undo stuff?

> +		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {

undo stuff?

> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
> +		return ret;
> +	}
> +
> +	lmh_data->irq = platform_get_irq(pdev, 0);
> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
> +	if (!lmh_data->domain) {

undo stuff?

> +		dev_err(dev, "Error adding irq_domain\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
> +			       "lmh-irq", lmh_data);
> +	if (ret) {

undo stuff?

> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
> +		irq_domain_remove(lmh_data->domain);
> +		return ret;
> +	}
> +
> +	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
> +	disable_irq(lmh_data->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id lmh_table[] = {
> +	{ .compatible = "qcom,sdm845-lmh", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, lmh_table);
> +
> +static struct platform_driver lmh_driver = {
> +	.probe = lmh_probe,
> +	.driver = {
> +		.name = "qcom-lmh",
> +		.of_match_table = lmh_table,
> +	},
> +};
> +module_platform_driver(lmh_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM LMh driver");
> -- 
> 2.25.1
> 
