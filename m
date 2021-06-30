Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFCC3B7BFA
	for <lists+linux-pm@lfdr.de>; Wed, 30 Jun 2021 05:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhF3DJN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Jun 2021 23:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbhF3DJJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Jun 2021 23:09:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75718C061767
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 20:06:41 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g14so372420qvo.7
        for <linux-pm@vger.kernel.org>; Tue, 29 Jun 2021 20:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tuE8eI7xPTlGquO8tV6/emNqMWz8aUAeCyFHK4ouE8w=;
        b=rkx6mIALp3jHyBBoZq9SF2ZgonpO4rhnFzj9Oq6AC4XtyWLiqwYSc8sv+RT5knSE0P
         151zlKh5N46Dw1MqHLsr0f4SO444Tff6af4OnO+MCdxStmhZ2rH7dHe3OTegkKABalFw
         NV/K7VXXowGF0d3lfAX2TFlKNizE3lW4y7PdJ8tWVfeSsntEBHsWOLOvtGQx1gIfJ7EK
         azMNUMD7fVRF5nv0U6w/xzsVnWkNwipsisEIRtDe/5+H+uhQbvZNlL1D0SUDDusTdZFC
         ZrTFBztXi+0XCthidA2PFl7XrafhokVsipe0Q9axAQWYlnDEsHfF6yjP2kFKztbWY5y6
         fstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tuE8eI7xPTlGquO8tV6/emNqMWz8aUAeCyFHK4ouE8w=;
        b=nDHW60qpqPLGbsXKSqglxImHCgYCJbp9wEU3rjP/n7CeINVcblaIwi0ArFWvDZOHrq
         ZPy3/4zmDaV405QpC3wb7eNgcOX0SCEQrmJaZsB3/IEp2HRZt/vMdbuR/CthwPNsTkiu
         +79m8YG7xC8JFUGvjGhhxYpOCRRmYI9ijURbV5vWdmmVInQWA0z3mOIQri2JMK2+FWz8
         8asqcyVPt4tfaLcxvIrudOAvBwesW/520o8OSjGOUMnSELwU9JJy8zRj9suP5ex1SONM
         MCfx92aN34SROakhp0nznPiLeQvLsTXFpfNx0hQGKnbv9aoJo+dKNFxihvpmQfLyY8hk
         +PPA==
X-Gm-Message-State: AOAM532o72UVN/C6n+twf2CFkLoJusISsY6lwf7xZAPqr6FOQrXKnRMy
        5CTPDfSOggSzQPcb5JYNNHDldQ==
X-Google-Smtp-Source: ABdhPJyDCRXOjCYyn/2rVN7uOciWk2PCelVjfocRnOsyglTjcyUENpaO8rZf0vRJ4dI4WQTokC0Mbw==
X-Received: by 2002:a0c:80ec:: with SMTP id 99mr33958780qvb.55.1625022399521;
        Tue, 29 Jun 2021 20:06:39 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id u66sm5951765qkc.89.2021.06.29.20.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 20:06:38 -0700 (PDT)
Subject: Re: [Patch v2 2/5] thermal: qcom: Add support for LMh driver
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210624115813.3613290-1-thara.gopinath@linaro.org>
 <20210624115813.3613290-3-thara.gopinath@linaro.org>
 <YNS/x8Po4kGILcOC@google.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <35b5e5f3-90d8-1126-0830-3ff40d081d1c@linaro.org>
Date:   Tue, 29 Jun 2021 23:06:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YNS/x8Po4kGILcOC@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 6/24/21 1:24 PM, Matthias Kaehlcke wrote:
> On Thu, Jun 24, 2021 at 07:58:10AM -0400, Thara Gopinath wrote:
>> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
>> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
>> current, battery current violations, enabling reliability algorithm and
>> setting up various temperature limits.
>>
>> The following has been explained in the cover letter. I am including this
>> here so that this remains in the commit message as well.
>>
>> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
>> temperature and current limits as programmed by software for certain IPs
>> like CPU. On many newer LMh is configured by firmware/TZ and no programming
>> is needed from the kernel side. But on certain SoCs like sdm845 the
>> firmware does not do a complete programming of the h/w. On such soc's
>> kernel software has to explicitly set up the temperature limits and turn on
>> various monitoring and enforcing algorithms on the hardware.
>>
>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>> ---
>>
>> v1->v2:
>> 	- Cosmetic and spelling fixes from review comments from Randy Dunlap
>> 	- Added irq_disable to lmh_irq_ops and removed disabling of irq from
>> 	  lmh_handle_irq. Now cpufreq explicitly disables irq prior to
>> 	  handling it as per Bjorn's suggestion.
>> 	- Rebased to new version of qcom_scm_lmh_dcvsh as changed in patch 1.
>> 	- Removed generic dt compatible string and introduced platform specific one
>> 	  as per Bjorn's suggestion.
>> 	- Take arm, low and high temp thresholds for LMh from dt properties instead of
>> 	  #defines in the driver as per Daniel's suggestion.
>> 	- Other minor fixes.
>>
>>   drivers/thermal/qcom/Kconfig  |  10 ++
>>   drivers/thermal/qcom/Makefile |   1 +
>>   drivers/thermal/qcom/lmh.c    | 251 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 262 insertions(+)
>>   create mode 100644 drivers/thermal/qcom/lmh.c
>>
>> diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
>> index 8d5ac2df26dc..7d942f71e532 100644
>> --- a/drivers/thermal/qcom/Kconfig
>> +++ b/drivers/thermal/qcom/Kconfig
>> @@ -31,3 +31,13 @@ config QCOM_SPMI_TEMP_ALARM
>>   	  trip points. The temperature reported by the thermal sensor reflects the
>>   	  real time die temperature if an ADC is present or an estimate of the
>>   	  temperature based upon the over temperature stage value.
>> +
>> +config QCOM_LMH
>> +	tristate "Qualcomm Limits Management Hardware"
>> +	depends on ARCH_QCOM
>> +	help
>> +	  This enables initialization of Qualcomm limits management
>> +	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
>> +	  input from temperature and current sensors.  On many newer Qualcomm SoCs
>> +	  LMh is configured in the firmware and this feature need not be enabled.
>> +	  However, on certain SoCs like sdm845 LMh has to be configured from kernel.
>> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
>> index 252ea7d9da0b..0fa2512042e7 100644
>> --- a/drivers/thermal/qcom/Makefile
>> +++ b/drivers/thermal/qcom/Makefile
>> @@ -5,3 +5,4 @@ qcom_tsens-y			+= tsens.o tsens-v2.o tsens-v1.o tsens-v0_1.o \
>>   				   tsens-8960.o
>>   obj-$(CONFIG_QCOM_SPMI_ADC_TM5)	+= qcom-spmi-adc-tm5.o
>>   obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
>> +obj-$(CONFIG_QCOM_LMH)		+= lmh.o
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> new file mode 100644
>> index 000000000000..a14cad83b459
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -0,0 +1,251 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright (C) 2021, Linaro Limited. All rights reserved.
>> + */
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/err.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/slab.h>
>> +#include <linux/qcom_scm.h>
>> +
>> +#define LMH_NODE_DCVS			0x44435653
>> +#define LMH_CLUSTER0_NODE_ID		0x6370302D
>> +#define LMH_CLUSTER1_NODE_ID		0x6370312D
>> +
>> +#define LMH_SUB_FN_THERMAL		0x54484D4C
>> +#define LMH_SUB_FN_CRNT			0x43524E54
>> +#define LMH_SUB_FN_REL			0x52454C00
>> +#define LMH_SUB_FN_BCL			0x42434C00
>> +
>> +#define LMH_ALGO_MODE_ENABLE		0x454E424C
>> +#define LMH_TH_HI_THRESHOLD		0x48494748
>> +#define LMH_TH_LOW_THRESHOLD		0x4C4F5700
>> +#define LMH_TH_ARM_THRESHOLD		0x41524D00
>> +
>> +#define LMH_REG_DCVS_INTR_CLR		0x8
>> +
>> +struct lmh_hw_data {
>> +	void __iomem *base;
>> +	struct irq_domain *domain;
>> +	int irq;
>> +	u32 cpu_id;
>> +};
>> +
>> +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
>> +{
>> +	struct lmh_hw_data *lmh_data = data;
>> +	int irq = irq_find_mapping(lmh_data->domain, 0);
>> +
>> +	/*
>> +	 * Call the cpufreq driver to handle the interrupt.
>> +	 */
> 
> no need for a multiline comment

ok..

> 
>> +	if (irq)
>> +		generic_handle_irq(irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static void lmh_enable_interrupt(struct irq_data *d)
>> +{
>> +	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
>> +
>> +	/* Clear the existing interrupt */
>> +	writel(0xff, lmh_data->base + LMH_REG_DCVS_INTR_CLR);
>> +	enable_irq(lmh_data->irq);
>> +}
>> +
>> +static void lmh_disable_interrupt(struct irq_data *d)
>> +{
>> +	struct lmh_hw_data *lmh_data = irq_data_get_irq_chip_data(d);
>> +
>> +	disable_irq_nosync(lmh_data->irq);
>> +}
>> +
>> +static struct irq_chip lmh_irq_chip = {
>> +	.name           = "lmh",
>> +	.irq_enable	= lmh_enable_interrupt,
>> +	.irq_disable	= lmh_disable_interrupt
>> +};
>> +
>> +static int lmh_irq_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
>> +{
>> +	struct lmh_hw_data *lmh_data = d->host_data;
>> +
>> +	irq_set_chip_and_handler(irq, &lmh_irq_chip, handle_simple_irq);
>> +	irq_set_chip_data(irq, lmh_data);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct irq_domain_ops lmh_irq_ops = {
>> +	.map = lmh_irq_map,
>> +	.xlate = irq_domain_xlate_onecell,
>> +};
>> +
>> +static int lmh_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev;
>> +	struct device_node *np;
>> +	struct lmh_hw_data *lmh_data;
>> +	u32 node_id;
>> +	int temp_low, temp_high, temp_arm, ret;
>> +
>> +	dev = &pdev->dev;
>> +	np = dev->of_node;
>> +	if (!np)
>> +		return -EINVAL;
>> +
>> +	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
>> +	if (!lmh_data)
>> +		return -ENOMEM;
>> +
>> +	lmh_data->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(lmh_data->base))
>> +		return PTR_ERR(lmh_data->base);
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-cpu-id", &lmh_data->cpu_id);
> 
> binding missing?

ya. I am waiting for feeback on the bindings before documenting them. I 
was not exactly sure how this driver will look like after reviews. But 
once it is more or less reviewed, I will add the patch documenting the 
bindings. Same for all the below bindings.

> 
>> +	if (ret) {
>> +		dev_err(dev, "missing qcom,lmh-cpu-id property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-high", &temp_high);
>> +	if (ret) {
> 
> ditto
> 
>> +		dev_err(dev, "missing qcom,lmh-temperature-high property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-low", &temp_low);
>> +	if (ret) {
> 
> ditto
> 
>> +		dev_err(dev, "missing qcom,lmh-temperature-low property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-arm", &temp_arm);
>> +	if (ret) {
> 
> ditto
> 
>> +		dev_err(dev, "missing qcom,lmh-temperature-arm property\n");
>> +		return ret;
>> +	}
>> +
>> +	/*
>> +	 * Only sdm845 has lmh hardware currently enabled from hlos. If this is needed
>> +	 * for other platforms, revisit this to check if the <cpu-id, node-id> should be part
>> +	 * of a dt match table.
>> +	 */
>> +	if (lmh_data->cpu_id == 0) {
>> +		node_id = LMH_CLUSTER0_NODE_ID;
>> +	} else if (lmh_data->cpu_id == 4) {
>> +		node_id = LMH_CLUSTER1_NODE_ID;
>> +	} else {
>> +		dev_err(dev, "Wrong CPU id associated with LMh node\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, lmh_data);
>> +
>> +	if (!qcom_scm_lmh_dcvsh_available())
>> +		return -EINVAL;
>> +
>> +	/* Enable Thermal Algorithm */
> 
> nit: thermal algorithm

sure.

> 
> Same for other comments below.
> 
> Actually I think you can delete the comments, the error log a few lines below
> provides the same information.
> 
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable Current Sensing Algorithm */
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable Reliability Algorithm */
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
> 
> disable thermal subfunction??

So, my main reference to this h/w is downstream code which does no 
disabling of any sorts.. I do have some documentation but not complete. 
My understanding is that each of these pieces(current, reliability etc) 
are separate entities that provide an input to LMh h/w in deciding 
whether to throttle and how much to throttle. Now that you brought this 
up, I am thinking maybe I should remove returning on error all-together.
Instead allow for separate pieces to be enabled even if one piece 
returns an error. I will have to move thermal all the way to the bottom 
because there is no point is setting the trips if thermal algorithm is 
not enabled. If this does not work, I will keep this as is because I see 
no disable code for this downstream.

> 
>> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Enable BCL Algorithm */
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
> 
> disable previously enabled stuff?
> 
>> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_profile_change(0x1);
> 
> Does profile 1 represent something specific, i.e. should this be a constant?
> If not, why a hex instead of a decimal value?

Again zero documentation and just the downstream code for reference. So 
it is hex in the downstream code. I am going to make this a constant.

> 
>> +	if (ret) {
> 
> disable previously enabled stuff?
> 
>> +		dev_err(dev, "Error %d changing profile\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set default thermal trips */
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
> 
> undo stuff?
> 
>> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
> 
> undo stuff?
> 
>> +		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
> 
> undo stuff?
> 
>> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	lmh_data->irq = platform_get_irq(pdev, 0);
>> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
>> +	if (!lmh_data->domain) {
> 
> undo stuff?

Even without irq support, lest of LMh can function. So there is no undo 
needed here.

-- 
Warm Regards
Thara (She/Her/Hers)

> 
>> +		dev_err(dev, "Error adding irq_domain\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
>> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
>> +			       "lmh-irq", lmh_data);
>> +	if (ret) {
> 
> undo stuff?
> 
>> +		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
>> +		irq_domain_remove(lmh_data->domain);
>> +		return ret;
>> +	}
>> +
>> +	/* Disable the irq and let cpufreq enable it when ready to handle the interrupt */
>> +	disable_irq(lmh_data->irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id lmh_table[] = {
>> +	{ .compatible = "qcom,sdm845-lmh", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, lmh_table);
>> +
>> +static struct platform_driver lmh_driver = {
>> +	.probe = lmh_probe,
>> +	.driver = {
>> +		.name = "qcom-lmh",
>> +		.of_match_table = lmh_table,
>> +	},
>> +};
>> +module_platform_driver(lmh_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("QCOM LMh driver");
>> -- 
>> 2.25.1
>>

