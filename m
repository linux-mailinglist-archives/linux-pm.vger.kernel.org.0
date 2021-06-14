Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8157E3A70C6
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhFNUzQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 16:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhFNUzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 16:55:16 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6321C061574
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 13:53:12 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so12174470otu.6
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5bfGk5VssWAwqPhfKzX3PhfKo0Mnn1eFOm3C4CEvaWw=;
        b=tFUwpyYTUXogFfUPLQEowXY+E6S2fSLsW3+UFsbuEcPFjrB4QC7fx2tFDH+tUfIsop
         kXDLZ19TzRaUTv3fP3Z6BLby/2JRuZhDDtTx6NLHeXMgUnJZMePo5oFG5T4BVLXOPATM
         x3hMSqqv2mb3EF63/cZ+mm7e3o3INuig0RMK6MeINrc4jwMTtNrxvwnbGrfbmzkyymmZ
         Gp32XbuqlcJ/MZbL6L7K2DSs97P3OF4hulzPYKKNww6ulVhCkWnSc3xbbozsnA6kuaoa
         i8AhAEJn8ND12Gv3OjnffWrYYfbE/RN6AYfI6CbYDgwBn5uAoGDhlLBoa8+la136kXNn
         j3rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5bfGk5VssWAwqPhfKzX3PhfKo0Mnn1eFOm3C4CEvaWw=;
        b=PG4CaFT8+/jukZ3xXcdjPtWwkWmV6wcvKcaHNsaxME7epdGZSELyM9PVgn/jp7zynn
         lNXUeyENCn1CkdDf0M2uJXOnzgsbvp0AMTZGzzt8stn7F1BO1Dyz/rm+luyBCW9QAKu0
         SeIyFThNlOoS5yDVk5PF84XOZfQKdQT4QyAy2IaHDnUA7KY1mI1tY6NixqsDlyXPbOFa
         7Hb6amyz2dnzc2rLFZXqNGRfwTvAoiSISuNSgNLVyIA2ruGTOYTOGCLiuvirnhnYfxU1
         QLxwWNa2YLlWQ1ThYzMFQ0ced9tDvfPwl7eHOrmXhkxodRDJagMtmHRBqK5dNmQZrplV
         bcfw==
X-Gm-Message-State: AOAM530r/IN+31dKEVo+nG4/Sn+Dsir+quW0NmOWbjrpW0Xgdpo1ndq5
        hIK/qxyPyuu43UCvvZVYVDznNQ==
X-Google-Smtp-Source: ABdhPJxmSqnCMhz//u91V6RHjacmbBfqU8h/DME9BUJ4FUUV05xkS/Sjz3Q7dQKzrQsb3sGcRT8W/Q==
X-Received: by 2002:a9d:4ef:: with SMTP id 102mr13466435otm.298.1623703992080;
        Mon, 14 Jun 2021 13:53:12 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x35sm656533otr.7.2021.06.14.13.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 13:53:11 -0700 (PDT)
Date:   Mon, 14 Jun 2021 15:53:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/5] thermal: qcom: Add support for LMh driver
Message-ID: <YMfBtSap7fR3rdku@builder.lan>
References: <20210608222926.2707768-1-thara.gopinath@linaro.org>
 <20210608222926.2707768-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608222926.2707768-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue 08 Jun 17:29 CDT 2021, Thara Gopinath wrote:

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
> like CPU. On many newer SoCs LMh is configured by firmware/TZ and no
> programming is needed from the kernel side. But on certain SoCs like sdm845
> the firmware does not do a complete programming of the h/w. On such SoCs
> kernel software has to explicitly set up the temperature limits and turn on
> various monitoring and enforcing algorithms on the hardware.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/thermal/qcom/Kconfig  |  10 ++
>  drivers/thermal/qcom/Makefile |   1 +
>  drivers/thermal/qcom/lmh.c    | 244 ++++++++++++++++++++++++++++++++++
>  3 files changed, 255 insertions(+)
>  create mode 100644 drivers/thermal/qcom/lmh.c
> 
> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
> index 8d5ac2df26dc..c95b95e254d7 100644
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
> +	  hardware(LMh). LMh allows for h/w enforced mitigation for cpus based on
> +	  input from temperature and current sensors.  On many newer Qualcomm SoCs
> +	  LMH is configure in the firmware and this feature need not be enabled.
> +	  However, on certain SoCs like sdm845 LMH has to be configured from HLOS.
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
> index 000000000000..8741a36cb674
> --- /dev/null
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -0,0 +1,244 @@
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
> +#define LMH_TH_HI_TEMP			95000
> +#define LMH_TH_LOW_TEMP			94500
> +#define LMH_TH_ARM_TEMP			65000
> +
> +#define LMH_REG_DCVS_INTR_CLR		0x8
> +
> +struct lmh_hw_data {
> +	void __iomem *base;
> +	struct irq_domain *domain;
> +	int irq;
> +	u32 payload[5];
> +	u32 payload_size;
> +	u32 cpu_id;
> +};
> +
> +static void update_payload(struct lmh_hw_data *lmh_data, u32 fn, u32 reg, u32 val)

Please pass fn, reg and val in the scm function call instead and stuff
the payload array in the scm driver instead.

> +{
> +	lmh_data->payload[0] = fn;
> +	lmh_data->payload[1] = 0;
> +	lmh_data->payload[2] = reg;
> +	lmh_data->payload[3] = 1;
> +	lmh_data->payload[4] = val;
> +}
> +
> +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
> +{
> +	struct lmh_hw_data *lmh_data = data;
> +	int irq = irq_find_mapping(lmh_data->domain, 0);
> +
> +	/*
> +	 * Disable interrupt and call the cpufreq driver to handle the interrupt
> +	 * cpufreq will enable the interrupt once finished processing.
> +	 */
> +	disable_irq_nosync(lmh_data->irq);

The contract between this driver's disabling of the IRQ and the
cpufreq-hw driver's enabling it when we're done polling does worry me.

In the case of EPSS, don't we disable the interrupt during the polling
there as well? If that's the case wouldn't it be better to implement
irq_chip->irq_disable and have the cpufreq-hw driver do the disable in
both cases?

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
> +	writel_relaxed(0xFF, lmh_data->base + LMH_REG_DCVS_INTR_CLR);

Please avoid using _relaxed versions of writel, unless there's a strong
reason and please lowercase the hex digits.

> +	enable_irq(lmh_data->irq);
> +}
> +
> +static struct irq_chip lmh_irq_chip = {
> +	.name           = "lmh",
> +	.irq_enable	= lmh_enable_interrupt,
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
> +	int ret;
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
> +	if (ret)
> +		return -ENODEV;
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
> +		dev_err(dev, "Wrong cpu id associated with lmh node\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Payload size is five bytes for now */
> +	lmh_data->payload_size = 5 * sizeof(u32);
> +
> +	platform_set_drvdata(pdev, lmh_data);
> +
> +	if (!qcom_scm_lmh_dcvsh_available())
> +		return -EINVAL;
> +
> +	/* Enable Thermal Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Current Sensing Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable Reliability Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	/* Enable BCL Algorithm */
> +	update_payload(lmh_data, LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_profile_change(0x1);
> +	if (ret) {
> +		dev_err(dev, "Error %d changing profile\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set default thermal trips */
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, LMH_TH_ARM_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);
> +		return ret;
> +	}
> +
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, LMH_TH_HI_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal HI thershold%d\n", ret);
> +		return ret;
> +	}
> +	update_payload(lmh_data, LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, LMH_TH_LOW_TEMP);
> +	ret = qcom_scm_lmh_dcvsh(lmh_data->payload, lmh_data->payload_size,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM thershold%d\n", ret);
> +		return ret;
> +	}
> +
> +	lmh_data->irq = platform_get_irq(pdev, 0);
> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
> +	if (!lmh_data->domain) {
> +		dev_err(dev, "Error adding irq_domain\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
> +			       "lmh-irq", lmh_data);
> +	if (ret) {
> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
> +		irq_domain_remove(lmh_data->domain);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +static const struct of_device_id lmh_table[] = {
> +	{ .compatible = "qcom,msm-hw-limits", },

Don't we need platform specific compatibles? Perhaps
"qcom,<platform>-lmh"?

If we're going with a generic compatible I think that should be done in
addition to a platform-specific one (and qcom,lmh should be sufficient?)

> +	{},

Please omit the comma here.

> +};

Driver is tristate, so you need a MODULE_DEVICE_TABLE(of, lmh_table);
here, to make sure the module is loaded automatically based on the
compatible strings in DT.

Regards,
Bjorn

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
> +MODULE_DESCRIPTION("QCOM LMH driver");
> -- 
> 2.25.1
> 
