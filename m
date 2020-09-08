Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB9C260FBC
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgIHK2I (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 06:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbgIHK2B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 06:28:01 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA2C061756
        for <linux-pm@vger.kernel.org>; Tue,  8 Sep 2020 03:28:00 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d6so3535082pfn.9
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2020 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+gAskG72/avqJ1yxIp8aoIKzGzAKF3CxoapI4iul8TM=;
        b=HnBXwtxLkAIQ18DrlheRotwL+JrpR4ECbj3sLxvP/FCBkGwWe4BZhe+UQk9+TsX2Fd
         9zYO2+VbgCwH0gYHwFeqOAEqCKunkowzYcbg7H2MqzWmJJ+b3NjzawHwbfZZRg6jvjXH
         g0dgmqkjaX7/k3BPJ26MX54ZNLBbfnqZCSlw8xdnyXylBS2hYJOKEOmrOKdTmFv4bqzo
         GcvAMhW4MOZLQSp8+PrcJASXLOM+h36YfbxQbB0baCnond6Uca7mhZO2BoN/V1/oLP4n
         cegFNl/+ioiWtNP1Tr6okwQ90LMZSxo8C6P7vGhIRlwZewIMYv+K8mr0+guSbcpGpNSJ
         AqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+gAskG72/avqJ1yxIp8aoIKzGzAKF3CxoapI4iul8TM=;
        b=XKcUv95zZoS9sjslQ7PxdNXUCsshg9m53VTE+VceMG+EEC/W1VdcjH0r+s3ho7RF09
         SMdf1byCuLn06DaM3G6LKcAxeAXOVhfLcFL/N8HfTVDbuXQf324JXNPmV3w8ekxRixkn
         v8JSsn6wUl30E6Q59hTJvO6MzxHCvCIM5EN6sBMKRFjjMPbkFF8PSgWt/SUP3qn77eox
         wxq+U26wW5oKoJ86qcnW9vRGf7G59uOO2HIuwz3rrjojuDW4Wi70DShqyd9whxXLfq9r
         KN2l9vTCeFoqhpi41QpZO/5sw96+s2a1Llm5GB4glw0WTONxXBuu/DV6KfOW5mSljo1f
         7zCg==
X-Gm-Message-State: AOAM531o66mtndQhJAfQvtfbDpIt11Zbh18fph119pt7b87FI/1zH00Q
        xC9FP61t6nR6bSlxKMFgkmmFCQ==
X-Google-Smtp-Source: ABdhPJxe7b5v4o/jeeYbIMz5EpsffrmanBmr44LfNSgD7ZqL4oG7D2i9bAAqvSOUpPNMFrsnIp4F9Q==
X-Received: by 2002:a17:902:7844:b029:d0:cbe1:e704 with SMTP id e4-20020a1709027844b02900d0cbe1e704mr567397pln.18.1599560878657;
        Tue, 08 Sep 2020 03:27:58 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id l21sm14432485pgb.35.2020.09.08.03.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 03:27:57 -0700 (PDT)
Date:   Tue, 8 Sep 2020 15:57:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v4 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20200908102752.r2n6xvghl4fcdrcv@vireshk-i7>
References: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
 <1599550547-27767-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599550547-27767-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08-09-20, 15:35, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add MT6779 cpufreq HW support.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |   12 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  294 +++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index c6cbfc8..8e58c12 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -121,6 +121,18 @@ config ARM_MEDIATEK_CPUFREQ
>  	help
>  	  This adds the CPUFreq driver support for MediaTek SoCs.
>  
> +config ARM_MEDIATEK_CPUFREQ_HW
> +	tristate "MediaTek CPUFreq HW driver"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	default m
> +	help
> +	  Support for the CPUFreq HW driver.
> +	  Some MediaTek chipsets have a HW engine to offload the steps
> +	  necessary for changing the frequency of the CPUs. Firmware loaded
> +	  in this engine exposes a programming interface to the OS.
> +	  The driver implements the cpufreq interface for this HW engine.
> +	  Say Y if you want to support CPUFreq HW.
> +
>  config ARM_OMAP2PLUS_CPUFREQ
>  	bool "TI OMAP2+"
>  	depends on ARCH_OMAP2PLUS
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index f6670c4..dc1f371 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -57,6 +57,7 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
>  obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
> +obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ_HW)	+= mediatek-cpufreq-hw.o
>  obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> new file mode 100644
> index 0000000..61040b8
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpufreq.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/slab.h>
> +
> +#define LUT_MAX_ENTRIES			32U
> +#define LUT_FREQ			GENMASK(11, 0)
> +#define LUT_ROW_SIZE			0x4
> +
> +enum {
> +	REG_LUT_TABLE,
> +	REG_ENABLE,
> +	REG_PERF_STATE,
> +
> +	REG_ARRAY_SIZE,
> +};
> +
> +struct cpufreq_mtk {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	cpumask_t related_cpus;
> +};
> +
> +static const u16 cpufreq_mtk_offsets[REG_ARRAY_SIZE] = {
> +	[REG_LUT_TABLE]		= 0x0,
> +	[REG_ENABLE]	= 0x84,
> +	[REG_PERF_STATE]	= 0x88,
> +};
> +
> +static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
> +
> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->reg_bases[REG_PERF_STATE]);
> +	arch_set_freq_scale(policy->related_cpus,
> +			    policy->freq_table[index].frequency,
> +			    policy->cpuinfo.max_freq);
> +
> +	return 0;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_mtk *c;
> +	struct cpufreq_policy *policy;
> +	unsigned int index;
> +
> +	policy = cpufreq_cpu_get_raw(cpu);
> +	if (!policy)
> +		return 0;
> +
> +	c = policy->driver_data;
> +
> +	index = readl_relaxed(c->reg_bases[REG_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *cpu_dev;
> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("%s: failed to get cpu%d device\n", __func__,
> +		       policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +	if (!c) {
> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	cpumask_copy(policy->cpus, &c->related_cpus);
> +
> +	policy->freq_table = c->table;
> +	policy->driver_data = c;
> +
> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, c->reg_bases[REG_ENABLE]);
> +
> +	return 0;
> +}
> +
> +static struct freq_attr *mtk_cpufreq_hw_attr[] = {
> +	&cpufreq_freq_attr_scaling_available_freqs,
> +	NULL
> +};
> +
> +static struct cpufreq_driver cpufreq_mtk_hw_driver = {
> +	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +	.verify		= cpufreq_generic_frequency_table_verify,
> +	.target_index	= mtk_cpufreq_hw_target_index,
> +	.get		= mtk_cpufreq_hw_get,
> +	.init		= mtk_cpufreq_hw_cpu_init,
> +	.name		= "mtk-cpufreq-hw",
> +	.attr		= mtk_cpufreq_hw_attr,

You can use cpufreq_generic_attr instead.

> +};
> +
> +static int mtk_cpufreq_hw_opp_create(struct platform_device *pdev,
> +				     struct cpufreq_mtk *c)
> +{
> +	struct device *dev = &pdev->dev;
> +	void __iomem *base_table;
> +	u32 data, i, freq, prev_freq = 0;
> +
> +	c->table = devm_kcalloc(dev, LUT_MAX_ENTRIES + 1,
> +				sizeof(*c->table), GFP_KERNEL);
> +	if (!c->table)
> +		return -ENOMEM;
> +
> +	base_table = c->reg_bases[REG_LUT_TABLE];
> +
> +	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
> +		data = readl_relaxed(base_table + (i * LUT_ROW_SIZE));
> +		freq = FIELD_GET(LUT_FREQ, data) * 1000;
> +
> +		if (freq == prev_freq)
> +			break;
> +
> +		c->table[i].frequency = freq;
> +
> +		dev_dbg(dev, "index=%d freq=%d\n",
> +			i, c->table[i].frequency);
> +
> +		prev_freq = freq;
> +	}
> +
> +	c->table[i].frequency = CPUFREQ_TABLE_END;
> +
> +	return 0;
> +}
> +
> +static int mtk_get_related_cpus(int index, struct cpumask *m)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	int cpu, ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np)
> +			continue;
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "mtk-freq-domain",
> +						 "#freq-domain-cells", 0,
> +						 &args);
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0])
> +			cpumask_set_cpu(cpu, m);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  unsigned int cpu, int index)
> +{
> +	struct cpufreq_mtk *c;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	const u16 *offsets;
> +	int ret, i, cpu_r;
> +	void __iomem *base;
> +
> +	if (mtk_freq_domain_map[cpu])
> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;

Just do this once in probe and pass it to this routine. You don't need
to do this again and again.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = REG_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	ret = mtk_get_related_cpus(index, &c->related_cpus);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		return ret;
> +	}
> +
> +	ret = mtk_cpufreq_hw_opp_create(pdev, c);

This isn't creating an OPP table anymore but just a frequency table.
Name it mtk_cpu_create_freq_table() rather.

> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to create OPP\n", index);
> +		return ret;
> +	}
> +
> +	for_each_cpu(cpu_r, &c->related_cpus)
> +		mtk_freq_domain_map[cpu_r] = c;
> +
> +	return 0;
> +}
> +
> +static int mtk_resources_init(struct platform_device *pdev)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	unsigned int cpu;
> +	int ret;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_dbg(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			continue;
> +		}
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "mtk-freq-domain",
> +						 "#freq-domain-cells", 0, &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = mtk_cpu_resources_init(pdev, cpu, args.args[0]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	/* Get the bases of cpufreq for domains */
> +	ret = mtk_resources_init(pdev);

Just open-code this here. No need of a separate routine really, there
is not much there.

> +	if (ret) {
> +		dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +		return ret;
> +	}
> +
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&pdev->dev, "Mediatek CPUFreq HW driver initialized\n");

Just drop this, this isn't really required. The cpufreq core also
print some messages for this.

> +	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);

Why do you need to do this ? This should happen automatically.

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_cpufreq_hw_match[] = {
> +	{ .compatible = "mediatek,cpufreq-hw", .data = &cpufreq_mtk_offsets },
> +	{}
> +};
> +
> +static struct platform_driver mtk_cpufreq_hw_driver = {
> +	.probe = mtk_cpufreq_hw_driver_probe,
> +	.driver = {
> +		.name = "mtk-cpufreq-hw",
> +		.of_match_table = mtk_cpufreq_hw_match,
> +	},
> +};
> +
> +static int __init mtk_cpufreq_hw_init(void)
> +{
> +	return platform_driver_register(&mtk_cpufreq_hw_driver);
> +}
> +subsys_initcall(mtk_cpufreq_hw_init);

subsys_init ? Why this ?

You made your driver as a "tristate" driver, and you don't have any
exit/remove level stuff ?

> +
> +MODULE_DESCRIPTION("mtk CPUFREQ HW Driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
