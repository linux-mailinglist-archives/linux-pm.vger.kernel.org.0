Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3613A615B
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233881AbhFNKqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 06:46:21 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:45601 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbhFNKoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 06:44:17 -0400
Received: by mail-pj1-f53.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso9879685pjb.4
        for <linux-pm@vger.kernel.org>; Mon, 14 Jun 2021 03:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F/FnxgJJ6X5Hj5mB3BJ7rGeDb6GnuuIHVH7+4AjxYJk=;
        b=m3idL5ZgVLOu20VdRqMiAFMu7jQPmzfaGpRcaiM2RjhF8jWU/6zwpa4tCeFd5XgR1h
         UL0LG5wuzHZCSKk/mmZ14mxgdugQJuRTf7z7ZqoZNDUrzpqMykpy8c6cv64+q1SWXFWj
         OVTzeBtu5D2q1rXu4GvXwBH6OnbEPC5iRHVPvj5PVyJ3aj0xOefiInpckvamjFyLpQcN
         De5mfB5WZ1XmoM0PWGcI/b6KLcSkHxVh/k6XRR7xBhjgFE4YmNRfqwKR8ceFp89RMmgb
         CPf/jjofQ70KyGxPdbdo78XYWfZac1tvaRxmVaWm1xp51sdszkjCcur9g7bjUXwnQ8P3
         dyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F/FnxgJJ6X5Hj5mB3BJ7rGeDb6GnuuIHVH7+4AjxYJk=;
        b=d+YD8gxjt7XS1Jl8savItKCblhE0Z3gu2/2D5wYeyk3vZjidjziBJIxK792c2vgcv2
         9+Mw6DDuBC4d8x1ohNP5LItCfRm/G97XEvOrKsxnz7iG2zfjOemiitgsOR+FXl2PZtzW
         NUd1DVZ8/l0hjtc7X1ggq1tu3DvOgHG2v+m69W2ZTApeW+IlebQW+ybwloJ7eWqSOefI
         kwTg38KQgSawIArpdhcAqVjCrDMdRRZP+Z5hLmVHf2ALM+cTQ/ZnBXkXOMIRAB6gDxU9
         jlH5tGTot5dWhoo8v2Nnzr5SXJow0LOROTXchMeijhTbHwiDqepenUd1Vsg8uoVoXrEH
         Xziw==
X-Gm-Message-State: AOAM532J/vQdRdPr/ak/qyXixv4c9eZGicZ+cy7mVKUNU/EpMP6oOFig
        Ivxf5jXmwiHd0TKobEdi1ewQlw==
X-Google-Smtp-Source: ABdhPJx4RboqA6Ju92QG96Oq4Z5F9clsG/Whm+mnpf+mN81Ep2hsn7iBsxSDtcgSZ8XDPsgJ4LXlQA==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr18745289pju.144.1623667260404;
        Mon, 14 Jun 2021 03:41:00 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id z3sm5594896pfb.127.2021.06.14.03.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 03:40:59 -0700 (PDT)
Date:   Mon, 14 Jun 2021 16:10:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30-05-21, 00:52, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add cpufreq HW support.
> 
> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  drivers/cpufreq/Kconfig.arm           |   12 ++
>  drivers/cpufreq/Makefile              |    1 +
>  drivers/cpufreq/mediatek-cpufreq-hw.c |  370 +++++++++++++++++++++++++++++++++
>  3 files changed, 383 insertions(+)
>  create mode 100644 drivers/cpufreq/mediatek-cpufreq-hw.c
> 
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index a5c5f70..954749a 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -133,6 +133,18 @@ config ARM_MEDIATEK_CPUFREQ
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
> index 27d3bd7..48ee585 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>  obj-$(CONFIG_ARM_IMX_CPUFREQ_DT)	+= imx-cpufreq-dt.o
>  obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
>  obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mediatek-cpufreq.o
> +obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ_HW)	+= mediatek-cpufreq-hw.o
>  obj-$(CONFIG_MACH_MVEBU_V7)		+= mvebu-cpufreq.o
>  obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>  obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
> diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
> new file mode 100644
> index 0000000..6f3a461
> --- /dev/null
> +++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
> @@ -0,0 +1,370 @@
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
> +struct cpufreq_mtk {
> +	struct cpufreq_frequency_table *table;
> +	void __iomem *reg_bases[REG_ARRAY_SIZE];
> +	int nr_opp;
> +	cpumask_t related_cpus;
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
> +static struct cpufreq_mtk *mtk_freq_domain_map[NR_CPUS];
> +
> +static int __maybe_unused
> +mtk_cpufreq_get_cpu_power(unsigned long *mW,
> +			  unsigned long *KHz, struct device *cpu_dev)
> +{
> +	struct cpufreq_mtk *c = mtk_freq_domain_map[cpu_dev->id];
> +	int i;
> +
> +	for (i = 0; i < c->nr_opp; i++) {
> +		if (c->table[i].frequency < *KHz)
> +			break;
> +	}
> +	i--;
> +
> +	*KHz = c->table[i].frequency;
> +	*mW = readl_relaxed(c->reg_bases[REG_EM_POWER_TBL] +
> +			    i * LUT_ROW_SIZE) / 1000;
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_target_index(struct cpufreq_policy *policy,
> +				       unsigned int index)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +
> +	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
> +
> +	return 0;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_get(unsigned int cpu)
> +{
> +	struct cpufreq_mtk *c;
> +	unsigned int index;
> +
> +	c = mtk_freq_domain_map[cpu];
> +
> +	index = readl_relaxed(c->reg_bases[REG_FREQ_PERF_STATE]);
> +	index = min(index, LUT_MAX_ENTRIES - 1);
> +
> +	return c->table[index].frequency;
> +}
> +
> +static unsigned int mtk_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
> +					       unsigned int target_freq)
> +{
> +	struct cpufreq_mtk *c = policy->driver_data;
> +	unsigned int index;
> +
> +	index = cpufreq_table_find_index_dl(policy, target_freq);
> +
> +	writel_relaxed(index, c->reg_bases[REG_FREQ_PERF_STATE]);
> +
> +	return policy->freq_table[index].frequency;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *cpu_dev;
> +	struct em_data_callback em_cb = EM_DATA_CB(mtk_cpufreq_get_cpu_power);
> +	struct pm_qos_request *qos_request;
> +	int sig, pwr_hw = CPUFREQ_HW_STATUS | SVS_HW_STATUS;
> +	unsigned int latency;
> +
> +	qos_request = kzalloc(sizeof(*qos_request), GFP_KERNEL);
> +	if (!qos_request)
> +		return -ENOMEM;

Since this is temporarily required, please allocate it while you are
trying to use it.

> +
> +	cpu_dev = get_cpu_device(policy->cpu);
> +	if (!cpu_dev) {
> +		pr_err("failed to get cpu%d device\n", policy->cpu);
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
> +	latency = readl_relaxed(c->reg_bases[REG_FREQ_LATENCY]);
> +	if (!latency)
> +		latency = CPUFREQ_ETERNAL;
> +
> +	/* us convert to ns */
> +	policy->cpuinfo.transition_latency = latency * 1000;
> +
> +	policy->fast_switch_possible = true;
> +
> +	/* Let CPUs leave idle-off state for SVS CPU initializing */
> +	cpu_latency_qos_add_request(qos_request, 0);

I am not sure I understand what's going on here.

> +	/* HW should be in enabled state to proceed now */
> +	writel_relaxed(0x1, c->reg_bases[REG_FREQ_ENABLE]);
> +
> +	if (readl_poll_timeout(c->reg_bases[REG_FREQ_HW_STATE], sig,
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
> +	em_dev_register_perf_domain(cpu_dev, c->nr_opp, &em_cb, policy->cpus, true);
> +
> +	cpu_latency_qos_remove_request(qos_request);

Can this be done before em_dev_register_perf_domain() ?

> +	kfree(qos_request);
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_mtk *c;
> +
> +	c = mtk_freq_domain_map[policy->cpu];
> +	if (!c) {

This can't be NULL here.

> +		pr_err("No scaling support for CPU%d\n", policy->cpu);
> +		return -ENODEV;
> +	}
> +
> +	/* HW should be in paused state now */
> +	writel_relaxed(0x0, c->reg_bases[REG_FREQ_ENABLE]);
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
> +static int mtk_cpu_create_freq_table(struct platform_device *pdev,
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
> +	base_table = c->reg_bases[REG_FREQ_LUT_TABLE];
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
> +	c->nr_opp = i;
> +
> +	return 0;
> +}
> +
> +static int mtk_get_related_cpus(int index, struct cpufreq_mtk *c)
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
> +		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
> +						 "#performance-domain-cells", 0,
> +						 &args);
> +		of_node_put(cpu_np);
> +		if (ret < 0)
> +			continue;
> +
> +		if (index == args.args[0]) {
> +			cpumask_set_cpu(cpu, &c->related_cpus);
> +			mtk_freq_domain_map[cpu] = c;
> +		}
> +	}
> +
> +	return 0;
> +}

I really hope this can be moved to a common place as more than one
drier should be required to parse this thing.

> +static int mtk_cpu_resources_init(struct platform_device *pdev,
> +				  unsigned int cpu, int index,
> +				  const u16 *offsets)
> +{
> +	struct cpufreq_mtk *c;
> +	struct device *dev = &pdev->dev;
> +	int ret, i;
> +	void __iomem *base;
> +
> +	if (mtk_freq_domain_map[cpu])
> +		return 0;
> +
> +	c = devm_kzalloc(dev, sizeof(*c), GFP_KERNEL);
> +	if (!c)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, index);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	for (i = REG_FREQ_LUT_TABLE; i < REG_ARRAY_SIZE; i++)
> +		c->reg_bases[i] = base + offsets[i];
> +
> +	ret = mtk_get_related_cpus(index, c);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to get related CPUs\n", index);
> +		return ret;
> +	}
> +
> +	ret = mtk_cpu_create_freq_table(pdev, c);
> +	if (ret) {
> +		dev_err(dev, "Domain-%d failed to create freq table\n", index);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
> +{
> +	struct device_node *cpu_np;
> +	struct of_phandle_args args;
> +	const u16 *offsets;
> +	unsigned int cpu;
> +	int ret;
> +
> +	offsets = of_device_get_match_data(&pdev->dev);
> +	if (!offsets)
> +		return -EINVAL;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpu_np = of_cpu_device_node_get(cpu);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "Failed to get cpu %d device\n",
> +				cpu);
> +			return -ENODEV;
> +		}
> +
> +		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
> +						 "#performance-domain-cells", 0,
> +						 &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		/* Get the bases of cpufreq for domains */
> +		ret = mtk_cpu_resources_init(pdev, cpu, args.args[0], offsets);
> +		if (ret) {
> +			dev_err(&pdev->dev, "CPUFreq resource init failed\n");
> +			return ret;
> +		}
> +	}

Why don't you do above stuff in driver's ->init() ? As this really
isn't required to be done per CPU, but per policy.

> +
> +	ret = cpufreq_register_driver(&cpufreq_mtk_hw_driver);
> +	if (ret) {
> +		dev_err(&pdev->dev, "CPUFreq HW driver failed to register\n");
> +		return ret;
> +	}
> +
> +	return 0;
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
> +MODULE_DESCRIPTION("Mediatek cpufreq-hw driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 1.7.9.5

-- 
viresh
