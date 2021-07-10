Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB13C3289
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 06:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhGJER5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 00:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhGJER4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Jul 2021 00:17:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367ABC0613E9
        for <linux-pm@vger.kernel.org>; Fri,  9 Jul 2021 21:15:12 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id w8-20020a0568304108b02904b3da3d49e5so7640541ott.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Jul 2021 21:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdJnFellw0JwGJzUQqtdxXcjdLPRnTbKYVq8UKQA/VQ=;
        b=fIjK+HSnBmwF96e2Xn1aySLWLpT59arRzL3jAK3USvJ9SWvD/P/WJkMSlKRGNbrHcs
         1dTgNbdOv8sxAbmM7+dYhMsTPOdg17drsd2L/bJCYDI3r7suSBN2vrHFwbO2A//kO/hr
         1viz6zwhWJk/0hIcoXiqRSOIdbNrf+LGQ9LhMMOjKbaxXsoSrsPr++FllgR7FH+36JJh
         ZBU8phH5lpQXHf1xNzV6gG/1FB40MUopYh3NAgmbtw5BUebMJ86miEff5fYeGhkZYP+x
         Vxxad37+0JYvyP1OUxUbNycCFb2li8s7lLRP7Tha+7XQmpaV96/CeJ7ePvbB47qrdRw0
         fHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdJnFellw0JwGJzUQqtdxXcjdLPRnTbKYVq8UKQA/VQ=;
        b=mDMZFijWYVo3pqBTrpbhZL95IwV/bsfv73vqd8VY/Aj8vgzwDpRGkrEPZxsDNxeZLt
         JoywS0jDOt/kaojVKpoJF3OuGPC0cBAIVlewLWwN1qLsS8TaLB9AbJCwcZM+/7pmXNdM
         RISQcw/AWo5dypQmJfY7NpS1yVcHO2ecS+Xarimlak5GqOxvd9DYW81QFKMdb8BFzXxf
         pqQ3dkaK8NKcsDxE8b92iq77DNdSs2IYPvGTQZiipq3paulx7vk2Mf8jhcBrycAbqx1I
         /pzdJFaoh31nvi9emDTcEw32DVxj8nFXZu2jGs2YOqSnr7EWetc3aqnZ29ei9Fo14dqF
         0N2A==
X-Gm-Message-State: AOAM533tALAwUNNDp4N3YAFYJxeK7AdOcka2VVGoSqTnKENWOxxF1XCn
        DFqWJLZ7Tq4NufSvWKMs6G3IsQ==
X-Google-Smtp-Source: ABdhPJx5HB8+FRsInBolQfwcH2/94oOVqDA/Nix0gP0S2Wv/zoXNw9rLEKB6evaaVT4SGpaklJwQXw==
X-Received: by 2002:a05:6830:24a6:: with SMTP id v6mr3437178ots.72.1625890511237;
        Fri, 09 Jul 2021 21:15:11 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x15sm244860oog.29.2021.07.09.21.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 21:15:10 -0700 (PDT)
Date:   Fri, 9 Jul 2021 23:15:08 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [Patch v3 2/6] thermal: qcom: Add support for LMh driver
Message-ID: <YOkezJ3gEm6nmQq6@yoga>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-3-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708120656.663851-3-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:

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
>  drivers/thermal/qcom/Kconfig  |  10 ++
>  drivers/thermal/qcom/Makefile |   1 +
>  drivers/thermal/qcom/lmh.c    | 239 ++++++++++++++++++++++++++++++++++
>  3 files changed, 250 insertions(+)
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
> index 000000000000..a7b1eb308642
> --- /dev/null
> +++ b/drivers/thermal/qcom/lmh.c
> @@ -0,0 +1,239 @@
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

cpu_id seems to only be used in lmh_probe(), how about making it a local
variable?

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
> +	struct device *dev;
> +	struct device_node *np;
> +	struct lmh_hw_data *lmh_data;
> +	u32 node_id;
> +	int temp_low, temp_high, temp_arm, ret;
> +
> +	dev = &pdev->dev;
> +	np = dev->of_node;

How about initialize these as you declare you variables?

> +	if (!np)

There's no reasonable way to probe this driver with !dev->of_node, so
you can skip this check.

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
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-cpu-id property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-high", &temp_high);
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-temperature-high property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-low", &temp_low);
> +	if (ret) {
> +		dev_err(dev, "missing qcom,lmh-temperature-low property\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-arm", &temp_arm);
> +	if (ret) {
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

I don't see any get_drvdat(), so you can probably skip this?

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

As written now, you might get interrupts before you get to disable_irq()
below. Instead of the disable_irq() you can add this before request_irq:

	irq_set_status_flags(lmh_dat->irq, IRQ_NOAUTOEN);

> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,

Skip IRQF_TRIGGER_HIGH, as the flags will be merged with the properties
from DT.

> +			       "lmh-irq", lmh_data);
> +	if (ret) {
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

I think you at least need to irq_domain_remove() during .remove, but
unless we have a clear understanding about how to stop the algorithm
(without causing harmful side effects) it might be better to add
.suppress_bind_attrs = true in .driver...

Regards,
Bjorn

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
