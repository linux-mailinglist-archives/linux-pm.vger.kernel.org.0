Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DE13FC179
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 05:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbhHaDUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 23:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhHaDUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 23:20:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0073AC06175F
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 20:19:49 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id w8so15394232pgf.5
        for <linux-pm@vger.kernel.org>; Mon, 30 Aug 2021 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDydgTokqvJ4roSWTBBp2PotVgcvd3iwL5pDfvyIG6w=;
        b=WoS7DHQte7tzWg+3vSC5m7nPx16ixnvg60Op6gY43JsJD5qk9EOHinTa6UNsaj7PUO
         R8bMt5zLoGRaerHN3mj1yVU26Edo+m/j5az00ts5L/x+OyWP7fGT9q/zyp7DBpY8c8wi
         cNIu4KWh/xfjGr4fimCzdcT0SeKvf6IIeTumftjjjH112fhTUuxjBwotAD+pF7KAY+5v
         lhKK6yEk7ZJFYyS0/wCJ/IrsTCN1n500gcIV2UiXalLJRhxNQqghMMCPYuWPcRDdWBWX
         2Q4FRRSA3+O6AYdfLv6GzDJu5vDXCxg/YDst6dRXX4JzK1Fwc+pIn2byhOL7ow2ESp1A
         f4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDydgTokqvJ4roSWTBBp2PotVgcvd3iwL5pDfvyIG6w=;
        b=LmScWnjkXVJuWSn2uLd2ZcR0L0gMLD1NHHfRILJXyVXW1WvzyDCpE3Ww3aXyAWNRRr
         8uifG0WugXMEANy65AGNHjgmY7eX1PGO+l0GLOzgbKBf9f/2O+e2wM9E8zJZGac1msfL
         YAotSE5xDbfF0oJu8wWkVKYnptcCF9hraj3YypxSgeVdGw3QkJi9TAQED/h48Br0R08W
         oX8tge5DJqczxMivG50HrG6ZK41Imsb7LwJB6L4rsVefM0ESrJFDz0nMsP/poXdyzlz+
         gXLRkh0k85AXXTPVHxcm6zRX7qIyN/qY6/0N3Tanmna2M9z7HAb+3jpDhzguX9ZEJoGP
         xf3w==
X-Gm-Message-State: AOAM531BWHYyvOilVf/Gfq8E+LbQ3iH4oKqHecXRI3YhAo9LP2Ce5VXW
        NL49bIlNqovbIl4xFHbjnTWGxg==
X-Google-Smtp-Source: ABdhPJwB8h/QFEYnOApFti5l2OyEVxW9lJyigx/ORnmv2g9RHQ+XHCn1QbH6Nb0eQpVUTwoGId/JHg==
X-Received: by 2002:a62:17c3:0:b0:3f5:b942:119e with SMTP id 186-20020a6217c3000000b003f5b942119emr18694258pfx.53.1630379989139;
        Mon, 30 Aug 2021 20:19:49 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id lw14sm786729pjb.48.2021.08.30.20.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 20:19:46 -0700 (PDT)
Date:   Tue, 31 Aug 2021 08:49:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v14 3/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210831031944.emtd2hlpzjs3cxnl@vireshk-i7>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
 <1630162872-25452-4-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630162872-25452-4-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28-08-21, 23:01, Hector Yuan wrote:
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> new file mode 100644
> index 0000000..79862a5
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/energy_model.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_qos.h>

You still need this ? Please check all the headers and keep only the ones that
are required.

> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			32U
> +#define LUT_FREQ			GENMASK(11, 0)
> +#define LUT_ROW_SIZE			0x4
> +#define CPUFREQ_HW_STATUS		BIT(0)
> +#define SVS_HW_STATUS			BIT(1)
> +#define POLL_USEC			1000
> +#define TIMEOUT_USEC			300000
> +
> +enum {
> +	REG_FREQ_LUT_TABLE,
> +	REG_FREQ_ENABLE,
> +	REG_FREQ_PERF_STATE,
> +	REG_FREQ_HW_STATE,
> +	REG_EM_POWER_TBL,
> +	REG_FREQ_LATENCY,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct mtk_cpufreq_data {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	int nr_opp;
> +};
> +
> +static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
> +	[REG_FREQ_LUT_TABLE]	= 0x0,
> +	[REG_FREQ_ENABLE]	= 0x84,
> +	[REG_FREQ_PERF_STATE]	= 0x88,
> +	[REG_FREQ_HW_STATE]	= 0x8c,
> +	[REG_EM_POWER_TBL]	= 0x90,
> +	[REG_FREQ_LATENCY]	= 0x110,
> +};
> +
> +static int __maybe_unused
> +mtk_cpufreq_get_cpu_power(unsigned long *mW,
> +			  unsigned long *KHz, struct device *cpu_dev)
> +{
> +	struct mtk_cpufreq_data *data;
> +	struct cpufreq_policy *policy;
> +	int i;
> +
> +	policy = cpufreq_cpu_get_raw(cpu_dev->id);
> +	if (!policy)
> +		return 0;
> +
> +	data = policy->driver_data;
> +
> +	for (i = 0; i < data->nr_opp; i++) {
> +		if (data->table[i].frequency < *KHz)
> +			break;
> +	}
> +	i--;
> +
> +	*KHz = data->table[i].frequency;
> +	*mW = readl_relaxed(data->reg_bases[REG_EM_POWER_TBL] +
> +			    i * LUT_ROW_SIZE) / 1000;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct mtk_cpufreq_data *data = policy->driver_data;
> +
> +	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
> +
> +	return 0;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct mtk_cpufreq_data *data;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	data = policy->driver_data;
> +
> +	index = readl_relaxed(data->reg_bases[REG_FREQ_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return data->table[index].frequency;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +					       unsigned int target_freq)
> +{
> +	struct mtk_cpufreq_data *data = policy->driver_data;
> +	unsigned int index;
> +
> +	index = cpufreq_table_find_index_dl(policy, target_freq);
> +
> +	writel_relaxed(index, data->reg_bases[REG_FREQ_PERF_STATE]);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int mtk_cpu_create_freq_table(struct platform_device *pdev,
> +				     struct mtk_cpufreq_data *data)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base_table;
> +	u32 temp, i, freq, prev_freq = 0;
> +
> +	data->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				   sizeof(*data->table), GFP_KERNEL);
> +	if (!data->table)
> +		return -ENOMEM;
> +
> +	base_table = data->reg_bases[REG_FREQ_LUT_TABLE];
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		temp = readl_relaxed(base_table + (i * LUT_ROW_SIZE));
> +		freq = FIELD_GET(LUT_FREQ, temp) * 1000;
> +
> +		if (freq == prev_freq)
> +			break;
> +
> +		data->table[i].frequency = freq;
> +
> +		dev_dbg(dev, "index=%d freq=%d\n", i, data->table[i].frequency);
> +
> +		prev_freq = freq;
> +	}
> +
> +	data->table[i].frequency = CPUFREQ_TABLE_END;
> +	data->nr_opp = i;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  struct cpufreq_policy *policy,
> +				  const u16 *offsets)
> +{
> +	struct mtk_cpufreq_data *data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base;
> +	int ret, i;
> +	int index;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	index = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
> +						   "#performance-domain-cells",
> +						   policy->cpus);

No need to check failure here ?

> +
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> +		data->reg_bases[i] = base + offsets[i];
> +
> +	ret = mtk_cpu_create_freq_table(pdev, data);
> +	if (ret) {
> +		dev_info(dev, "Domain-%d failed to create freq table\n", index);
> +		return ret;
> +	}
> +
> +	policy->freq_table = data->table;
> +	policy->driver_data = data;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
> +	struct platform_device *pdev = cpufreq_get_driver_data();
> +	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
> +	struct mtk_cpufreq_data *data;
> +	struct device *cpu_dev;
> +	unsigned int latency;
> +	const u16 *offsets;
> +	int ret;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;

Do this in probe just once instead of for each policy ?

> +
> +	/* Get the bases of cpufreq for domains */
> +	ret = mtk_cpu_resources_init(pdev, policy, offsets);
> +	if (ret) {
> +		dev_info(&pdev->dev, "CPUFreq resource init failed\n");
> +		return ret;
> +	}
> +
> +	data = policy->driver_data;
> +
> +	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
> +	if (!latency)
> +		latency = CPUFREQ_ETERNAL;
> +
> +	/* us convert to ns */
> +	policy->cpuinfo.transition_latency = latency;
> +
> +	policy->fast_switch_possible = true;
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, data->reg_bases[REG_FREQ_ENABLE]);
> +	if (readl_poll_timeout(data->reg_bases[REG_FREQ_HW_STATE], sig,
> +			       (sig & pwr_hw) == pwr_hw, POLL_USEC,
> +			       TIMEOUT_USEC)) {
> +		if (!(sig & CPUFREQ_HW_STATUS)) {
> +			pr_info("cpufreq hardware of CPU%d is not enabled\n",
> +				policy->cpu);
> +			return -ENODEV;
> +		}
> +
> +		pr_info("SVS of CPU%d is not enabled\n", policy->cpu);
> +	}
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_info("failed to get cpu%d device\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	em_dev_register_perf_domain(cpu_dev, data->nr_opp, &em_cb, policy->cpus,
> +				    true);

This needs to change based on the stuff present in my cpufreq/arm/linux-next [1]
branch. Here is the modification for a similar driver.

https://lore.kernel.org/linux-pm/8158488baa1ea1aebd09c8d256db7420051d05ac.1628742634.git.viresh.kumar@linaro.org/

> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct mtk_cpufreq_data *data = policy->driver_data;
> +	void __iomem *base;
> +	int i;
> +
> +	/* HW should be in paused state now */
> +	writel_relaxed(0x0, data->reg_bases[REG_FREQ_ENABLE]);
> +
> +	for (i = 0; i < REG_ARRAY_SIZE; i++) {
> +		base = data->reg_bases[i];
> +		iounmap(base);
> +	}
> +
> +	kfree(data->table);
> +	kfree(data);

base, data and table are all allocated using devm_* variants. AFAIK, it is
wrong to free them this way as the devm core will try to do the same again
later. Try building your driver as module and insert remove it to see warnings.

Why do you need to free stuff here anyway if it is devm already ?

> +
> +	return 0;
> +}
> +
> +static struct cpufreq_driver cpufreq_mtk_hw_driver = {
> +	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_IS_COOLING_DEV,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= mtk_cpufreq_hw_target_index,
> +	.get		= mtk_cpufreq_hw_get,
> +	.init		= mtk_cpufreq_hw_cpu_init,
> +	.exit		= mtk_cpufreq_hw_cpu_exit,
> +	.fast_switch	= mtk_cpufreq_hw_fast_switch,
> +	.name		= "mtk-cpufreq-hw",
> +	.attr		= cpufreq_generic_attr,
> +};
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	cpufreq_mtk_hw_driver.driver_data = pdev;
> +
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret)
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +
> +	return ret;
> +}
> +
> +static int mtk_cpufreq_hw_driver_remove(struct platform_device *pdev)
> +{
> +	return cpufreq_unregister_driver(&cpufreq_mtk_hw_driver);
> +}
> +
> +static const struct of_device_id mtk_cpufreq_hw_match[] = {
> +	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
> +	{}
> +};
> +
> +static struct platform_driver mtk_cpufreq_hw_driver = {
> +	.probe = mtk_cpufreq_hw_driver_probe,
> +	.remove = mtk_cpufreq_hw_driver_remove,
> +	.driver = {
> +		.name = "mtk-cpufreq-hw",
> +		.of_match_table = mtk_cpufreq_hw_match,
> +	},
> +};
> +module_platform_driver(mtk_cpufreq_hw_driver);
> +
> +MODULE_AUTHOR("Hector Yuan <hector.yuan@mediatek.com>");
> +MODULE_DESCRIPTION("Mediatek cpufreq-hw driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh

[1] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
