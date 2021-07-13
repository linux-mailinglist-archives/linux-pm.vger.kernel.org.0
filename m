Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B473C67A8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jul 2021 02:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhGMAwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jul 2021 20:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbhGMAwh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jul 2021 20:52:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE97C0613EE
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 17:49:47 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a6so19944941qka.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Jul 2021 17:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7KvOHxrkKLDW1HtBK0Hs09MTfu0Tdz0cdfKps6/jMy8=;
        b=KiorCkuWYMbz+kWXmiAYuOAE4k0+EUq2PKMjN3px8fW7phg4cnO3jZ6zjPOGUCROUg
         Dr/QHTTZpU91In3UICiJHd5GzgulKIF5pCqffE/SQ8UBtVx2e60YaHIBoqbJMk3+//c4
         e/KRTUESx+9itPMey3R8i6UOhGK2MluPrKCcjo++PN4zXXiVbj2tz91oQQ2XkTZHlD3G
         JrV93zXNaTDPPq4bKooOXbxTUmmqFpjv3qMWQpku4KXI2ENCPA7ocs9N8i3dSdttE9hm
         bqx7eepgdrzp1qIr3H6koPNKnw0LS6FxXqxMizgDi+KjOg/Q3wzvA4POJQLUnf99h5FY
         G4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7KvOHxrkKLDW1HtBK0Hs09MTfu0Tdz0cdfKps6/jMy8=;
        b=HdVB3AtsAm8N/Kbf7eNrwfzlQgHhm9EDHobY6nVNN4YriqKLhPEfHV10iMZOYb4Ad4
         fCrN/1H+ndA4Vo5CXUAjQiiykXAG5Zj1Kc1cJ66XphI43ZifVMwooNdEizOgceNKa6UC
         Rr5Xc39uLmh3XeN9K0IEQR+gmrhlZQB7YDyGLS6iYrbICqtYsi0WR2bOo0l3jLEu4zDl
         swgzddmwpPiDabnr7hqQfGxWvpEvqvEPX8eGfjYjvCCHif29boU8I3ei3a/vr29cg+7T
         jCThMbObvjjjo5nWKLnZ0Yl9b1nmRRNgW1HA6YqQGt6tecbDBPZ3N36r4U0fZHUkXFv3
         PuPw==
X-Gm-Message-State: AOAM5318kpUhmop45QLVpnXo8YepxCIj1FjgpdUfc9l0bL8D/wPU8X2m
        dgG7IL8FwPduix8sd5nSU8oyrw==
X-Google-Smtp-Source: ABdhPJxpplgsZ/Q6GuRYj27qf+fXYUVjuWXJZu//IePTN29gwgt6eOoeUndKmykMDUvZ2cOu16GR0w==
X-Received: by 2002:a05:620a:14b5:: with SMTP id x21mr1510165qkj.148.1626137386721;
        Mon, 12 Jul 2021 17:49:46 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id j28sm6842139qki.52.2021.07.12.17.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 17:49:46 -0700 (PDT)
Subject: Re: [Patch v3 2/6] thermal: qcom: Add support for LMh driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
 <20210708120656.663851-3-thara.gopinath@linaro.org> <YOkezJ3gEm6nmQq6@yoga>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <3ef6cda9-a5dc-45c4-3e66-8da0f210cf93@linaro.org>
Date:   Mon, 12 Jul 2021 20:49:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOkezJ3gEm6nmQq6@yoga>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

Thanks for the review

On 7/10/21 12:15 AM, Bjorn Andersson wrote:
> On Thu 08 Jul 07:06 CDT 2021, Thara Gopinath wrote:
> 
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
>> v2->v3:
>> 	- Rearranged enabling of various LMh subfunction and removed returning
>> 	  on error in enabling any one subfunction as the different pieces can
>> 	  operate and thus be enabled independently.
>> 	- Other minor cosmetic fixes.
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
>>   drivers/thermal/qcom/Kconfig  |  10 ++
>>   drivers/thermal/qcom/Makefile |   1 +
>>   drivers/thermal/qcom/lmh.c    | 239 ++++++++++++++++++++++++++++++++++
>>   3 files changed, 250 insertions(+)
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
>> index 000000000000..a7b1eb308642
>> --- /dev/null
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -0,0 +1,239 @@
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
> 
> cpu_id seems to only be used in lmh_probe(), how about making it a local
> variable?

yes, it makes sense. I will make it local.

> 
>> +};
>> +
>> +static irqreturn_t lmh_handle_irq(int hw_irq, void *data)
>> +{
>> +	struct lmh_hw_data *lmh_data = data;
>> +	int irq = irq_find_mapping(lmh_data->domain, 0);
>> +
>> +	/* Call the cpufreq driver to handle the interrupt */
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
> 
> How about initialize these as you declare you variables?

ok.

> 
>> +	if (!np)
> 
> There's no reasonable way to probe this driver with !dev->of_node, so
> you can skip this check.

ok.

> 
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
>> +	if (ret) {
>> +		dev_err(dev, "missing qcom,lmh-cpu-id property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-high", &temp_high);
>> +	if (ret) {
>> +		dev_err(dev, "missing qcom,lmh-temperature-high property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-low", &temp_low);
>> +	if (ret) {
>> +		dev_err(dev, "missing qcom,lmh-temperature-low property\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = of_property_read_u32(np, "qcom,lmh-temperature-arm", &temp_arm);
>> +	if (ret) {
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
> 
> I don't see any get_drvdat(), so you can probably skip this?

Yes. I will remove it. I think it is  stray remaining from one of the 
earlier revisions.

> 
>> +
>> +	if (!qcom_scm_lmh_dcvsh_available())
>> +		return -EINVAL;
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret)
>> +		dev_err(dev, "Error %d enabling current subfunction\n", ret);
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret)
>> +		dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret)
>> +		dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_profile_change(0x1);
>> +	if (ret) {
>> +		dev_err(dev, "Error %d changing profile\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Set default thermal trips */
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
>> +				 LMH_NODE_DCVS, node_id, 0);
>> +	if (ret) {
>> +		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	lmh_data->irq = platform_get_irq(pdev, 0);
>> +	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
>> +	if (!lmh_data->domain) {
>> +		dev_err(dev, "Error adding irq_domain\n");
>> +		return -EINVAL;
>> +	}
>> +
> 
> As written now, you might get interrupts before you get to disable_irq()
> below. Instead of the disable_irq() you can add this before request_irq:
> 
> 	irq_set_status_flags(lmh_dat->irq, IRQ_NOAUTOEN);
> 
>> +	ret = devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
>> +			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT | IRQF_NO_SUSPEND,
> 
> Skip IRQF_TRIGGER_HIGH, as the flags will be merged with the properties
> from DT.
> 
>> +			       "lmh-irq", lmh_data);
>> +	if (ret) {
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
> 
> I think you at least need to irq_domain_remove() during .remove, but
> unless we have a clear understanding about how to stop the algorithm
> (without causing harmful side effects) it might be better to add
> .suppress_bind_attrs = true in .driver...

sounds good. Like you said, I am not sure what is the right way to 
disable the algorithm. So I will add suppress_bind_attrs = true to 
prevent user space from doing something silly.

-- 
Warm Regards
Thara (She/Her/Hers)
