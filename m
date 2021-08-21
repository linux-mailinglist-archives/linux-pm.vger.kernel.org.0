Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B459D3F39EA
	for <lists+linux-pm@lfdr.de>; Sat, 21 Aug 2021 11:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbhHUJlw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 21 Aug 2021 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbhHUJlv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Aug 2021 05:41:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383D7C06175F
        for <linux-pm@vger.kernel.org>; Sat, 21 Aug 2021 02:41:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so17880984wrs.0
        for <linux-pm@vger.kernel.org>; Sat, 21 Aug 2021 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=defXgJNMGstYRhCF8ONqO9+5/XVgcipP497hoW+zv1g=;
        b=arxZhscJnhuNRya/y63eouJWZpRFVlWoC5RJ31m1zQtriCSx1fo/nOYWtppDcptQxp
         8GLlL5xyWTvYe6dkzBWa6FS7UtK/BUhxtviFMvG4uxWFSmLD0xc4ZqEMaNt/fXmHStOA
         lZI2kWarNUL9jCrG9nHw8n0G+OJVAwGEqDRDcYKDvmYRmC3Qp2E3ANv5lK3Hq220Vegz
         BRFhTauacxoG53kG3RtvrXN7wmC1DZluJ16jPChbvUh3nRailltADT6bXlWkr4W1FUv9
         x4Nn3VjUA7syhPflVaV6b9DVSyABz2QEL4p+Dh0kxALDrdWfQn4BdlhIdfsKYT8Si7kr
         dHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=defXgJNMGstYRhCF8ONqO9+5/XVgcipP497hoW+zv1g=;
        b=btiEV60nF8dD0DL/l/pf6ozxVT+4e60+cyx/vlWRw4IlmRyP4kV8VDOGrkEpIT4UNE
         MMd7lOfpq49wPwU6s5ZZ46izxlgh3wPGtrPifaCUmjYAskmTCedqkrO25Ge9fPtHKltd
         5/fc+K5qmgBgI37xJt6nYowJmw78B1ZI3jO1M+v/OxKpF3A1w2Kyt2T8x2hGcc8PaeWI
         iQYOIo1E+gp3pZXRUtN58GppH8d/VVnDFviGtYQ2e7iZIt4D0qVRkTKu1xnidqQrVEEt
         w+J2oYdlc7vmIxSothb9xSCQDhmBq5NqnWjy+haV+SC0PsXqgNLQ/EyfReFN1NRrmwTF
         vJjg==
X-Gm-Message-State: AOAM530H38LR3rQBuAkHcKV/a+BvTUVtUi59Xee7d1cou80HRfgjrGkJ
        mEYheA2PTttL7eTup36kZAuC8A==
X-Google-Smtp-Source: ABdhPJzmr5nWYtmDQhUCWlxXi83+L6HsLQnQ08FPu9AFcKawPHv82sQWrP5/KBIDBfLJt2jOs5b+jA==
X-Received: by 2002:adf:c044:: with SMTP id c4mr3001815wrf.275.1629538870421;
        Sat, 21 Aug 2021 02:41:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e7c:3055:aad:f62d? ([2a01:e34:ed2f:f020:e7c:3055:aad:f62d])
        by smtp.googlemail.com with ESMTPSA id q11sm248813wrx.85.2021.08.21.02.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 02:41:09 -0700 (PDT)
Subject: Re: [Patch v5 2/6] thermal: qcom: Add support for LMh driver
To:     Thara Gopinath <thara.gopinath@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-3-thara.gopinath@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fcbb6d64-7e39-7f03-e76c-512946124777@linaro.org>
Date:   Sat, 21 Aug 2021 11:41:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210809191605.3742979-3-thara.gopinath@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Thara,

On 09/08/2021 21:16, Thara Gopinath wrote:
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
> Tested-by: Steev Klimaszewski <steev@kali.org> # Lenovo Yoga C630
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

Is it possible to have an option to disable/enable the LMh driver at
runtime, for instance with a module parameter ?

> ---
> 
> v4->v5:
> 	- Minor change related to renaming of dt binding property qcom,lmh-cpu
> 	  to cpus as per Rob Herring's review comments.
> 
> v3->v4:
> 	- Minor code re-arrangement and removal of redundant code as per Bjorn's
> 	  review comments
> 	- Added suppress_bind_attrs to driver as per Bjorn's review comments.
> 	- Changes to support changes in LMh dt node properties naming and types.
> 
> v2->v3:
> 	- Rearranged enabling of various LMh subfunction and removed returning
> 	  on error in enabling any one subfunction as the different pieces can
> 	  operate and thus be enabled independently.
> 	- Other minor cosmetic fixes.
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
>  drivers/thermal/qcom/lmh.c    | 232 ++++++++++++++++++++++++++++++++++
>  3 files changed, 243 insertions(+)
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
> index 000000000000..eafa7526eb8b
> --- /dev/null
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -0,0 +1,232 @@
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
> +};
> +
> +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
> +{
> +	struct lmh_hw_data *lmh_data = data;
> +	int irq = irq_find_mapping(lmh_data->domain, 0);
> +
> +	/* Call the cpufreq driver to handle the interrupt */
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
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *cpu_node;
> +	struct lmh_hw_data *lmh_data;
> +	int temp_low, temp_high, temp_arm, cpu_id, ret;
> +	u32 node_id;
> +
> +	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
> +	if (!lmh_data)
> +		return -ENOMEM;
> +
> +	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lmh_data->base))
> +		return PTR_ERR(lmh_data->base);
> +
> +	cpu_node = of_parse_phandle(np, "cpus", 0);
> +	if (!cpu_node)
> +		return -EINVAL;
> +	cpu_id = of_cpu_node_to_id(cpu_node);
> +	of_node_put(cpu_node);
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temp-high-millicelsius", &temp_high);
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-temp-high-millicelsius property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temp-low-millicelsius", &temp_low);
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-temp-low-millicelsius property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temp-arm-millicelsius", &temp_arm);
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-temp-arm-millicelsius property\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
> +	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
> +	 * of a dt match table.
> +	 */
> +	if (cpu_id == 0) {
> +		node_id = LMH_CLUSTER0_NODE_ID;
> +	} else if (cpu_id == 4) {
> +		node_id = LMH_CLUSTER1_NODE_ID;
> +	} else {
> +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!qcom_scm_lmh_dcvsh_available())
> +		return -EINVAL;
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret)
> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret)
> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret)
> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
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
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
> +				 LMH_NODE_DCVS, node_id, 0);
> +	if (ret) {
> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
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
> +	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
> +	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> +			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
> +			       "lmh-irq", lmh_data);
> +	if (ret) {
> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
> +		irq_domain_remove(lmh_data->domain);
> +		return ret;
> +	}
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
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +module_platform_driver(lmh_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("QCOM LMh driver");
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
